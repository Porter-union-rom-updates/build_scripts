#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/RisingOS-Revived/android -b fifteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Porter-union-rom-updates/local_manifests_clo -b rise_b .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# keys
# mkdir vendor/lineage-priv
# cp build-keys/* vendor/lineage-priv
# echo "============="
# echo "Keys copied"
# echo "============="

# Export
export BUILD_USERNAME=dev_evil
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"


# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="
# Lunch
lunch lineage_mi439-userdebug || lunch lineage_mi439-ap3a-userdebug || lunch lineage_mi439-ap2a-userdebug
echo "============="

# Lunch
riseup mi439 userdebug 
echo "============="

# Build rom
rise b
