#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 

# Init Rom Manifest
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

# Clone local_manifests repository
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-avc1-viperfx .repo/local_manifests
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15-crdroid-mithorium .repo/local_manifests 

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# Sync the repositories  
# /opt/crave/resync.sh 
/opt/crave/resynctest.sh

# Ty Crave 
cd packages/apps/Settings
git remote add tmpRepo https://github.com/tavukkdoner/android_packages_apps_Settings
git fetch tmpRepo 15.0
git cherry-pick 860634b
git cherry-pick 30ec96a
# https://github.com/crdroidandroid/android_packages_apps_Settings/commit/c6fdcc764c038007993045dfd5cb17999ebf00fb
git revert c6fdcc7
git remote remove tmpRepo
cd ../../../

cd lineage-sdk
git remote add tmpRepo1 https://github.com/tavukkdoner/android_lineage-sdk
git fetch tmpRepo1 15.0
git cherry-pick a3743d1
git remote remove tmpRepo1
cd ../

cd vendor/lineage
git remote add tmpRepo2 https://github.com/tavukkdoner/android_vendor_crdroid
git fetch tmpRepo2 15.0
git cherry-pick 2597054
git remote remove tmpRepo2
#git remote add tmpRepo4 https://github.com/LineageOS/android_vendor_lineage
#git fetch tmpRepo4 lineage-22.0
#git cherry-pick d6777fa
#git remote remove tmpRepo4
cd ../../

#cd build/soong
#git remote add tmpRepo3 https://github.com/LineageOS/android_build_soong
#git fetch tmpRepo3 lineage-22.0
#git cherry-pick 9d6c7dc
#git remote remove tmpRepo3
#cd ../../

# Set up build environment
export BUILD_USERNAME=devil 
export BUILD_HOSTNAME=crave 

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi
 
# Build the ROM
# lunch lineage_Mi439-ap2a-userdebug && make installclean && mka bacon

# Build the ROM
# lunch lineage_Mi439_4_19-ap2a-userdebug && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/402103
lunch lineage_Mi439_4_19-ap3a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-ap3a-eng && make installclean && mka bacon
