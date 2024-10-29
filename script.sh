#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests -b a14-derp .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="


# Remove overrides
# Define a list of packages to remove
echo "===== Remove overrides started ====="
OVER_PACKAGES=("Dialer" "Contacts Contacts2" "messaging" "DeskClock" "Messaging" "Contacts" "webview Browser2" "webview" "Browser2" "PicoTts" "LatinIME")
# Loop through the list and remove each package from Android.mk files
for PACKAGEU in "${OVER_PACKAGES[@]}"; do
  find vendor/gms -name 'Android.mk' -exec sed -i "/^LOCAL_OVERRIDES_PACKAGES := $PACKAGEU$/d" {} \;
done
echo "===== Remove overrides Success ====="

# Export
export BUILD_USERNAME=devil 
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch derp_Mi439_4_19-ap3a-userdebug || lunch derp_Mi439_4_19-userdebug
echo "============="
# Make cleaninstall
make installclean
echo "============="
# Build rom
mka derp
