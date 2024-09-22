#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom

repo init -u https://github.com/sigmadroid-project/manifest -b sigma-14.3 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b sigma/14 --depth=1 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh && repo sync
echo "============="
echo "Sync success"
echo "============="

# Private keys
git clone https://github.com/Gtajisan/vendor_lineage-priv_keys.git vendor/lineage-priv/keys

# Export
export BUILD_USERNAME=FARHAN
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
TARGET_PRODUCT=lineage_mi439
export TARGET_BUILD_VARIANT=userdebug
lunch sigma_mi439-userdebug
lunch sigma_mi439-ap2a
lunch sigma_mi439-ap2a-userdebug
brunch mi439
lunch sigma_mi439

make installclean
echo "============="

# Build ROM
make bacon
