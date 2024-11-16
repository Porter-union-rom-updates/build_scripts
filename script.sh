#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/TenX-OS/manifest.git -b fourteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b TenX/15 .repo/local_manifests
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

# ... now run
. build/envsetup.sh
brunch Mi439_4_19
brunch Mi439_4_19 userdebug 
