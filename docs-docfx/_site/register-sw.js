// Register the service worker
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function() {
    // Use the lastUpdated timestamp from version.js for cache busting
    const timestamp = window.lastUpdated ? new Date(window.lastUpdated).getTime() : new Date().getTime();
    const swUrl = `${window.location.pathname.replace(/\/[^\/]*$/, '')}/service-worker.js?v=${timestamp}`;
    
    navigator.serviceWorker.register(swUrl)
      .then(function(registration) {
        console.log('ServiceWorker registration successful with scope: ', registration.scope);
        
        // Check for updates every hour
        setInterval(() => {
          registration.update();
        }, 3600000); // 1 hour in milliseconds
      })
      .catch(function(error) {
        console.log('ServiceWorker registration failed: ', error);
      });
  });
}
