#!/bin/bash

rm -rf .repo/local_manifests/
echo "===== hey Farhan sir your fukin& rom running ====="

# repo init rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14
echo "=============================="
echo "gay DerpFest Repo init success"
echo "=============================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b udc-2-derp .repo/local_manifests
echo "========================================="
echo "Fuckin# shit Local manifest clone success"
echo "========================================="

# build
/opt/crave/resync.sh
echo "======================"
echo "Sync successfully Done"
echo "======================"

# keys
git clone https://github.com/DerpFest-AOSP/vendor_derp.git -b 14 vendor_derp
cp vendor_derp/* signing/keys
echo "============="
echo "Keys copied"
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
export BUILD_USERNAME=FARHAN_shit
export BUILD_HOSTNAME=crave
echo "============="

# Set up build environment
source build/envsetup.sh
echo "======================================"
echo "im craven Farhan sir you rom sync Done"
echo "======================================"
# Setup Git LFS
# repo forall -c 'git lfs install && git lfs pull && git lfs checkout'

# Lunch
lunch derp_mi439-ap1a-userdebug || lunch derp_mi439-userdebug
echo "============="

# Make cleaninstall
make installclean
echo "============="

# Build rom
mka derp
