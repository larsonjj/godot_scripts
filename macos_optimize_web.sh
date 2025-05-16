#!/bin/bash

WEB_BUILD_DIR=""

if [ -z "$1" ]
then
    WEB_BUILD_DIR="."
else
    WEB_BUILD_DIR="$1"
fi

echo "Optimizing Web Build in $WEB_BUILD_DIR"

wasm-opt $WEB_BUILD_DIR/index.wasm -o index.wasm --enable-bulk-memory --enable-exception-handling --enable-simd -O --intrinsic-lowering -O && brotli $WEB_BUILD_DIR/index.wasm $WEB_BUILD_DIR/index.html $WEB_BUILD_DIR/index.js $WEB_BUILD_DIR/index.audio.worklet.js -f
