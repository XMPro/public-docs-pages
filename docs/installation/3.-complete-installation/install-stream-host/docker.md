---
description: v4.4.2
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: false
---

# Docker

## Introduction

The Stream Host Docker image is available from XMPro Platform v4.4.2+.

If your installation requires multiple Stream Hosts, please be aware that Stream Host [Variable Overrides](../../../how-tos/stream-host.md#how-to-override-variables) must be applied as environment variables when running as a Container - enabling frictionless automation when creating multiple Stream Host instances.

## Prerequisites

### **Hardware and Software**

A container runtime tool capable of running Docker images, such as [Docker Desktop](https://www.docker.com/products/docker-desktop/).

The XMPro Docker Stream Host image has already met the rest of the [**hardware** requirements](../../install.md#hardware-requirements) and [**software** requirements](../../install.md#software-requirements).

### Configuration Settings

The following configuration settings are required to run the Docker Stream Host. Locate these values before you proceed.

<table><thead><tr><th width="305">Key</th><th>Description</th><th data-hidden>Name</th></tr></thead><tbody><tr><td><code>xm:xmpro:Gateway:Id</code></td><td>A unique identifier for a Stream Host instance.<br><br>A <a href="https://www.guidgenerator.com/">Guid Generator</a> can be used to generate a unique identifier.</td><td></td></tr><tr><td><code>xm:xmpro:Gateway:CollectionId</code></td><td>The ID of your Collection.<br><br>This can be retrieved from a Data Stream Designer "Collection"</td><td></td></tr><tr><td><code>xm:xmpro:Gateway:Name</code></td><td>The name that appears in Data Stream Designer when viewing <a href="../../../how-tos/stream-host.md#how-to-find-online-hosts">Online Hosts</a>.<br><br>E.g. "<em>SH1-Device1-Docker</em>" or "<em>SH2-Device2-Winx64</em>".</td><td></td></tr><tr><td><code>xm:xmpro:Gateway:Secret</code></td><td>The secret key of your Collection.<br><br>This can be retrieved from a Data Stream Designer "Collection"</td><td><em>Server Url</em></td></tr><tr><td><code>xm:xmpro:Gateway:ServerUrl</code></td><td>The server url for where Data Stream Designer is hosted.<br><br>E.g. <em>"https://mysampleserver/datastreamdesigner/".</em> <br><br>Please note that this URL needs to end in a forward slash.</td><td><em>Collection ID</em></td></tr><tr><td><code>xm:xmpro:XMCryptography:TripleDES:Key</code></td><td>The key the Stream Host uses to encrypt/decrypt secure XMPo Stream Object settings, such as a SQL Server password. <br><br>As a Data Stream Designer Administrator, click the <em>Settings</em> icon and copy the value for the <em>Encryption Key</em></td><td><em>Key</em></td></tr></tbody></table>

These settings can be found in Data Stream Designer:

![Fig 1: Collection details in Data Stream Designer](<../../../.gitbook/assets/image (1489).png>)

## Repository

Below is the XMPro Docker Stream Host repository.

```
xmpro.azurecr.io/stream-host
```

## Image tags

All images are tagged with the release version number, starting from `4.4.2`. For example, use a version tag to reference the Stream Host for v4.4.2:&#x20;

```
xmpro.azurecr.io/stream-host:4.4.2
```

The `latest` tag identifies the most recent XMPro Platform release version number, for example:

```
xmpro.azurecr.io/stream-host:latest
```

## **Run Examples**

Please see the following examples to run Stream Host as a Container:

* [Docker Run](docker.md#docker-run)
* [Docker Compose](docker.md#docker-compose)

### Docker Run

Create an "envfile" containing the following (replacing `<values>` with the actual [Configuration Settings](docker.md#configuration-settings))

```yaml
xm:xmpro:Gateway:Id=<Unique ID>
xm:xmpro:Gateway:CollectionId=<Collection ID>
xm:xmpro:Gateway:Name=<Device Name>
xm:xmpro:Gateway:Secret=<Collection Secret>
xm:xmpro:Gateway:ServerUrl=<Server URL>
xm:xmpro:XMCryptography:TripleDES:Key=<Key>
```

#### Start

Run the Stream Host using the following command.

```bash
docker run --env-file=envfile --name stream-host xmpro.azurecr.io/stream-host:latest
```

#### **Stop**

Stop the Stream Host using the following command.

```bash
docker rm -f stream-host
```

### **Docker Compose**

Create a file called `compose.yaml` in your working directory and paste the following (replacing `<values>` with the actual [Configuration Settings](docker.md#configuration-settings)):

```yml
stream-host:
  image: xmpro.azurecr.io/stream-host:latest
  container_name: 'stream-host'
  environment:
      - xm:xmpro:Gateway:Id=<Unique ID>
      - xm:xmpro:Gateway:CollectionId=<Collection ID>
      - xm:xmpro:Gateway:Name=<Device Name>
      - xm:xmpro:Gateway:Secret=<Collection Secret>
      - xm:xmpro:Gateway:ServerUrl=<Server URL>
      - xm:xmpro:XMCryptography:TripleDES:Key=<Key>
  restart: on-failure
```

{% hint style="info" %}
See [Docker Compose Overview](https://docs.docker.com/compose/) for further details on how to use Docker Compose.
{% endhint %}

#### Start

In the same working directory as`compose.yaml`, run the following command to start the Stream Host.

```bash
docker-compose up -d stream-host 
```

#### **Stop**

In the same working directory as`compose.yaml`, run the following command to stop the Stream Host.

```bash
docker-compose down
```

## Next Step: Agents & Connectors

The stream host installation is complete. Please click below to install the default Agents & Connectors:

{% content-ref url="../install-connectors.md" %}
[install-connectors.md](../install-connectors.md)
{% endcontent-ref %}
