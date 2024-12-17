#!/bin/bash

rm -rf .repo/local_manifests/




# Initialize local repository
repo init -u https://github.com/alphadroid-project/manifest -b alpha-14 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests -b alpha/14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=FARHAN•AFK
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch 
lunch lineage_Mi439_4_19-ap2a-userdebug
make installclean
mka bacon
