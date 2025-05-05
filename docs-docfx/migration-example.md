# GitBook to DocFX Migration Example

This document provides a practical example of migrating a GitBook page to DocFX using the AI migration helper script.

## Example GitBook File

Let's assume we have the following GitBook markdown file located at `docs-gitbook/docs/concepts/data-stream/example.md`:

```markdown
# Data Stream Example

This page demonstrates how to work with data streams in XMPro.

{% hint style="info" %}
Data streams are a core component of the XMPro platform and allow you to process real-time data from various sources.
{% endhint %}

## Creating a Data Stream

To create a data stream, follow these steps:

1. Navigate to the Data Streams page
2. Click on the "New Data Stream" button
3. Enter a name for your data stream
4. Configure the data stream properties

![Data Stream Creation](../../.gitbook/assets/data-stream-creation.png)

## Data Stream Types

XMPro supports different types of data streams:

{% tabs %}
{% tab title="Standard Stream" %}
Standard streams process data in real-time without any special handling.
{% endtab %}
{% tab title="Windowed Stream" %}
Windowed streams process data in time-based or count-based windows.
{% endtab %}
{% tab title="Stateful Stream" %}
Stateful streams maintain state between events.
{% endtab %}
{% endtabs %}

## Related Pages

- [Running Data Streams](running-data-streams.md)
- [Verifying Stream Integrity](verifying-stream-integrity.md)
- [Timeline](timeline.md)
```

## Migration Process

### Step 1: Analyze the Content

First, let's analyze the GitBook structure to understand the content patterns:

```powershell
.\ai-migration-helper.ps1 -Mode analyze -Section "concepts/data-stream"
```

This would output something like:

```
[2025-05-05 19:10:00] [INFO] Analyzing directory structure: docs-gitbook/docs/concepts/data-stream
[2025-05-05 19:10:01] [INFO] Found 4 Markdown files
[2025-05-05 19:10:01] [INFO] Summary files: 0
[2025-05-05 19:10:01] [INFO] README files: 0
[2025-05-05 19:10:01] [INFO] Other Markdown files: 4
[2025-05-05 19:10:01] [INFO] GitBook hint patterns found: 1
[2025-05-05 19:10:01] [INFO] GitBook tab patterns found: 1
[2025-05-05 19:10:01] [INFO] Image references found: 1
[2025-05-05 19:10:01] [INFO] Internal links found: 3
```

### Step 2: Convert the Content

Next, let's convert the GitBook content to DocFX format:

```powershell
.\ai-migration-helper.ps1 -Mode convert -Section "concepts/data-stream"
```

This would process the file and convert it to DocFX format, handling:
- GitBook hint patterns → DocFX alerts
- GitBook tabs → DocFX tabs
- Image path updates
- Internal link updates

### Step 3: Process Images

Now, let's process the images:

```powershell
.\ai-migration-helper.ps1 -Mode images -Section "concepts/data-stream"
```

This would copy the image from `docs-gitbook/docs/.gitbook/assets/data-stream-creation.png` to `docs-docfx/docs/concepts/data-stream/images/data-stream-creation.png`.

### Step 4: Generate TOC

If there was a SUMMARY.md file in the section, we would generate a toc.yml file:

```powershell
.\ai-migration-helper.ps1 -Mode toc -Section "concepts/data-stream"
```

Since our example doesn't have a SUMMARY.md file, we would need to create a toc.yml file manually or update an existing one.

### Step 5: Verify the Migration

Finally, let's verify the migration:

```powershell
.\ai-migration-helper.ps1 -Mode verify -Section "concepts/data-stream"
```

This would check for:
- Remaining GitBook syntax
- Broken image links
- Broken internal links

## Resulting DocFX File

After the migration, the file at `docs-docfx/docs/concepts/data-stream/example.md` would look like this:

```markdown
# Data Stream Example

This page demonstrates how to work with data streams in XMPro.

> [!NOTE]
> Data streams are a core component of the XMPro platform and allow you to process real-time data from various sources.

## Creating a Data Stream

To create a data stream, follow these steps:

1. Navigate to the Data Streams page
2. Click on the "New Data Stream" button
3. Enter a name for your data stream
4. Configure the data stream properties

![Data Stream Creation](../images/data-stream-creation.png)

## Data Stream Types

XMPro supports different types of data streams:

# [Standard Stream](#tab/standard-stream)
Standard streams process data in real-time without any special handling.

# [Windowed Stream](#tab/windowed-stream)
Windowed streams process data in time-based or count-based windows.

# [Stateful Stream](#tab/stateful-stream)
Stateful streams maintain state between events.

***

## Related Pages

- [Running Data Streams](running-data-streams.md)
- [Verifying Stream Integrity](verifying-stream-integrity.md)
- [Timeline](timeline.md)
```

## TOC File Example

A corresponding toc.yml file for the data-stream section might look like this:

```yaml
- name: Data Stream Overview
  href: index.md
- name: Data Stream Example
  href: example.md
- name: Running Data Streams
  href: running-data-streams.md
- name: Verifying Stream Integrity
  href: verifying-stream-integrity.md
- name: Timeline
  href: timeline.md
```

## Using AI to Assist with Migration

When using generative AI tools to assist with the migration, you could provide the GitBook content and ask the AI to convert it:

```
Please convert this GitBook markdown file to DocFX format following the patterns in the AI-optimized migration plan:

# Data Stream Example

This page demonstrates how to work with data streams in XMPro.

{% hint style="info" %}
Data streams are a core component of the XMPro platform and allow you to process real-time data from various sources.
{% endhint %}

...
```

The AI would then process the content and return the converted DocFX format, which you could save to the appropriate file.

## Conclusion

This example demonstrates the process of migrating a GitBook page to DocFX using the AI migration helper script. By following these steps and using the provided tools, you can efficiently migrate your documentation while maintaining content integrity and structure.
