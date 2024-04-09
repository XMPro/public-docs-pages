---
description: v4.4.1
---

# Visual Media Capture

The Visual Media Capture Block enables users to capture a photo or a video or upload an existing media file. This is useful when composing Applications such as a mobile inspection app and the user may be required to include an image when logging an issue. &#x20;

<figure><img src="../../.gitbook/assets/visual-media-main (1).png" alt=""><figcaption><p>Fig 1: Visual Media Capture Block</p></figcaption></figure>

## Visual Media Capture Properties

### Appearance

#### Common Properties

The _visibility_ property is common to most Blocks;

[See the Common Properties article for more details on common appearance properties.](../common-properties.md#appearance)

#### Capture Button Text

The text displayed on the capture button.

### Behavior

#### Common Properties

The _disabled_ property is common to most Blocks;

[See the Common Properties article for more details on common behavior properties.](../common-properties.md#behavior)

#### Allowed File Extensions

This allows you to specify the types of files that can be uploaded. If left blank, any file type can be uploaded.&#x20;

If a file extension is listed, (for example, a .png file), the Visual Media Capture will not allow you to upload any other file except those with a .png extension.

#### Max File Size

This setting dictates the maximum allowable file size for uploads. If you attempt to upload a file that exceeds the maximum size, it will not be uploaded.

### Value

#### Common Properties

The _value_ property is common to most Blocks;

[See the Common Properties article for more details on common value properties.](../common-properties.md#behavior-1)

### Validation

#### Common Properties

The _Validation Group and Required_ properties are common to most Blocks;

[See the Common Properties article for more details on common validation properties](../common-properties.md#validation).

#### Required Message

The text of the error message that is displayed to the user when no media file has been captured or uploaded.

<figure><img src="../../.gitbook/assets/Visual media capture required.png" alt=""><figcaption><p>Fig 2: Required Message</p></figcaption></figure>

#### Capture Failed Message

The text of the error message that is displayed to the user if the media capture fails for any reason.

<figure><img src="../../.gitbook/assets/Visual media capture failed.png" alt=""><figcaption><p>Fig 3: Capture Failed Message</p></figcaption></figure>
