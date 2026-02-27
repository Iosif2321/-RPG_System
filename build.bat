@echo off
setlocal

set "BUILDER=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe"
set "SOURCE=%~dp0source\RPG_System"
set "DEST=%~dp0addons"

if not exist "%BUILDER%" (
    echo [ERROR] AddonBuilder not found at:
    echo   %BUILDER%
    echo Please install Arma 3 Tools via Steam ^(Tools tab^).
    pause
    exit /b 1
)

if not exist "%DEST%" mkdir "%DEST%"

echo [RPG_System] Building PBO...
echo   Source : %SOURCE%
echo   Output : %DEST%

"%BUILDER%" "%SOURCE%" "%DEST%" -clear -packonly

if %ERRORLEVEL% == 0 (
    echo [RPG_System] Build successful: %DEST%\RPG_System.pbo
) else (
    echo [RPG_System] Build FAILED with error %ERRORLEVEL%
)

pause
endlocal
