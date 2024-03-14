---
description: v4.4.0
---

# Metablocks

Metablocks improve the overall performance of Applications by loading Blocks asynchronously. By loading Blocks asynchronously, large files can be loaded in the background without hindering the initial page load time. This approach ensures that users can interact with the main page content more quickly, while additional components are loaded as needed.

## Benefits

### **Support different web technologies**

Metablocks unlocks development in web technologies that are Webpack-compatible. Webpack is a popular static module bundler for modern JavaScript applications, meaning that Metablocks can be easily incorporated into development workflows that use Webpack for managing assets, scripts, and dependencies.

### **Improved security posture**

This feature allows architects and administrators to enhance the security of their applications. They can opt out of specific blocks that rely on libraries with known security vulnerabilities. This proactive approach maintains the overall security integrity of the application by minimizing potential attack vectors.

### **Improved App Designer performance**

By relocating block dependencies to individual Metablocks, the performance of App Designer is enhanced. This modular approach means that dependencies are managed more efficiently, leading to quicker load times and smoother operation while designing Applications.

## Current Capability

The [Unity](../../blocks-toolbox/visualizations/unity.md) and [Unity (Legacy)](../../blocks-toolbox/visualizations/unity-1.md) Blocks are now available to designers as either the original or a Metablock - if Metablocks has been installed and an administrator has turned on the site setting.

There is no difference in functionality to the designer or user, except for improved performance.

<figure><img src="../../.gitbook/assets/Metablock_Unity Icons.png" alt=""><figcaption><p>Fig 1: Metablocks denoted with a "META" tag on the icon.</p></figcaption></figure>

## **Future Capabilities**

New features and enhancements will be added to Metablocks.

Designers will be empowered to develop their own custom Metablocks, such as if a preferred visualization is not supported.

System Administrators will be able to manage their Metablocks, adding new ones as needed and removing others that are not necessary. This capability ensures that Applications can evolve, adapting to new requirements or changes in functionality.

## Summary

In summary, Metablocks is designed to be a flexible, secure, and performance-oriented solution for developing Applications with resource-intensive visualizations.
