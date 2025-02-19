#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fifteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Porter-union-rom-updates/local_manifests_rose -b PixelOS/15 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=FARHAN
export BUILD_HOSTNAME=crave 
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
source build/envsetup.sh
lunch aosp_rosy-userdebug
lunch aosp_rosy-ap4a-userdebug
make installclean 
&& mka bacon 

