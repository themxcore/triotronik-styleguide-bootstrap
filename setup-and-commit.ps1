# TRIOTRONIK Styleguide Git Setup and Commit Script
# This script will help you commit the optimized styleguide to GitHub

Write-Host "=== TRIOTRONIK Styleguide Git Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if Git is installed
$gitPath = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitPath) {
    Write-Host "❌ Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Git first:" -ForegroundColor Yellow
    Write-Host "1. Download from: https://git-scm.com/download/win" -ForegroundColor White
    Write-Host "2. Install with default settings" -ForegroundColor White
    Write-Host "3. Restart PowerShell and run this script again" -ForegroundColor White
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✅ Git is installed" -ForegroundColor Green

# Check if already a Git repository
if (Test-Path ".git") {
    Write-Host "✅ Already a Git repository" -ForegroundColor Green
} else {
    Write-Host "🔧 Initializing Git repository..." -ForegroundColor Yellow
    git init
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Git repository initialized" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to initialize Git repository" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Add remote if not exists
$remoteExists = git remote get-url origin 2>$null
if (-not $remoteExists) {
    Write-Host "🔧 Adding GitHub remote..." -ForegroundColor Yellow
    git remote add origin https://github.com/themxcore/triotronik-styleguide-bootstrap.git
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ GitHub remote added" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to add GitHub remote" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    Write-Host "✅ GitHub remote already configured" -ForegroundColor Green
}

# Check Git configuration
$userName = git config user.name 2>$null
$userEmail = git config user.email 2>$null

if (-not $userName -or -not $userEmail) {
    Write-Host ""
    Write-Host "🔧 Git user configuration needed" -ForegroundColor Yellow
    
    if (-not $userName) {
        $name = Read-Host "Enter your name for Git commits"
        git config user.name "$name"
    }
    
    if (-not $userEmail) {
        $email = Read-Host "Enter your email for Git commits"
        git config user.email "$email"
    }
    
    Write-Host "✅ Git user configured" -ForegroundColor Green
} else {
    Write-Host "✅ Git user already configured: $userName [$userEmail]" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Committing Changes ===" -ForegroundColor Cyan

# Check status
Write-Host "🔍 Checking repository status..." -ForegroundColor Yellow
git status --porcelain

# Add all changes
Write-Host "📁 Adding all changes..." -ForegroundColor Yellow
git add .

# Show what will be committed
Write-Host ""
Write-Host "📋 Files to be committed:" -ForegroundColor Yellow
git diff --cached --name-status

Write-Host ""
$proceed = Read-Host "Do you want to proceed with the commit? (y/N)"

if ($proceed -eq 'y' -or $proceed -eq 'Y') {
    # Commit with detailed message
    Write-Host "💾 Committing changes..." -ForegroundColor Yellow
    
    $commitMessage = @"
feat: Optimize TRIOTRONIK Styleguide for Bootstrap 5.3.x compatibility

🚀 Major modernization of the TRIOTRONIK Styleguide

✨ JavaScript Enhancements:
- NEW: Modular TRIOTRONIKStyleguide architecture
- ADDED: Interactive font preview component
- ENHANCED: Advanced form validation with UX improvements
- ADDED: Professional toast notification system
- IMPROVED: Dark mode toggle functionality

🎨 CSS Modernization:
- REWRITTEN: Complete CSS with custom properties system
- DEFINED: Comprehensive design token architecture
- ENHANCED: Dark mode and responsive design support
- OPTIMIZED: Better maintainability and performance
- BACKUP: Original CSS preserved as styleguide-old.css

📄 HTML Updates:
- UPDATED: CSS references to optimized version
- PRESERVED: All existing content and functionality

🔧 Technical Improvements:
- Full Bootstrap 5.3.x compatibility
- Mobile-first responsive design
- Enhanced accessibility features
- Modular and scalable architecture
- Professional UX patterns

Impact: Transforms the styleguide into a modern, maintainable design system ready for future development.
"@

    git commit -m "$commitMessage"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Changes committed successfully" -ForegroundColor Green
        
        # Push to GitHub
        Write-Host ""
        $push = Read-Host "Do you want to push to GitHub now? (y/N)"
        
        if ($push -eq 'y' -or $push -eq 'Y') {
            Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Yellow
            git push -u origin main
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
                Write-Host ""
                Write-Host "🎉 Your TRIOTRONIK Styleguide is now live at:" -ForegroundColor Cyan
                Write-Host "   https://github.com/themxcore/triotronik-styleguide-bootstrap" -ForegroundColor White
            } else {
                Write-Host "❌ Failed to push to GitHub" -ForegroundColor Red
                Write-Host "You may need to authenticate or check your permissions" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "❌ Failed to commit changes" -ForegroundColor Red
    }
} else {
    Write-Host "⏭️  Commit cancelled" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Cyan
Read-Host "Press Enter to exit"
