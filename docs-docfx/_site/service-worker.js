// Service worker for cache control
const VERSION = new Date().getTime(); // Used for cache busting
const CACHE_NAME = `xmpro-docs-cache-v1-${VERSION}`;

// Files to cache
const urlsToCache = [
  '/',
  '/index.html'
];

// Install event - cache basic files and activate immediately
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        return cache.addAll(urlsToCache);
      })
      .then(() => {
        // Skip waiting to activate the new service worker immediately
        return self.skipWaiting();
      })
  );
});

// Fetch event - network first, then cache
self.addEventListener('fetch', event => {
  // Skip non-GET requests
  if (event.request.method !== 'GET') return;
  
  // Handle HTML files differently - always fetch from network
  const url = new URL(event.request.url);
  const isHTMLRequest = event.request.headers.get('accept')?.includes('text/html') 
    || url.pathname.endsWith('.html') 
    || url.pathname === '/';
  
  if (isHTMLRequest) {
    // For HTML files, always go to network and update cache
    event.respondWith(
      fetch(event.request)
        .then(response => {
          // Cache the updated version
          const clonedResponse = response.clone();
          caches.open(CACHE_NAME).then(cache => {
            cache.put(event.request, clonedResponse);
          });
          return response;
        })
        .catch(() => {
          // If network fails, try to serve from cache
          return caches.match(event.request);
        })
    );
  } else {
    // For other files, try cache first, then network
    event.respondWith(
      caches.match(event.request)
        .then(cachedResponse => {
          if (cachedResponse) {
            return cachedResponse;
          }
          
          return fetch(event.request)
            .then(response => {
              // Cache the fetched response
              if (response.status === 200) {
                const clonedResponse = response.clone();
                caches.open(CACHE_NAME).then(cache => {
                  cache.put(event.request, clonedResponse);
                });
              }
              return response;
            });
        })
    );
  }
});

// Activate event - clean up old caches and claim clients
self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  
  event.waitUntil(
    Promise.all([
      // Clean up old caches
      caches.keys().then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheWhitelist.indexOf(cacheName) === -1) {
              return caches.delete(cacheName);
            }
          })
        );
      }),
      // Take control of all clients
      self.clients.claim()
    ])
  );
});
