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

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Ty Crave full credit tavukkdoner
cd packages/apps/Settings
git remote add tmpRepo https://github.com/tavukkdoner/android_packages_apps_Settings
git fetch tmpRepo 14.0
git cherry-pick 75c8e07
git cherry-pick 7ecc750
# https://github.com/crdroidandroid/android_packages_apps_Settings/commit/8ae1b733443d0aecacef1f64f2e020c95e42ca22
git revert 8ae1b73
git remote remove tmpRepo
cd ../../../
# extra 
Rinto:
git fetch https://github.com/Gtajisan/android_packages_apps_Settings
git cherry-pick 3dd2f59
git cherry-pick 06ca759

cd lineage-sdk
git remote add tmpRepo1 https://github.com/tavukkdoner/android_lineage-sdk
git fetch tmpRepo1 14.0
git cherry-pick 89ef794
git remote remove tmpRepo1
cd ../

cd vendor/lineage
git remote add tmpRepo2 https://github.com/tavukkdoner/android_vendor_crdroid
git fetch tmpRepo2 14.0
git cherry-pick 40fe82e
git remote remove tmpRepo2
cd ../../

#if [ ! -e "vendor/lineage-priv" ]; then
#    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
#    chmod +x create-signed-env.sh
#    ./create-signed-env.sh
#fi

# Export
#export BUILD_USERNAME=Farhan 
#echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="
# Build the ROM
lunch lineage_Mi439_4_19-ap2a-userdebug && make installclean && mka bacon

