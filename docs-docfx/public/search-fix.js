// Script to fix search functionality in DocFX

document.addEventListener('DOMContentLoaded', function() {
  // Wait a bit to ensure DocFX's own scripts have loaded and initialized
  setTimeout(function() {
    // Find the search box
    const searchBox = document.querySelector('.search-box');
    
    if (searchBox) {
      console.log('Search box found, applying fixes...');
      
      // Enable the search box if it's disabled
      if (searchBox.disabled) {
        console.log('Search box was disabled, enabling it...');
        searchBox.disabled = false;
      }
      
      // Make sure the search box is visible
      searchBox.style.display = 'block';
      
      // Add event listener to ensure search works
      searchBox.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
          const query = searchBox.value.trim();
          if (query) {
            console.log('Performing search for:', query);
            
            // Get the base URL
            const baseUrl = window.location.href.split('/').slice(0, -1).join('/');
            
            // Navigate to search page with query
            window.location.href = baseUrl + '/search/index.html?q=' + encodeURIComponent(query);
          }
        }
      });
      
      console.log('Search fixes applied successfully');
    } else {
      console.warn('Search box not found, cannot apply fixes');
    }
    
    // Check if search index exists
    fetch('search/index.json')
      .then(response => {
        if (response.ok) {
          console.log('Search index found');
        } else {
          console.warn('Search index not found, search may not work correctly');
        }
      })
      .catch(error => {
        console.error('Error checking search index:', error);
      });
  }, 1000); // Wait 1 second for DocFX scripts to initialize
});
