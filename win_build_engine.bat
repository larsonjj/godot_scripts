@echo off
setlocal

set "CURRENT_DIR=%cd%"
set "CUSTOM_PROFILE=%CURRENT_DIR%\custom_2d.py"
set "GODOT_SOURCE_DIR=%USERPROFILE%\godot"
set "OUTPUT_DIR=%CURRENT_DIR%\build"

cd /d "%GODOT_SOURCE_DIR%"

:: Release
scons platform=windows arch=x86_64

:: Move to export template folder
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"
xcopy /Y /I bin\godot.windows.editor.*.exe "%OUTPUT_DIR%\"

:: Return to original directory
cd /d "%CURRENT_DIR%"

endlocal
