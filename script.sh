#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Porter-union-rom-updates/local_manifests_rose -b Evo/15x .repo/local_manifests
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
#export BUILD_USERNAME=FARHAN 
#export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Atiga Trees 
git clone https://github.com/Gtajisan/device_xiaomi_rosy -b Evo/15 device/xiaomi/rosy


# key
#git clone https://github.com/Evolution-X/vendor_evolution-priv_keys-template vendor/evolution-priv/keys
#cd vendor/evolution-priv/keys
#./keys.sh
#cd ../../..

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_rosy-userdebug || lunch lineage_rosy-ap3a-userdebug || lunch lineage_rosy-ap2a-userdebug
echo "============="

# Make cleaninstall
lunch lineage_rosy-ap4a-userdebug
make installclean
echo "============="

# bacon
m evolution

