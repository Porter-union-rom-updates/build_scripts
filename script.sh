
#!/bin/bash

rm -rf .repo/local_manifests/

repo init -u https://github.com/bananadroid/android_manifest.git -b 14 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests_clo -b Bananadroid/14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=devil
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"


# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# lunch fumking
. build/envsetup.sh
lunch banana_mi439-userdebug
lunch banana_mi439-ap1a-userdebug || lunch banana_mi439-ap3a-userdebug || lunch banana_mi439-ap2a-userdebug
m banana



