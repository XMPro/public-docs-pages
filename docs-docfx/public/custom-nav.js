// Custom navigation JavaScript

document.addEventListener('DOMContentLoaded', function() {
  // Add logo to sidebar
  const sidebar = document.querySelector('.sidebar');
  if (sidebar) {
    const logo = document.createElement('div');
    logo.className = 'sidebar-logo';
    logo.innerHTML = `<a href="index.html"><img src="logo.svg" alt="XMPro"></a>`;
    sidebar.insertBefore(logo, sidebar.firstChild);
  }

  // Process all navigation items
  const navItems = document.querySelectorAll('.sidebar .nav > li');
  navItems.forEach(item => {
    const link = item.querySelector('a');
    const subNav = item.querySelector('.nav');
    
    // If this item has children, add the has-children class
    if (subNav) {
      link.classList.add('has-children');
      
      // Add click handler to toggle the submenu
      link.addEventListener('click', function(e) {
        // Only prevent default if it's a parent item with children
        if (subNav) {
          e.preventDefault();
          item.classList.toggle('expanded');
        }
      });
    }
  });

  // Add mobile toggle button
  if (window.innerWidth <= 768) {
    const toggleBtn = document.createElement('button');
    toggleBtn.className = 'sidebar-toggle';
    toggleBtn.innerHTML = '<i class="bi bi-list"></i>';
    toggleBtn.title = 'Toggle Navigation';
    
    toggleBtn.addEventListener('click', function() {
      sidebar.classList.toggle('show');
    });
    
    document.body.appendChild(toggleBtn);
    
    // Close sidebar when clicking outside
    document.addEventListener('click', function(e) {
      if (!sidebar.contains(e.target) && e.target !== toggleBtn) {
        sidebar.classList.remove('show');
      }
    });
  }

  // Expand the active item's parents
  const activeItem = document.querySelector('.sidebar .nav > li.active');
  if (activeItem) {
    let parent = activeItem.parentElement;
    while (parent && parent.classList.contains('nav')) {
      const parentLi = parent.parentElement;
      if (parentLi && parentLi.tagName === 'LI') {
        parentLi.classList.add('expanded');
      }
      parent = parentLi ? parentLi.parentElement : null;
    }
  }
});
