#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Project-PixelStar/manifest -b 14-qpr3 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_co -b pixelstar/14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Use AOSP clang for no errors thanks trijal kido.
rm -r prebuilts/clang/host/linux-x86
git clone https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86 prebuilts/clang/host/linux-x86
echo "===== fix  AOSP clang for no errors ====="

# Git cherry-pick
cd vendor/lineage
git remote add los https://github.com/LineageOS/android_vendor_lineage
git fetch los
git cherry-pick 198966577ace63573e5be49e03a2e59e32997054
cd ../..
echo "===== Cherry-picking Success ====="

# Private keys
git clone https://github.com/Gtajisan/vendor_lineage-priv_keys.git vendor/lineage-priv/keys
echo "===== cp clone done ====="

# Export
export BUILD_USERNAME=FARHAN_UN
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh 
echo "====== Envsetup Done ======="

# Lunch
lunch pixelstar_Mi439_4_19-ap2a-userdebug
echo "====== lunch Done ======="

# installclean
make installclean
mka bacon
