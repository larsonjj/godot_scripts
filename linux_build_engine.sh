#!/bin/bash

CURRENT_DIR=$(pwd)
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"

cd $GODOT_SOURCE_DIR

scons platform=linux arch=arm64

cp bin/godot.linux.editor.arm64 $OUTPUT_DIR/

cd $CURRENT_DIR
