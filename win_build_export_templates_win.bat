@echo off
setlocal

set "CURRENT_DIR=%cd%"
set "CUSTOM_PROFILE=%CURRENT_DIR%\custom_2d.py"
set "CUSTOM_BUILD_PROFILE=%CURRENT_DIR%\custom_2d.profile"
set "GODOT_SOURCE_DIR=%USERPROFILE%\godot"
set "GODOT_VERSION=4.5.beta"
set "GODOT_APP_DIR=%APPDATA%\Roaming\Godot\filename"
set "OUTPUT_DIR=%GODOT_APP_DIR%/export_templates/%GODOT_VERSION%"

cd /d "%GODOT_SOURCE_DIR%"

:: Release
scons profile="%CUSTOM_PROFILE%" build_profile="%CUSTOM_BUILD_PROFILE%" platform=windows arch=x86_64 tools=no target=template_release optimize=speed lto=full threads=yes

:: Debug
scons profile="%CUSTOM_PROFILE%" build_profile="%CUSTOM_BUILD_PROFILE%" platform=windows arch=x86_64 tools=no target=template_debug optimize=speed lto=none threads=yes

:: Remove unnecessary files
del /Q /F bin\*.exp bin\*.lib bin\*.pdb

:: Move to export template folder
if not exist "%OUTPUT_DIR%\export_templates" mkdir "%OUTPUT_DIR%\export_templates"

xcopy /Y /I bin\godot.windows.*.exe "%OUTPUT_DIR%\export_templates\"

:: Return to original directory
cd /d "%CURRENT_DIR%"

endlocal
