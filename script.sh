#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/ProjectEverest/manifest -b 14 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo --depth 1 -b Everest/14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=devil
export BUILD_HOSTNAME=crave 
export BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh 
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_mi439-ap2a-userdebug
breakfast mi439 userdebug
. build/envsetup.sh
brunch mi439
echo "============="

# Build rom
mka everest 
