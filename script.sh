#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/ProjectMatrixx/android.git -b 14.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b Matrixx/14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

#Cherry-pick
cd vendor/addons
git fetch crdroid --unshallow
git fetch https://github.com/RisingTechOSS/android_vendor_addons fourteen
git cherry-pick dbd659e
cd ../..

# Private keys
#git clone https://github.com/Gtajisan/vendor_lineage-priv_keys.git vendor/lineage-priv/keys
#echo "===== cp clone done ====="

# Export
export BUILD_USERNAME=FARHAN_UN
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Lunch  
. build/envsetup.sh




