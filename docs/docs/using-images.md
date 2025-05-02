# Using Images in Documentation

This page demonstrates how to include images in your DocFX documentation.

## Basic Image Inclusion

You can include images in your markdown files using the standard markdown syntax:

```markdown
![Alt text](../images/image-name.png)
```

## Example

Below is an example of a diagram showing the DocFX documentation generation workflow:

![DocFX Workflow](../images/docfx-workflow.md)

## Image Sizing and Alignment

While basic markdown doesn't support image sizing or alignment, you can use HTML to achieve these effects:

```html
<img src="../images/image-name.png" width="300" alt="Description" align="right" />
```

## Best Practices for Images

1. **Use descriptive filenames** - Name your images descriptively to make them easier to find and understand their purpose.
2. **Provide alt text** - Always include alternative text for accessibility.
3. **Optimize image size** - Compress images to reduce load times.
4. **Use appropriate formats** - Use PNG for diagrams and screenshots, JPEG for photographs.
5. **Keep images organized** - Store all images in a dedicated images folder.

## Using Diagrams

For complex concepts, diagrams can be more effective than text alone. Consider using tools like:

- [Mermaid](https://mermaid-js.github.io/mermaid/#/) for flowcharts and diagrams
- [PlantUML](https://plantuml.com/) for UML diagrams
- [Draw.io](https://app.diagrams.net/) for general-purpose diagrams
