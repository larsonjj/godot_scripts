#!/bin/bash

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE platform=linux arch=arm64 tools=no target=template_release optimize=speed lto=full threads=yes
scons profile=$CUSTOM_PROFILE platform=linux arch=x86_64 tools=no target=template_release optimize=speed lto=full threads=yes

# Debug
scons profile=$CUSTOM_PROFILE platform=linux arch=arm64 tools=no target=template_debug optimize=speed lto=none threads=yes
scons profile=$CUSTOM_PROFILE platform=linux arch=x86_64 tools=no target=template_debug optimize=speed lto=none threads=yes generate_bundle=yes

# Move to export template folder
mkdir -p $OUTPUT_DIR/export_templates
cp bin/godot_linux.zip $OUTPUT_DIR/export_templates/linux.zip

# Return to original directory
cd $CURRENT_DIR
