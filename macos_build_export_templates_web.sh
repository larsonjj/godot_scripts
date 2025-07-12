#!/bin/bash

# Ensure Apple Clang is used
export PATH="/usr/bin:$PATH"

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
CUSTOM_BUILD_PROFILE="$CURRENT_DIR/custom_2d.profile"
GODOT_SOURCE_DIR="$HOME/godot"
GODOT_VERSION="4.5.beta"
GODOT_APP_DIR="$HOME/Library/Application Support/Godot"
OUTPUT_DIR="$GODOT_APP_DIR/export_templates/$GODOT_VERSION"


cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_release tools=no javascript_eval=no use_volk=no vulkan=no debug_symbols=no optimize=size lto=full threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_release dlink_enabled=yes tools=no javascript_eval=no use_volk=no vulkan=no debug_symbols=no optimize=size lto=full threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_release tools=no javascript_eval=no use_volk=no vulkan=no debug_symbols=no optimize=size lto=full threads=yes linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_release dlink_enabled=yes tools=no javascript_eval=no use_volk=no vulkan=no debug_symbols=no optimize=size lto=full threads=yes linkflags="-Wl,-u,htonl"

# Debug
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_debug tools=no javascript_eval=no use_volk=no vulkan=no optimize=size lto=none threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_debug dlink_enabled=yes tools=no javascript_eval=no use_volk=no vulkan=no optimize=size lto=none threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_debug tools=no javascript_eval=no use_volk=no vulkan=no optimize=size lto=none threads=yes linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE build_profile=$CUSTOM_BUILD_PROFILE platform=web target=template_debug dlink_enabled=yes tools=no javascript_eval=no use_volk=no vulkan=no optimize=size lto=none threads=yes linkflags="-Wl,-u,htonl"

# Move to export template folder
mkdir -p "$OUTPUT_DIR"
cp bin/godot.web.template_debug.wasm32.zip "$OUTPUT_DIR/web_debug.zip"
cp bin/godot.web.template_debug.wasm32.dlink.zip "$OUTPUT_DIR/web_dlink_debug.zip"
cp bin/godot.web.template_debug.wasm32.nothreads.zip "$OUTPUT_DIR/web_nothreads_debug.zip"
cp bin/godot.web.template_debug.wasm32.nothreads.dlink.zip "$OUTPUT_DIR/web_dlink_nothreads_debug.zip"
cp bin/godot.web.template_release.wasm32.zip "$OUTPUT_DIR/web_release.zip"
cp bin/godot.web.template_release.wasm32.dlink.zip "$OUTPUT_DIR/web_dlink_release.zip"
cp bin/godot.web.template_release.wasm32.nothreads.zip "$OUTPUT_DIR/web_nothreads_release.zip"
cp bin/godot.web.template_release.wasm32.nothreads.dlink.zip "$OUTPUT_DIR/web_dlink_nothreads_release.zip"

# Return to original directory
cd "$CURRENT_DIR"
