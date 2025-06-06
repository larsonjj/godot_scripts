#!/bin/bash

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE platform=ios arch=arm64 tools=no target=template_release use_volk=no vulkan=no optimize=speed lto=full threads=yes vulkan_sdk_path="~/VulkanSDK"
scons profile=$CUSTOM_PROFILE platform=ios ios_simulator=yes arch=arm64 tools=no target=template_release use_volk=no vulkan=no optimize=speed lto=full threads=yes
scons profile=$CUSTOM_PROFILE platform=ios ios_simulator=yes arch=x86_64 tools=no target=template_release use_volk=no vulkan=no optimize=speed lto=full threads=yes

# Debug
scons profile=$CUSTOM_PROFILE platform=ios arch=arm64 tools=no target=template_debug use_volk=no vulkan=no optimize=speed lto=none threads=yes
scons profile=$CUSTOM_PROFILE platform=ios ios_simulator=yes arch=x86_64 tools=no target=template_debug use_volk=no vulkan=no optimize=speed lto=none threads=yes
scons profile=$CUSTOM_PROFILE platform=ios ios_simulator=yes arch=arm64 tools=no target=template_debug use_volk=no vulkan=no optimize=speed lto=none threads=yes generate_bundle=yes

# Move to export template folder
mkdir -p $OUTPUT_DIR/export_templates
cp bin/godot_ios_simulator.zip $OUTPUT_DIR/export_templates/ios.zip

# Return to original directory
cd $CURRENT_DIR
