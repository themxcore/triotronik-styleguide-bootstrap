/**
 * TRIOTRONIK Styleguide JavaScript
 * Bootstrap 5.3.x optimized
 */

// Initialize AOS animations
AOS.init({
  duration: 800,
  easing: 'ease-in-out',
  once: true,
  offset: 100
});

// TRIOTRONIK Styleguide Utilities
const TRIOTRONIKStyleguide = {
  // Initialize all components
  init() {
    this.initTooltips();
    this.initFormValidation();
    this.initFontPreview();
    this.initDarkMode();
    this.initToasts();
  },

  // Initialize Bootstrap tooltips
  initTooltips() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    [...tooltipTriggerList].forEach(tooltipTriggerEl => {
      new bootstrap.Tooltip(tooltipTriggerEl, {
        boundary: 'viewport',
        customClass: 'tt-tooltip'
      });
    });
  },

  // Form validation with UX improvements
  initFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');
    
    forms.forEach(form => {
      form.addEventListener('submit', event => {
        event.preventDefault();
        event.stopPropagation();
        
        if (!form.checkValidity()) {
          const firstInvalid = form.querySelector(':invalid');
          if (firstInvalid) {
            firstInvalid.scrollIntoView({
              behavior: 'smooth',
              block: 'center'
            });
            firstInvalid.focus();
          }
        } else {
          this.handleFormSubmit(form);
        }
        
        form.classList.add('was-validated');
      }, false);
    });
  },

  // Handle successful form submission
  handleFormSubmit(form) {
    const progressWrapper = form.querySelector('.progress');
    const progressBar = form.querySelector('.progress-bar');
    
    if (progressWrapper && progressBar) {
      progressWrapper.classList.remove('d-none');
      this.animateProgress(progressBar);
    } else {
      this.showSuccessToast('Formular erfolgreich gesendet!');
    }
  },

  // Animate progress bar
  animateProgress(progressBar) {
    let progress = 0;
    const interval = setInterval(() => {
      progress += 10;
      progressBar.style.width = `${progress}%`;
      progressBar.textContent = `${progress}%`;
      
      if (progress >= 100) {
        clearInterval(interval);
        setTimeout(() => {
          progressBar.textContent = "Abgeschlossen!";
          progressBar.classList.replace('bg-success', 'bg-primary');
        }, 500);
      }
    }, 200);
  },

  // Initialize font preview functionality
  initFontPreview() {
    const fontSelect = document.getElementById('fontSelect');
    const fontSize = document.getElementById('fontSize');
    const fontStyle = document.getElementById('fontStyle');
    const previewText = document.getElementById('previewText');
    const output = document.getElementById('fontPreviewOutput');

    if (!fontSelect || !fontSize || !fontStyle || !previewText || !output) {
      return; // Elements not found, skip initialization
    }

    const updateFontPreview = () => {
      const fontVar = getComputedStyle(document.documentElement)
        .getPropertyValue(fontSelect.value.replace('var(', '').replace(')', ''))
        .trim();
      
      output.style.fontFamily = fontVar;
      output.style.fontSize = fontSize.value;
      
      const style = fontStyle.value;
      output.style.fontWeight = style.includes('bold') ? 'bold' : 'normal';
      output.style.fontStyle = style.includes('italic') ? 'italic' : 'normal';
      
      output.textContent = previewText.value;
    };

    // Event listeners
    fontSelect.addEventListener('change', updateFontPreview);
    fontSize.addEventListener('change', updateFontPreview);
    fontStyle.addEventListener('change', updateFontPreview);
    previewText.addEventListener('input', updateFontPreview);

    // Initial preview update
    updateFontPreview();

    // Theme toggle for preview
    const themeToggle = document.getElementById('fontPreviewThemeToggle');
    const fontPreviewContainer = document.getElementById('fontPreviewContainer');
    
    if (themeToggle && fontPreviewContainer) {
      themeToggle.addEventListener('change', function () {
        if (this.checked) {
          fontPreviewContainer.classList.remove('bg-light', 'text-dark');
          fontPreviewContainer.classList.add('bg-dark', 'text-white');
        } else {
          fontPreviewContainer.classList.remove('bg-dark', 'text-white');
          fontPreviewContainer.classList.add('bg-light', 'text-dark');
        }
      });
    }
  },

  // Initialize dark mode toggle
  initDarkMode() {
    const globalThemeToggle = document.getElementById('globalThemeToggle');
    
    if (globalThemeToggle) {
      globalThemeToggle.addEventListener('change', function () {
        document.body.classList.toggle('dark-mode', this.checked);
        
        // Store preference
        localStorage.setItem('darkMode', this.checked);
      });
      
      // Load saved preference
      const savedDarkMode = localStorage.getItem('darkMode') === 'true';
      globalThemeToggle.checked = savedDarkMode;
      document.body.classList.toggle('dark-mode', savedDarkMode);
    }
  },

  // Initialize toast notifications
  initToasts() {
    const toastEl = document.getElementById('triotronikToast');
    if (toastEl) {
      const toast = new bootstrap.Toast(toastEl, {
        delay: 5000,
        autohide: true
      });
      toast.show();
    }
  },

  // Show success toast
  showSuccessToast(message) {
    this.showToast(message, 'success');
  },

  // Show error toast
  showErrorToast(message) {
    this.showToast(message, 'danger');
  },

  // Generic toast method
  showToast(message, type = 'primary') {
    const toastContainer = document.querySelector('.toast-container') || this.createToastContainer();
    
    const toastHTML = `
      <div class="toast align-items-center text-white bg-${type} border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
          <div class="toast-body">${message}</div>
          <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
      </div>
    `;
    
    toastContainer.insertAdjacentHTML('beforeend', toastHTML);
    const newToast = toastContainer.lastElementChild;
    const toast = new bootstrap.Toast(newToast);
    toast.show();
    
    // Remove toast element after it's hidden
    newToast.addEventListener('hidden.bs.toast', () => {
      newToast.remove();
    });
  },

  // Create toast container if it doesn't exist
  createToastContainer() {
    const container = document.createElement('div');
    container.className = 'toast-container position-fixed bottom-0 end-0 p-3';
    container.style.zIndex = '1080';
    document.body.appendChild(container);
    return container;
  }
};

// Global function for backward compatibility
window.showToast = function() {
  const toastEl = document.getElementById('liveToast');
  if (toastEl) {
    new bootstrap.Toast(toastEl).show();
  }
};

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  TRIOTRONIKStyleguide.init();
});
