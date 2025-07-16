#!/bin/bash

# Ensure Apple Clang is used
export PATH="/usr/bin:$PATH"

CURRENT_DIR=$(pwd)
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"
CUSTOM_BUILD_PROFILE="$CURRENT_DIR/custom_2d.profile"

cd $GODOT_SOURCE_DIR

scons platform=macos arch=arm64 tools=yes target=editor production=yes build_profile=$CUSTOM_BUILD_PROFILE

cp -r misc/dist/macos_tools.app/* $OUTPUT_DIR/Godot.app
mkdir -p $OUTPUT_DIR/Godot.app/Contents/MacOS
cp bin/godot.macos.editor.arm64 $OUTPUT_DIR/Godot.app/Contents/MacOS/Godot
chmod +x $OUTPUT_DIR/Godot.app/Contents/MacOS/Godot
codesign --force --timestamp --options=runtime --entitlements misc/dist/macos/editor.entitlements -s - $OUTPUT_DIR/Godot.app

cd $CURRENT_DIR
