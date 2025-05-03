// Version check script to force reload when a new version is detected
(function() {
  // Check for new version every 5 minutes
  const CHECK_INTERVAL = 5 * 60 * 1000; // 5 minutes in milliseconds
  
  // Store the current version
  const currentVersion = window.lastUpdated;
  
  // Function to check for new version
  function checkForNewVersion() {
    // Fetch the version.js file with a cache-busting parameter
    fetch('version.js?' + new Date().getTime())
      .then(response => response.text())
      .then(text => {
        // Extract the lastUpdated value from the fetched file
        const match = text.match(/window\.lastUpdated\s*=\s*['"]([^'"]+)['"]/);
        if (match && match[1]) {
          const fetchedVersion = match[1];
          
          // If the version has changed, reload the page
          if (fetchedVersion !== currentVersion) {
            console.log('New version detected. Reloading page...');
            window.location.reload(true); // Force reload from server
          }
        }
      })
      .catch(error => {
        console.error('Error checking for new version:', error);
      });
  }
  
  // Start checking for new version after the page has loaded
  if (currentVersion) {
    setInterval(checkForNewVersion, CHECK_INTERVAL);
  }
})();
