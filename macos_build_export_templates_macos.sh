#!/bin/bash

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"
VULKAN_SDK_DIR="$HOME/VulkanSDK"

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE platform=macos arch=arm64 tools=no target=template_release optimize=speed lto=full threads=yes vulkan_sdk_path="$VULKAN_SDK_DIR"
scons profile=$CUSTOM_PROFILE platform=macos arch=x86_64 tools=no target=template_release optimize=speed lto=full threads=yes vulkan_sdk_path="$VULKAN_SDK_DIR"

# Debug
scons profile=$CUSTOM_PROFILE platform=macos arch=arm64 tools=no target=template_debug optimize=speed lto=none threads=yes vulkan_sdk_path="$VULKAN_SDK_DIR"
scons profile=$CUSTOM_PROFILE platform=macos arch=x86_64 tools=no target=template_debug optimize=speed lto=none threads=yes vulkan_sdk_path="$VULKAN_SDK_DIR" generate_bundle=yes

# Move to export template folder
mkdir -p $OUTPUT_DIR/export_templates
cp bin/godot_macos.zip $OUTPUT_DIR/export_templates/macos.zip

# Return to original directory
cd $CURRENT_DIR
