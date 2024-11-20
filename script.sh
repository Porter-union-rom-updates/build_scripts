#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Project-PixelStar/manifest -b 14-qpr3 --git-lfs 
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b pixelstar/14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=FARHAN_UN
export BUILD_HOSTNAME=crave
export ALLOW_MISSING_DEPENDENCIES=true
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh 
echo "====== Envsetup Done ======="

# Lunch
lunch pixelstar_mi439-ap2a-userdebug
lunch pixelstar_mi439-userdebug
echo "====== lunch Done ======="

# installclean
make installclean
mka bacon
