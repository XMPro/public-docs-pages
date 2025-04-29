# Custom Templates in DocFX

DocFX allows you to customize the appearance and behavior of your documentation site using templates. This guide explains how to create and use custom templates.

## Understanding Templates

Templates in DocFX define how your content is rendered into HTML. DocFX uses a template engine called Mustache to process templates.

The default template includes:
- HTML layouts
- CSS styles
- JavaScript for functionality like search
- Partial templates for components like headers and footers

## Creating a Custom Template

To create a custom template:

1. **Start with the default template**:
   ```bash
   docfx template export default
   ```
   This will export the default template to a folder named `_exported_templates`.

2. **Modify the template files**:
   - Edit the HTML files to change the structure
   - Modify the CSS files to change the appearance
   - Update the JavaScript files to add or modify functionality

3. **Use your custom template**:
   Update your `docfx.json` file to use your custom template:
   ```json
   "build": {
     "template": [
       "default",
       "./path/to/your/custom/template"
     ]
   }
   ```

## Template Structure

A typical template structure includes:

```
template/
├── fonts/                 # Font files
├── layout/               # Layout templates
│   ├── master.tmpl      # Master template
│   └── ...
├── partials/             # Partial templates
│   ├── head.tmpl        # Head section
│   ├── footer.tmpl      # Footer section
│   └── ...
├── styles/               # CSS files
│   ├── main.css
│   └── ...
└── scripts/              # JavaScript files
    ├── main.js
    └── ...
```

## Example: Customizing the Header

Here's an example of how to customize the header in your template:

1. Export the default template as described above
2. Locate the header partial template (usually in `partials/header.tmpl`)
3. Modify it to include your custom elements:

```html
<header>
  <div class="container">
    <a class="brand" href="{{_rel}}index.html">
      <img src="{{_rel}}images/logo.png" alt="{{_appName}}" height="50">
      <span>{{_appName}}</span>
    </a>
    <div class="navbar-right">
      <!-- Your custom navigation elements -->
      <a href="{{_rel}}docs/introduction.html">Docs</a>
      <a href="{{_rel}}api/index.html">API</a>
      <a href="https://github.com/yourusername/your-project" target="_blank">GitHub</a>
    </div>
  </div>
</header>
```

4. Add corresponding CSS styles in your stylesheet

## Best Practices

- **Incremental changes**: Start with small changes to the default template rather than creating a template from scratch
- **Version control**: Keep your custom template in version control
- **Documentation**: Document your customizations for future reference
- **Responsive design**: Ensure your template works well on different screen sizes
- **Accessibility**: Maintain accessibility features in your custom template
