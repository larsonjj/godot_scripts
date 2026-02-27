@echo off
setlocal

set "CURRENT_DIR=%cd%"
set "CUSTOM_PROFILE=%CURRENT_DIR%\custom_2d.py"
set "CUSTOM_BUILD_PROFILE=%CURRENT_DIR%\custom_2d_template.build"
set "GODOT_SOURCE_DIR=%USERPROFILE%\godot"
set "GODOT_VERSION=4.6.1.stable"
set "GODOT_APP_DIR=%APPDATA%\Godot"
set "OUTPUT_DIR=%GODOT_APP_DIR%\export_templates\%GODOT_VERSION%"

cd /d "%GODOT_SOURCE_DIR%"

:: Release
scons profile="%CUSTOM_PROFILE%" build_profile="%CUSTOM_BUILD_PROFILE%" platform=windows arch=x86_64 tools=no target=template_release optimize=speed lto=full threads=yes

:: Debug
scons profile="%CUSTOM_PROFILE%" build_profile="%CUSTOM_BUILD_PROFILE%" platform=windows arch=x86_64 tools=no target=template_debug optimize=speed lto=none threads=yes

:: Remove unnecessary files
del /Q /F bin\*.exp bin\*.lib bin\*.pdb

:: Print the contents of the bin directory for verification
echo Contents of bin directory:
dir bin\godot.windows.templates*.exe

:: Print the output directory for verification
echo Output directory: "%OUTPUT_DIR%"

:: Ensure the output directory exists
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Rename the copied files to match Godot's expected naming convention
for %%f in ("bin\godot.windows.template*.exe") do (
    if "%%~nxf"=="godot.windows.template_release.x86_64.exe" (
        :: Rename the file to match Godot's expected naming convention and overwrite if it already exists
        move /Y "%%f" "bin\windows_release_x86_64.exe"
    ) else if "%%~nxf"=="godot.windows.template_debug.x86_64.exe" (
        :: Rename the file to match Godot's expected naming convention and overwrite if it already exists
        move /Y "%%f" "bin\windows_debug_x86_64.exe"
    )
)

:: Copy both release and debug templates to the output directory
xcopy /Y /I bin\windows_*.exe "%OUTPUT_DIR%"

:: Return to original directory
cd /d "%CURRENT_DIR%"

endlocal
