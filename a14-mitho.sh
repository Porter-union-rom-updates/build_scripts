#!/bin/bash

rm -rf .repo/local_manifests/
# repo init
repo init -u https://github.com/Spark-Rom/manifest -b pyro-next
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Gtajisan/local_manifests -b 13/spark .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh && repo sync --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
echo "============="
echo "Sync success"
echo "============="


# Export
export BUILD_USERNAME=devil 
export BUILD_HOSTNAME=crave
#export MITHORIUM_QCOM_HALS_DEFAULT_VARIANT=LA.UM.9.6.4.r1-05500-89xx.QSSI13.0
echo "======= Export Done ======"


# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# lunch 
lunch spark_Mi439_4_19-userdebug
make installclean
mka bacon 
