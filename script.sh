#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b Evo/15 .repo/local_manifests
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
export BUILD_USERNAME=FARHAN 
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_mi439-userdebug || lunch lineage_mi439-ap3a-userdebug || lunch lineage_mi439-ap2a-userdebug
echo "============="

# Make cleaninstall
lunch lineage_mi439-ap4a-userdebug
make installclean
echo "============="

# bacon
m evolution

