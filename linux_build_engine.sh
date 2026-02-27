#!/bin/bash

CURRENT_DIR=$(pwd)
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"
CUSTOM_BUILD_PROFILE="$CURRENT_DIR/custom_2d_editor.build"
CUSTOM_EDITOR_PROFILE="$CURRENT_DIR/custom_2d.profile"
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"  # Add this line

cd $GODOT_SOURCE_DIR

scons profile=$CUSTOM_PROFILE platform=linux arch=arm64 tools=yes target=editor production=yes build_profile=$CUSTOM_BUILD_PROFILE editor_build_profile=$CUSTOM_EDITOR_PROFILE

mkdir -p $OUTPUT_DIR
cp -r bin/godot.linux*.editor.arm64 $OUTPUT_DIR/

cd $CURRENT_DIR
