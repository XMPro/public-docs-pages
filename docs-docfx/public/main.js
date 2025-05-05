// XMPro Custom JavaScript for DocFX

// Wait for the DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
  // Set default theme based on user preference
  const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const savedTheme = localStorage.getItem('theme') || (prefersDarkMode ? 'dark' : 'light');
  document.documentElement.setAttribute('data-bs-theme', savedTheme);

  // Add theme toggle button to navbar
  const navbar = document.querySelector('.navbar-nav');
  if (navbar) {
    const themeToggle = document.createElement('div');
    themeToggle.className = 'theme-toggle';
    
    const lightBtn = document.createElement('button');
    lightBtn.className = 'theme-toggle-btn';
    lightBtn.innerHTML = '<i class="fa fa-sun"></i>';
    lightBtn.title = 'Light Theme';
    lightBtn.addEventListener('click', function() {
      setTheme('light');
    });
    
    const darkBtn = document.createElement('button');
    darkBtn.className = 'theme-toggle-btn';
    darkBtn.innerHTML = '<i class="fa fa-moon"></i>';
    darkBtn.title = 'Dark Theme';
    darkBtn.addEventListener('click', function() {
      setTheme('dark');
    });
    
    const autoBtn = document.createElement('button');
    autoBtn.className = 'theme-toggle-btn';
    autoBtn.innerHTML = '<i class="fa fa-adjust"></i>';
    autoBtn.title = 'Auto Theme';
    autoBtn.addEventListener('click', function() {
      setTheme('auto');
    });
    
    themeToggle.appendChild(lightBtn);
    themeToggle.appendChild(darkBtn);
    themeToggle.appendChild(autoBtn);
    
    navbar.appendChild(themeToggle);
  }

  // Function to set theme
  function setTheme(theme) {
    localStorage.setItem('theme', theme);
    if (theme === 'auto') {
      const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
      document.documentElement.setAttribute('data-bs-theme', systemTheme);
    } else {
      document.documentElement.setAttribute('data-bs-theme', theme);
    }
  }

  // Add XMPro logo to navbar if it doesn't exist
  const navbarBrand = document.querySelector('.navbar-brand');
  if (navbarBrand && !navbarBrand.querySelector('img')) {
    const logo = document.createElement('img');
    logo.src = '/images/logo.png';
    logo.alt = 'XMPro Logo';
    navbarBrand.insertBefore(logo, navbarBrand.firstChild);
  }

  // Add version information to footer
  const footer = document.querySelector('.footer');
  if (footer) {
    const versionInfo = document.createElement('div');
    versionInfo.className = 'version-info';
    
    // Use the version and last updated info from version.js if available
    const version = window.docsVersion || '1.0.0';
    const lastUpdated = window.lastUpdated ? new Date(window.lastUpdated).toLocaleDateString() : new Date().toLocaleDateString();
    
    versionInfo.innerHTML = `Documentation version ${version} | Last updated: ${lastUpdated} | Built with DocFX`;
    footer.appendChild(versionInfo);
  }

  // Enhance search functionality
  const searchBox = document.querySelector('.search-box');
  if (searchBox) {
    searchBox.setAttribute('placeholder', 'Search XMPro Documentation...');
    
    // Add search icon
    const searchIcon = document.createElement('i');
    searchIcon.className = 'fa fa-search search-icon';
    searchBox.parentNode.insertBefore(searchIcon, searchBox.nextSibling);
  }

  // Add smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      e.preventDefault();
      const targetId = this.getAttribute('href');
      if (targetId === '#') return;
      
      const targetElement = document.querySelector(targetId);
      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
        
        // Add highlight effect
        targetElement.classList.add('highlight');
        setTimeout(() => {
          targetElement.classList.remove('highlight');
        }, 2000);
      }
    });
  });

  // Add copy button to code blocks
  document.querySelectorAll('pre code').forEach(block => {
    const container = block.parentNode;
    container.style.position = 'relative';
    
    const button = document.createElement('button');
    button.className = 'copy-button';
    button.innerHTML = '<i class="fa fa-copy"></i>';
    button.title = 'Copy to clipboard';
    
    button.addEventListener('click', function() {
      const code = block.textContent;
      navigator.clipboard.writeText(code).then(() => {
        button.innerHTML = '<i class="fa fa-check"></i>';
        setTimeout(() => {
          button.innerHTML = '<i class="fa fa-copy"></i>';
        }, 2000);
      });
    });
    
    container.appendChild(button);
  });

  // Add table of contents toggle for mobile
  const toc = document.querySelector('.toc');
  if (toc && window.innerWidth <= 768) {
    const tocToggle = document.createElement('button');
    tocToggle.className = 'toc-toggle';
    tocToggle.innerHTML = '<i class="fa fa-bars"></i>';
    tocToggle.title = 'Toggle Table of Contents';
    
    tocToggle.addEventListener('click', function() {
      toc.classList.toggle('toc-visible');
      this.classList.toggle('active');
    });
    
    const article = document.querySelector('.article');
    if (article) {
      document.body.appendChild(tocToggle);
    }
  }

  // Add collapsible sections
  document.querySelectorAll('.collapsible-section').forEach(section => {
    const header = section.querySelector('h2, h3, h4, h5, h6');
    if (header) {
      header.style.cursor = 'pointer';
      header.innerHTML += ' <i class="fa fa-chevron-down"></i>';
      
      const content = document.createElement('div');
      content.className = 'collapsible-content';
      
      // Move all elements after the header into the content div
      let nextElement = header.nextElementSibling;
      while (nextElement) {
        const temp = nextElement.nextElementSibling;
        content.appendChild(nextElement);
        nextElement = temp;
      }
      
      section.appendChild(content);
      
      header.addEventListener('click', function() {
        content.classList.toggle('collapsed');
        this.querySelector('i').classList.toggle('fa-chevron-down');
        this.querySelector('i').classList.toggle('fa-chevron-up');
      });
    }
  });

  // Add back to top button
  const backToTopBtn = document.createElement('button');
  backToTopBtn.className = 'back-to-top';
  backToTopBtn.innerHTML = '<i class="fa fa-arrow-up"></i>';
  backToTopBtn.title = 'Back to Top';
  
  backToTopBtn.addEventListener('click', function() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
  
  document.body.appendChild(backToTopBtn);
  
  // Show/hide back to top button based on scroll position
  window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
      backToTopBtn.classList.add('visible');
    } else {
      backToTopBtn.classList.remove('visible');
    }
  });

  // Add beta labels to elements with data-beta attribute
  document.querySelectorAll('[data-beta="true"]').forEach(element => {
    const betaLabel = document.createElement('span');
    betaLabel.className = 'beta-icon';
    betaLabel.textContent = 'BETA';
    element.appendChild(betaLabel);
  });

  // Add external link icon to external links
  document.querySelectorAll('a').forEach(link => {
    if (link.hostname !== window.location.hostname && link.hostname !== '') {
      link.classList.add('external-link');
      link.innerHTML += ' <i class="fa fa-external-link-alt"></i>';
      link.setAttribute('target', '_blank');
      link.setAttribute('rel', 'noopener noreferrer');
    }
  });

  // Add keyboard navigation for tabs
  document.querySelectorAll('.tabGroup').forEach(tabGroup => {
    const tabs = tabGroup.querySelectorAll('ul li a');
    tabs.forEach((tab, index) => {
      tab.addEventListener('keydown', function(e) {
        if (e.key === 'ArrowRight') {
          e.preventDefault();
          const nextTab = tabs[(index + 1) % tabs.length];
          nextTab.click();
          nextTab.focus();
        } else if (e.key === 'ArrowLeft') {
          e.preventDefault();
          const prevTab = tabs[(index - 1 + tabs.length) % tabs.length];
          prevTab.click();
          prevTab.focus();
        }
      });
    });
  });

  // Add responsive tables
  document.querySelectorAll('table').forEach(table => {
    const wrapper = document.createElement('div');
    wrapper.className = 'table-responsive';
    table.parentNode.insertBefore(wrapper, table);
    wrapper.appendChild(table);
  });

  // Add image lightbox
  document.querySelectorAll('.article img').forEach(img => {
    if (!img.closest('a')) {
      img.style.cursor = 'pointer';
      img.addEventListener('click', function() {
        const lightbox = document.createElement('div');
        lightbox.className = 'lightbox';
        
        const lightboxImg = document.createElement('img');
        lightboxImg.src = img.src;
        
        const closeBtn = document.createElement('button');
        closeBtn.className = 'lightbox-close';
        closeBtn.innerHTML = '&times;';
        
        lightbox.appendChild(lightboxImg);
        lightbox.appendChild(closeBtn);
        document.body.appendChild(lightbox);
        
        closeBtn.addEventListener('click', function() {
          document.body.removeChild(lightbox);
        });
        
        lightbox.addEventListener('click', function(e) {
          if (e.target === lightbox) {
            document.body.removeChild(lightbox);
          }
        });
      });
    }
  });

  // Add Font Awesome if not already loaded
  if (!document.querySelector('link[href*="font-awesome"]')) {
    const fontAwesome = document.createElement('link');
    fontAwesome.rel = 'stylesheet';
    fontAwesome.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css';
    document.head.appendChild(fontAwesome);
  }
});
