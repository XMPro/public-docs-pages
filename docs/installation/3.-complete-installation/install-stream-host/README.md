# Install Stream Host

{% hint style="info" %}
**Want to run Stream Host in Docker?** Please jump to "[Docker instructions for Stream Host](docker.md)".
{% endhint %}

## Download the Connection Profile

Each Data Stream created in Data Stream Designer must belong to a [Collection](../../../concepts/collection.md). You can download the information in a Collection as a file, known as a Connection Profile. This profile includes the _device name, collection ID, server URL, secret,_ and _key_.

To simplify installing a Stream Host (also called a device), download the Connection Profile to avoid manually copying Collection details from Data Stream Designer to the installer.

To obtain a Connection Profile, follow the steps below.

1. [Log into Data Stream Designer](../../../administration/users/register-an-account.md) and open the _Collections_ page from the left-hand menu.
2. Select the Collection you wish to use. If there isn’t a Collection available, you can [create one](../../../how-tos/data-streams/manage-collections.md) by clicking the _New_ button, choosing a name for the collection, and clicking _Ok_.
3. Click on _Connection Profile_.
4. Choose a name for the device.
5. Enter the File Key.
6. Click _Ok_. The Connection Profile will automatically begin to download.

![Fig 1. Steps to Set Up a Connection Profile](<../../../.gitbook/assets/image (1761).png>)

## Download the Installer

Follow the steps below to download the XMPro Stream Host installer. From v4.4.7 onwards, ensure your network policy allows access to the `download.app.xmpro.com` domain.

1. Log into Data Stream Designer and open the _Collections_ page from the left-hand menu.
2. Select the collection you wish to use.
3. Click on _Download Host_.
4. Select your desired platform.
5. Click on the Download button to begin the download.

<figure><img src="../../../.gitbook/assets/Stream Host Install - Download.png" alt=""><figcaption><p>Fig 2. Steps to Download the Installer</p></figcaption></figure>

## Choose your Platform

Choose the platform where you will install the Stream Host:

{% content-ref url="windows-x64.md" %}
[windows-x64.md](windows-x64.md)
{% endcontent-ref %}

{% content-ref url="azure-web-job.md" %}
[azure-web-job.md](azure-web-job.md)
{% endcontent-ref %}

{% content-ref url="ubuntu-16.04+-x64.md" %}
[ubuntu-16.04+-x64.md](ubuntu-16.04+-x64.md)
{% endcontent-ref %}

{% content-ref url="docker.md" %}
[docker.md](docker.md)
{% endcontent-ref %}
