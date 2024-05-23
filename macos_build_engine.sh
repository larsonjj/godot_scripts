#!/bin/bash

CURRENT_DIR=$(pwd)
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"

cd $GODOT_SOURCE_DIR

scons platform=macos arch=arm64 vulkan_sdk_path="~/VulkanSDK" tools=yes target=editor

cp -r misc/dist/macos_tools.app/* $OUTPUT_DIR/Godot.app
mkdir -p $OUTPUT_DIR/Godot.app/Contents/MacOS
cp bin/godot.macos.editor.arm64 $OUTPUT_DIR/Godot.app/Contents/MacOS/Godot
chmod +x $OUTPUT_DIR/Godot.app/Contents/MacOS/Godot
codesign --force --timestamp --options=runtime --entitlements misc/dist/macos/editor.entitlements -s - $OUTPUT_DIR/Godot.app

cd $CURRENT_DIR
