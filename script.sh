#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init --depth=1 -u https://github.com/AfterlifeOS/android_manifest.git -b 14 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests -b afterlife .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

#  remove error 
rm -rf external/chromium-webview  
echo "======= remove Done ======"

#  fix error 
rm -rf packages/apps/ParanoidSense
echo "=======  Done ======"

# Export
export BUILD_USERNAME=unlucky 
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# lunch 
. build/envsetup.sh
lunch afterlife_Mi439_4_19-userdebug
m afterlife -j$
m afterlife 
