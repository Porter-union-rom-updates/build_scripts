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

#Framework_base patches credits by phantom 
cd frameworks/base
git fetch crdroid --unshallow
git fetch https://github.com/RisingTechOSS/android_frameworks_base fourteen
#Force LTA CA
git cherry-pick 9756c4c
#Downgrade
git cherry-pick ba93896
cd ../..

#toggle for LTE CA
cd packages/apps/Settings
git fetch crdroid --unshallow
git fetch https://github.com/RisingTechOSS/android_packages_apps_Settings fourteen
git cherry-pick 041f5f0
cd ../../..

#json support for PIF
cd frameworks/base
git fetch https://github.com/PhantomEnigma/android_frameworks_base 14.0
git cherry-pick b8c1f87
git cherry-pick 5d03127
cd ../..

# extra 
git fetch https://github.com/Gtajisan/android_packages_apps_Settings
git cherry-pick 3dd2f59
git cherry-pick 06ca759

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
