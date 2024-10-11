#!/bin/bash

# Remove existing local_manifests
rm -rf .repo/local_manifests/

# Initialize git lfs
git lfs install

# repo init manifest
repo init -u https://github.com/OrionOS-prjkt/android -b 14.0 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b orion/14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh && repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
echo "============="
echo "Sync success"
echo "============="

# Private keys
git clone https://github.com/Trijal08/vendor_lineage-priv_keys.git vendor/lineage-priv/keys

# Export
export BUILD_USERNAME="FARHAN • OrionStarsInTheSky"
export BUILD_HOSTNAME="crave"
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
breakfast mi439 userdebug
make installclean -j$(nproc --all)
echo "============="

# Build ROM
croot
brunch mi439 userdebug







