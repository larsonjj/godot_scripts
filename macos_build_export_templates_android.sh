#!/bin/bash

# Ensure Apple Clang is used
export PATH="/usr/bin:$PATH"

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
CUSTOM_BUILD_PROFILE="$CURRENT_DIR/custom_2d_template.build"
GODOT_SOURCE_DIR="$HOME/godot"
GODOT_VERSION="4.6.stable"
GODOT_APP_DIR="$HOME/Library/Application Support/Godot"
OUTPUT_DIR="$GODOT_APP_DIR/export_templates/$GODOT_VERSION"


# Function to download latest godot-swappy release
download_godot_swappy() {
    echo "Downloading godot-swappy release..."

    # Create vendor directory if it doesn't exist
    mkdir -p "$CURRENT_DIR/vendor"

    # Direct download URL for the specific release
    RELEASE_URL="https://github.com/godotengine/godot-swappy/releases/download/from-source-2025-01-31/godot-swappy.zip"

     # Download and extract
    cd "$CURRENT_DIR/vendor"
    curl -L -o godot-swappy.zip "$RELEASE_URL"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to download godot-swappy.zip"
        return 1
    fi

    # Remove existing directory if it exists
    rm -rf godot-swappy

    # Create the target directory
    mkdir -p godot-swappy

    # Extract the zip file directly into the godot-swappy directory
    unzip -q godot-swappy.zip -d godot-swappy

    # Check if extraction was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to extract godot-swappy.zip"
        return 1
    fi

    # If the zip extracted into a subdirectory, move contents up one level
    SUBDIRS=$(find godot-swappy -maxdepth 1 -type d | wc -l)
    if [ $SUBDIRS -eq 2 ]; then  # Only one subdirectory (plus the parent)
        SUBDIR=$(find godot-swappy -maxdepth 1 -type d | grep -v "^godot-swappy$" | head -1)
        if [ -n "$SUBDIR" ]; then
            mv "$SUBDIR"/* godot-swappy/
            rmdir "$SUBDIR"
        fi
    fi

    # Clean up
    rm godot-swappy.zip

    cd "$CURRENT_DIR"
    echo "godot-swappy downloaded and extracted successfully."
}

# Download godot-swappy if vendor directory doesn't exist
VENDOR_SWAPPY_SOURCE="$CURRENT_DIR/vendor/godot-swappy"
if [ ! -d "$VENDOR_SWAPPY_SOURCE" ]; then
    download_godot_swappy
fi

# Copy vendor/godot-swappy to godot thirdparty directory if it doesn't exist
# This is necessary for Android builds to ensure Swappy is available.
VENDOR_SWAPPY_TARGET="$GODOT_SOURCE_DIR/thirdparty/swappy-frame-pacing"
VENDOR_SWAPPY_TARGET_CHECK="$GODOT_SOURCE_DIR/thirdparty/swappy-frame-pacing/arm64-v8a"

if [ -d "$VENDOR_SWAPPY_SOURCE" ] && [ ! -d "$VENDOR_SWAPPY_TARGET_CHECK" ]; then
    echo "Copying vendor/godot-swappy architecture folders to Godot thirdparty directory..."

    # Create target directory if it doesn't exist
    mkdir -p "$VENDOR_SWAPPY_TARGET"

    # Copy only the specific architecture folders
    for arch in arm64-v8a armeabi-v7a x86 x86_64; do
        if [ -d "$VENDOR_SWAPPY_SOURCE/$arch" ]; then
            cp -r "$VENDOR_SWAPPY_SOURCE/$arch" "$VENDOR_SWAPPY_TARGET/"
            echo "Copied $arch folder"
        else
            echo "Warning: $arch folder not found in vendor/godot-swappy"
        fi
    done

    echo "vendor/godot-swappy architecture folders copied successfully."
elif [ ! -d "$VENDOR_SWAPPY_SOURCE" ]; then
    echo "Warning: vendor/godot-swappy not found."
elif [ -d "$VENDOR_SWAPPY_TARGET_CHECK" ]; then
    echo "vendor/godot-swappy already exists in Godot thirdparty directory."
fi

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=android arch=arm64 production=yes generate_apk=yes tools=no debug_symbols=no target=template_release optimize=speed lto=full threads=yes

# Debug
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=android arch=arm64 generate_apk=yes tools=no target=template_debug optimize=speed lto=none threads=yes

# Move to export template folder
mkdir -p "$OUTPUT_DIR"
cp bin/android_debug.apk "$OUTPUT_DIR/android_debug.apk"
cp bin/android_release.apk "$OUTPUT_DIR/android_release.apk"
cp bin/android_source.zip "$OUTPUT_DIR/android_source.zip"

# Return to original directory
cd $CURRENT_DIR
