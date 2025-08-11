# Quick Git Commit Commands

If you have Git installed and just want to commit quickly, run these commands in PowerShell or Command Prompt:

## Step 1: Initialize Repository (if not done before)
```bash
git init
git remote add origin https://github.com/themxcore/triotronik-styleguide-bootstrap.git
```

## Step 2: Configure Git User (if not done before)
```bash
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

## Step 3: Add and Commit All Changes
```bash
# Add all files
git add .

# Commit with message
git commit -m "feat: Optimize TRIOTRONIK Styleguide for Bootstrap 5.3.x compatibility

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

Impact: Transforms the styleguide into a modern, maintainable design system ready for future development."
```

## Step 4: Push to GitHub
```bash
git push -u origin main
```

## Troubleshooting

### If you get authentication errors:
1. Set up a Personal Access Token on GitHub
2. Use it as your password when prompted
3. Or configure SSH keys for easier access

### If the branch is called 'master' instead of 'main':
```bash
git push -u origin master
```

### To check current status:
```bash
git status
```

### To see what files will be committed:
```bash
git diff --cached --name-status
```

---

**Files that will be committed:**
- ✅ `assets/css/styleguide.css` (optimized)
- ✅ `assets/css/styleguide-old.css` (backup)
- ✅ `assets/js/styleguide.js` (refactored)
- ✅ `index.html` (updated)
