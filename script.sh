#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b QPR3 -g default,-mips,-darwin,-notdefault
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b infinity .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="


# Export
export BUILD_USERNAME=devil
export BUILD_HOSTNAME=crave
export ALLOW_MISSING_DEPENDENCIES=true
echo ======= Export Done ======
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
. build/envsetup.sh
lunch infinity_mi439-ap2a-userdebug
lunch infinity_mi439-userdebug

# make install
make installclean

# make bacon
mka bacon
