#!/bin/bash

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE platform=android arch=arm64 generate_apk=yes tools=no target=template_release optimize=speed lto=full threads=yes

# Debug
scons profile=$CUSTOM_PROFILE platform=android arch=arm64 generate_apk=yes tools=no target=template_debug optimize=speed lto=none threads=yes

# Move to export template folder
mkdir -p $OUTPUT_DIR/export_templates
cp bin/android_debug.apk $OUTPUT_DIR/export_templates/android_debug.apk
cp bin/android_release.apk $OUTPUT_DIR/export_templates/android_release.apk
cp bin/android_source.zip $OUTPUT_DIR/export_templates/android_source.zip

# Return to original directory
cd $CURRENT_DIR
