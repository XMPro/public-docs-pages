# Cache Busting Solution for GitHub Pages

This document explains the cache busting solution implemented for the XMPro documentation site hosted on GitHub Pages.

## Problem

GitHub Pages serves static content with default cache headers that can cause browsers to cache HTML pages and other resources. This can lead to users not seeing the latest changes unless they perform a hard refresh or open the site in a private/incognito window.

## Solution

The solution implements multiple layers of cache busting to ensure users always get the latest content:

### 1. Cache Control Meta Tags

The HTML pages include the following meta tags to prevent caching:

```html
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
```

### 2. Service Worker

A service worker (`service-worker.js`) is implemented to control caching behavior:

- HTML files are always fetched from the network first, with cache as a fallback
- Other resources use a cache-first strategy for better performance
- The service worker is updated with each build, forcing a refresh of the cache
- The service worker uses `skipWaiting()` and `clients.claim()` to take control immediately

### 3. Version Tracking

A version tracking system is implemented to detect when new content is available:

- `version.js` contains a timestamp that is updated with each build
- `version-check.js` periodically checks for a new version and reloads the page if detected

## Implementation Details

### Custom DocFX Template

A custom DocFX template is used to add the cache control meta tags and scripts to the HTML pages.

### GitHub Workflow

The GitHub workflow has been updated to:

1. Generate a new timestamp for each build
2. Update the `version.js` file with the new timestamp
3. Build the site with DocFX
4. Deploy the site to GitHub Pages

### Files Added/Modified

- `templates/modern/partials/head.tmpl.partial` - Added cache control meta tags and scripts
- `service-worker.js` - Service worker implementation for cache control
- `register-sw.js` - Script to register the service worker
- `version.js` - Contains the build timestamp
- `version-check.js` - Checks for new versions and reloads the page
- `docfx.json` - Updated to include the new files
- `.github/workflows/docfx.yml` - Updated to generate a new timestamp with each build

## Testing

To test if the cache busting is working:

1. Visit the site in a normal browser window
2. Make changes to the site and deploy them
3. Wait for the deployment to complete
4. The page should automatically reload with the new content within 5 minutes
5. Alternatively, you can manually refresh the page to see the changes immediately

## Troubleshooting

If you're still experiencing caching issues:

1. Open the browser's developer tools
2. Go to the Application tab
3. Check the Service Worker section to ensure it's active
4. Check the Cache Storage section to see what's being cached
5. Try clearing the browser cache manually
