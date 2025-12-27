@echo off
echo ================================================
echo Tez Health - App Icon Generator
echo ================================================
echo.

REM Check if icon file exists
if not exist "assets\images\tez_logo.png" (
    echo [ERROR] Icon file not found!
    echo.
    echo Please save your blue medical icon as:
    echo    assets\images\tez_logo.png
    echo.
    echo Then run this script again.
    echo.
    pause
    exit /b 1
)

echo [1/4] Icon file found!
echo.

echo [2/4] Running flutter pub get...
call flutter pub get
if errorlevel 1 (
    echo [ERROR] Failed to get dependencies
    pause
    exit /b 1
)
echo.

echo [3/4] Generating app icons...
call flutter pub run flutter_launcher_icons
if errorlevel 1 (
    echo [ERROR] Failed to generate icons
    pause
    exit /b 1
)
echo.

echo [4/4] Cleaning up...
call flutter clean
call flutter pub get
echo.

echo ================================================
echo SUCCESS! App icons generated successfully!
echo ================================================
echo.
echo Your app icons have been created for:
echo   - Android (all densities + adaptive icon)
echo   - iOS (all required sizes + dark mode)
echo.
echo Next steps:
echo   1. Uninstall old app from your device (if installed)
echo   2. Run: flutter run
echo   3. Check your device home screen for the new icon
echo.
pause
