#!/bin/bash

CURRENT_DIR=$(pwd)
CUSTOM_PROFILE="$CURRENT_DIR/custom_2d.py"
GODOT_SOURCE_DIR="$HOME/godot"
OUTPUT_DIR="$CURRENT_DIR/build"

cd $GODOT_SOURCE_DIR

# Release
scons profile=$CUSTOM_PROFILE platform=web target=template_release tools=no javascript_eval=no optimize=size lto=full threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE platform=web target=template_release dlink_enabled=yes tools=no javascript_eval=no optimize=size lto=full threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE platform=web target=template_release tools=no javascript_eval=no optimize=size lto=full threads=yes linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE platform=web target=template_release dlink_enabled=yes tools=no javascript_eval=no optimize=size lto=full threads=yes linkflags="-Wl,-u,htonl"

# Debug
scons profile=$CUSTOM_PROFILE platform=web target=template_debug tools=no javascript_eval=no optimize=size lto=none threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE platform=web target=template_debug dlink_enabled=yes tools=no javascript_eval=no optimize=size lto=none threads=no linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE platform=web target=template_debug tools=no javascript_eval=no optimize=size lto=none threads=yes linkflags="-Wl,-u,htonl"
scons profile=$CUSTOM_PROFILE platform=web target=template_debug dlink_enabled=yes tools=no javascript_eval=no optimize=size lto=none threads=yes linkflags="-Wl,-u,htonl"

# Move to export template folder
mkdir -p $OUTPUT_DIR/export_templates
cp bin/godot.web.template_debug.wasm32.zip $OUTPUT_DIR/export_templates/web_debug.zip
cp bin/godot.web.template_debug.wasm32.dlink.zip $OUTPUT_DIR/export_templates/web_dlink_debug.zip
cp bin/godot.web.template_debug.wasm32.nothreads.zip $OUTPUT_DIR/export_templates/web_nothreads_debug.zip
cp bin/godot.web.template_debug.wasm32.nothreads.dlink.zip $OUTPUT_DIR/export_templates/web_dlink_nothreads_debug.zip
cp bin/godot.web.template_release.wasm32.zip $OUTPUT_DIR/export_templates/web_release.zip
cp bin/godot.web.template_release.wasm32.dlink.zip $OUTPUT_DIR/export_templates/web_dlink_release.zip
cp bin/godot.web.template_release.wasm32.nothreads.zip $OUTPUT_DIR/export_templates/web_nothreads_release.zip
cp bin/godot.web.template_release.wasm32.nothreads.dlink.zip $OUTPUT_DIR/export_templates/web_dlink_nothreads_release.zip

# Return to original directory
cd $CURRENT_DIR
