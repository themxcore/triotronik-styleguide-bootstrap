@echo off
echo === TRIOTRONIK Styleguide GitHub Commit ===
echo.
echo This script will help you commit your optimized styleguide to GitHub.
echo.

:: Check if Git is installed
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Git is not installed or not in PATH
    echo.
    echo Please install Git first:
    echo 1. Download from: https://git-scm.com/download/win
    echo 2. Install with default settings
    echo 3. Restart this script
    echo.
    pause
    exit /b 1
)

echo [OK] Git is available
echo.

:: Run PowerShell script
echo Running PowerShell setup script...
echo.
powershell -ExecutionPolicy Bypass -File "setup-and-commit.ps1"

pause
