#!/bin/bash

# Ensure Apple Clang is used
export PATH="/usr/bin:$PATH"

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
CUSTOM_BUILD_PROFILE="$CURRENT_DIR/custom_2d.profile"
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=ios arch=arm64 tools=no target=template_release debug_symbols=no use_volk=no vulkan=no optimize=speed lto=full threads=yes
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=ios ios_simulator=yes arch=arm64 tools=no target=template_release debug_symbols=no use_volk=no vulkan=no optimize=speed lto=full threads=yes
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=ios ios_simulator=yes arch=x86_64 tools=no target=template_release debug_symbols=no use_volk=no vulkan=no optimize=speed lto=full threads=yes

# Debug
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=ios arch=arm64 tools=no target=template_debug use_volk=no vulkan=no optimize=speed lto=none threads=yes
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=ios ios_simulator=yes arch=x86_64 tools=no target=template_debug use_volk=no vulkan=no optimize=speed lto=none threads=yes
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=ios ios_simulator=yes arch=arm64 tools=no target=template_debug use_volk=no vulkan=no optimize=speed lto=none threads=yes generate_bundle=yes

# Move to export template folder
mkdir -p $OUTPUT_DIR/export_templates
cp bin/godot_ios_simulator.zip $OUTPUT_DIR/export_templates/ios.zip

# Return to original directory
cd $CURRENT_DIR
