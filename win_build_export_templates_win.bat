@echo off
setlocal

set "CURRENT_DIR=%cd%"
set "CUSTOM_PROFILE=%CURRENT_DIR%\custom_2d.py"
set "GODOT_SOURCE_DIR=%USERPROFILE%\godot"
set "OUTPUT_DIR=%CURRENT_DIR%\build"

cd /d "%GODOT_SOURCE_DIR%"

:: Release
scons profile="%CUSTOM_PROFILE%" platform=windows arch=arm64 tools=no target=template_release optimize=speed lto=full threads=yes
scons profile="%CUSTOM_PROFILE%" platform=windows arch=x86_64 tools=no target=template_release optimize=speed lto=full threads=yes

:: Debug
scons profile="%CUSTOM_PROFILE%" platform=windows arch=arm64 tools=no target=template_debug optimize=speed lto=none threads=yes
scons profile="%CUSTOM_PROFILE%" platform=windows arch=x86_64 tools=no target=template_debug optimize=speed lto=none threads=yes

:: Move to export template folder
if not exist "%OUTPUT_DIR%\export_templates" mkdir "%OUTPUT_DIR%\export_templates"
copy bin\godot_windows.zip "%OUTPUT_DIR%\export_templates\windows.zip"

:: Return to original directory
cd /d "%CURRENT_DIR%"

endlocal
