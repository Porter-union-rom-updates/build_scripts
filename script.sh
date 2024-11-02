#!/bin/bash

rm -rf .repo/local_manifests/

repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests -b 14/crd .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Local manifests
git clone https://github.com/Gtajisan/local_manifests -b a14-crd .repo/local_manifests
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
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_Mi439_4_19-userdebug || lunch lineage_Mi439_4_19-ap3a-userdebug || lunch lineage_Mi439_4_19-ap2a-userdebug
echo "============="

# Make cleaninstall
make installclean && mka bacon
echo "============="
