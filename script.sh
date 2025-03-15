#matrixx build script
#!/bin/bash

# Remove existing local_manifests
echo "Removing existing local_manifests..."
rm -rf .repo/local_manifests/ || { echo "Failed to remove local_manifests"; exit 1; }

# Initialize matrixx repo
echo "Initializing LineageOS_gsi repo..."
repo init -u https://github.com/MisterZtr/LineageOS-android.git -b lineage-22.1 --git-lfs || { echo "Repo init failed"; exit 1; }

# Clone local_manifests repository
echo "Cloning local_manifests repository..."
git clone https://github.com/MisterZtr/treble_manifest.git .repo/local_manifests  -b 15-los || { echo "Cloning local_manifests failed"; exit 1; }

# Sync the repositories
echo "Syncing the repositories..."
/opt/crave/resync.sh || { echo "Resync failed"; exit 1; }



# Set build details
export BUILD_USERNAME=gsi_hunt
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true



# Set up build environment
echo "Setting up build environment..."
. build/envsetup.sh || { echo "Envsetup failed"; exit 1; }

# Lunch configuration
echo "Configuring lunch..."
lunch treble_arm64_bN-ap2a-userdebug || { echo "Lunch configuration failed"; exit 1; }

# Build the matrixx
echo "LineageOS_gsi..."
make systemimage || { echo "Build failed"; exit 1; }

echo "LineageOS_gsi Build completed successfully!"
