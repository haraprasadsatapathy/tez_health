@echo off
echo ================================================
echo Tez Health - App Icon Setup Checker
echo ================================================
echo.

REM Check if icon file exists
if exist "assets\images\tez_logo.png" (
    echo [SUCCESS] tez_logo.png found!
    echo.
    echo Icon file location: assets\images\tez_logo.png
    echo.
    echo Now you can generate app icons by running:
    echo    flutter pub get
    echo    flutter pub run flutter_launcher_icons
    echo.
    pause
) else (
    echo [ERROR] tez_logo.png NOT FOUND!
    echo.
    echo Please save your blue medical icon as:
    echo    assets\images\tez_logo.png
    echo.
    echo Requirements:
    echo    - Format: PNG
    echo    - Size: 1024x1024 pixels (recommended)
    echo    - File name: tez_logo.png (exactly)
    echo.
    pause
)
