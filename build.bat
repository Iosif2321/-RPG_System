@echo off
setlocal EnableDelayedExpansion

:: Деактивируем venv если активен
if defined VIRTUAL_ENV (
    call deactivate 2>nul
)

:: Путь к AddonBuilder — проверяем несколько вариантов
set "BUILDER="

if exist "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe" (
    set "BUILDER=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe"
)
if not defined BUILDER if exist "D:\Steam\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe" (
    set "BUILDER=D:\Steam\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe"
)
if not defined BUILDER if exist "D:\SteamLibrary\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe" (
    set "BUILDER=D:\SteamLibrary\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe"
)

if not defined BUILDER (
    echo [ERROR] AddonBuilder.exe not found.
    echo Please install "Arma 3 Tools" via Steam ^(Library - Tools^).
    echo Or edit this script and set BUILDER path manually.
    pause
    exit /b 1
)

set "SOURCE=%~dp0source\RPG_System"
set "DEST=%~dp0addons"

if not exist "%SOURCE%\config.cpp" (
    echo [ERROR] Source directory not found or missing config.cpp:
    echo   "%SOURCE%"
    pause
    exit /b 1
)

if not exist "%DEST%" mkdir "%DEST%"

echo.
echo [RPG_System] Building PBO...
echo   Source  : "%SOURCE%"
echo   Output  : "%DEST%"
echo   Builder : "%BUILDER%"
echo.

"%BUILDER%" "%SOURCE%" "%DEST%" -clear -packonly

if !ERRORLEVEL! EQU 0 (
    echo.
    echo [RPG_System] Build successful: "%DEST%\RPG_System.pbo"
) else (
    echo.
    echo [RPG_System] Build FAILED with error !ERRORLEVEL!
)

echo.
pause
endlocal
