#!/bin/bash

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
CUSTOM_BUILD_PROFILE="$CURRENT_DIR/custom_2d_template.build"
GODOT_SOURCE_DIR="$HOME/godot"
GODOT_VERSION="4.6.1.stable"
GODOT_APP_DIR="$HOME/.config/Godot"
OUTPUT_DIR="$GODOT_APP_DIR/export_templates/$GODOT_VERSION"

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=linux arch=arm64 tools=no production=yes target=template_release optimize=speed lto=full threads=yes
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=linux arch=x86_64 tools=no production=yes target=template_release optimize=speed lto=full threads=yes

# Debug
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=linux arch=arm64 tools=no target=template_debug optimize=speed lto=none threads=yes
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=linux arch=x86_64 tools=no target=template_debug optimize=speed lto=none threads=yes generate_bundle=yes

# Move to export template folder
mkdir -p "$OUTPUT_DIR"
cp bin/godot_linux.zip "$OUTPUT_DIR/linux.zip"

# Return to original directory
cd $CURRENT_DIR
