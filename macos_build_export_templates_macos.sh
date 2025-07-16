#!/bin/bash

# Ensure Apple Clang is used
export PATH="/usr/bin:$PATH"

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
CUSTOM_BUILD_PROFILE="$CURRENT_DIR/custom_2d.profile"
GODOT_SOURCE_DIR="$HOME/godot"
GODOT_VERSION="4.5.beta"
GODOT_APP_DIR="$HOME/Library/Application Support/Godot"
OUTPUT_DIR="$GODOT_APP_DIR/export_templates/$GODOT_VERSION"


cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=macos arch=arm64 tools=no production=yes target=template_release debug_symbols=no use_volk=no vulkan=no optimize=speed lto=full threads=yes

# Debug
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=macos arch=arm64 tools=no production=yes target=template_debug use_volk=no vulkan=no optimize=speed lto=none threads=yes

# Move to export template folder
mkdir -p "$OUTPUT_DIR"
cp bin/godot_macos.zip "$OUTPUT_DIR/macos.zip"

# Return to original directory
cd $CURRENT_DIR
