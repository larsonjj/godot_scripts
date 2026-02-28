@echo off
setlocal

set CURRENT_DIR=%CD%
set CUSTOM_PROFILE=%CURRENT_DIR%\custom_2d_templates.py
set CUSTOM_BUILD_PROFILE=%CURRENT_DIR%\custom_2d_template.build
set GODOT_SOURCE_DIR=%USERPROFILE%\godot
set GODOT_VERSION=4.6.1.stable
set GODOT_APP_DIR=%APPDATA%\Godot
set OUTPUT_DIR=%GODOT_APP_DIR%\export_templates\%GODOT_VERSION%


cd /d %GODOT_SOURCE_DIR%

:: Release
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_release tools=no production=yes javascript_eval=no debug_symbols=no optimize=size lto=full threads=no linkflags="-Wl,-u,htonl"
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_release dlink_enabled=yes tools=no production=yes javascript_eval=no debug_symbols=no optimize=size lto=full threads=no linkflags="-Wl,-u,htonl"
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_release tools=no production=yes javascript_eval=no debug_symbols=no optimize=size lto=full threads=yes linkflags="-Wl,-u,htonl"
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_release dlink_enabled=yes tools=no production=yes javascript_eval=no debug_symbols=no optimize=size lto=full threads=yes linkflags="-Wl,-u,htonl"

:: Debug
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_debug tools=no production=yes javascript_eval=no optimize=size lto=none threads=no linkflags="-Wl,-u,htonl"
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_debug dlink_enabled=yes tools=no production=yes javascript_eval=no optimize=size lto=none threads=no linkflags="-Wl,-u,htonl"
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_debug tools=no production=yes javascript_eval=no optimize=size lto=none threads=yes linkflags="-Wl,-u,htonl"
scons profile=%CUSTOM_PROFILE% build_profile=%CUSTOM_BUILD_PROFILE% platform=web target=template_debug dlink_enabled=yes tools=no production=yes javascript_eval=no optimize=size lto=none threads=yes linkflags="-Wl,-u,htonl"

:: Move to export template folder
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"
copy bin\godot.web.template_debug.wasm32.zip "%OUTPUT_DIR%\web_debug.zip"
copy bin\godot.web.template_debug.wasm32.dlink.zip "%OUTPUT_DIR%\web_dlink_debug.zip"
copy bin\godot.web.template_debug.wasm32.nothreads.zip "%OUTPUT_DIR%\web_nothreads_debug.zip"
copy bin\godot.web.template_debug.wasm32.nothreads.dlink.zip "%OUTPUT_DIR%\web_dlink_nothreads_debug.zip"
copy bin\godot.web.template_release.wasm32.zip "%OUTPUT_DIR%\web_release.zip"
copy bin\godot.web.template_release.wasm32.dlink.zip "%OUTPUT_DIR%\web_dlink_release.zip"
copy bin\godot.web.template_release.wasm32.nothreads.zip "%OUTPUT_DIR%\web_nothreads_release.zip"
copy bin\godot.web.template_release.wasm32.nothreads.dlink.zip "%OUTPUT_DIR%\web_dlink_nothreads_release.zip"

:: Return to original directory
cd /d "%CURRENT_DIR%"

endlocal
