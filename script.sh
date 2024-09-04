#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b RisingOS .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# cherry pick 1
https://github.com/BlissRoms/platform_manifest/blob/universe/bliss.xml#L66
cd hardware/interfaces
git remote add bliss https://github.com/BlissRoms/platform_hardware_interfaces
git fetch bliss
git cherry-pick bbb2b5846645749fe3b778c1e50ac55378fd6235
cd ../..

# check pick 2
https://github.com/BlissRoms/platform_manifest/blob/universe/bliss.xml#L73C18-L73C32
cd kernel/configs
git remote add bliss1 https://github.com/BlissRoms/platform_kernel_configs
git fetch bliss1
git cherry-pick 5da1af4336121276bd65437e329c95c770923a35
cd ../..

# Export
export BUILD_USERNAME=FARHAN_UN
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh 
echo "====== Envsetup Done ======="

# Lunch
riseup mi439 userdebug
echo "============="

# Build rom
rise b

