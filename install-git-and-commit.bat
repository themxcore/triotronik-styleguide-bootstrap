@echo off
echo === TRIOTRONIK Styleguide - Install Git and Commit ===
echo.

:: Check if Git is already installed
git --version >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo [OK] Git is already installed
    goto commit
)

echo [INFO] Git is not installed. Options:
echo.
echo 1. Manual install (recommended):
echo    - Download from: https://git-scm.com/download/win
echo    - Install with default settings
echo    - Restart this script
echo.
echo 2. Try automatic download (requires internet):
echo    - Will attempt to download Git installer
echo.

set /p choice="Choose option (1 or 2): "

if "%choice%"=="2" (
    echo.
    echo [INFO] Downloading Git installer...
    
    :: Try to download Git installer using PowerShell
    powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe' -OutFile 'git-installer.exe'}"
    
    if exist git-installer.exe (
        echo [INFO] Download complete. Starting installation...
        echo [WARN] Please follow the installer prompts and use default settings
        start /wait git-installer.exe
        
        :: Clean up
        del git-installer.exe
        
        echo [INFO] Installation complete. Please restart this script.
        pause
        exit /b 0
    ) else (
        echo [ERROR] Download failed. Please install manually.
        pause
        exit /b 1
    )
) else (
    echo [INFO] Please install Git manually and restart this script.
    pause
    exit /b 0
)

:commit
echo.
echo === Setting up Git Repository ===

:: Initialize repository if needed
if not exist .git (
    echo [INFO] Initializing Git repository...
    git init
)

:: Add remote
git remote get-url origin >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [INFO] Adding GitHub remote...
    git remote add origin https://github.com/themxcore/triotronik-styleguide-bootstrap.git
) else (
    echo [OK] GitHub remote already configured
)

:: Check Git configuration
for /f "tokens=*" %%i in ('git config user.name 2^>nul') do set username=%%i
for /f "tokens=*" %%i in ('git config user.email 2^>nul') do set useremail=%%i

if "%username%"=="" (
    set /p username="Enter your name for Git commits: "
    git config user.name "%username%"
)

if "%useremail%"=="" (
    set /p useremail="Enter your email for Git commits: "
    git config user.email "%useremail%"
)

echo [OK] Git user: %username% [%useremail%]

echo.
echo === Committing Changes ===

:: Add all files
echo [INFO] Adding all changes...
git add .

:: Show status
echo.
echo [INFO] Files to be committed:
git diff --cached --name-status

echo.
set /p proceed="Do you want to commit these changes? (y/N): "

if /i "%proceed%"=="y" (
    echo [INFO] Committing changes...
    
    git commit -m "feat: Optimize TRIOTRONIK Styleguide for Bootstrap 5.3.x compatibility" -m "" -m "🚀 Major modernization of the TRIOTRONIK Styleguide" -m "" -m "✨ JavaScript Enhancements:" -m "- NEW: Modular TRIOTRONIKStyleguide architecture" -m "- ADDED: Interactive font preview component" -m "- ENHANCED: Advanced form validation with UX improvements" -m "- ADDED: Professional toast notification system" -m "- IMPROVED: Dark mode toggle functionality" -m "" -m "🎨 CSS Modernization:" -m "- REWRITTEN: Complete CSS with custom properties system" -m "- DEFINED: Comprehensive design token architecture" -m "- ENHANCED: Dark mode and responsive design support" -m "- OPTIMIZED: Better maintainability and performance" -m "- BACKUP: Original CSS preserved as styleguide-old.css" -m "" -m "📄 HTML Updates:" -m "- UPDATED: CSS references to optimized version" -m "- PRESERVED: All existing content and functionality" -m "" -m "🔧 Technical Improvements:" -m "- Full Bootstrap 5.3.x compatibility" -m "- Mobile-first responsive design" -m "- Enhanced accessibility features" -m "- Modular and scalable architecture" -m "- Professional UX patterns" -m "" -m "Impact: Transforms the styleguide into a modern, maintainable design system ready for future development."
    
    if %ERRORLEVEL% equ 0 (
        echo [OK] Changes committed successfully
        echo.
        set /p push="Do you want to push to GitHub now? (y/N): "
        
        if /i "!push!"=="y" (
            echo [INFO] Pushing to GitHub...
            git push -u origin main
            
            if %ERRORLEVEL% equ 0 (
                echo.
                echo [SUCCESS] Successfully pushed to GitHub!
                echo.
                echo 🎉 Your TRIOTRONIK Styleguide is now live at:
                echo    https://github.com/themxcore/triotronik-styleguide-bootstrap
            ) else (
                echo [ERROR] Failed to push to GitHub
                echo You may need to authenticate or check your permissions
            )
        )
    ) else (
        echo [ERROR] Failed to commit changes
    )
) else (
    echo [INFO] Commit cancelled
)

echo.
echo === Done ===
pause
