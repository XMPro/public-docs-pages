---
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

## Prerequisites

**Environment Variables**

Create the following environment variables:

* _Server Url -_ This is the server where Data Stream Designer is hosted, for example: “_https://mysampleserver/datastreamdesigner/_“. Please note that this URL needs to end in a forward slash.
* _Collection ID -_ This is the ID of your Collection and can be copied from Data Stream Designer.
* C_ollection Secret -_ This is the secret key of your Collection and can be copied from Data Stream Designer.
* _Device Name_ - This is the name that appears when you view the installed Stream Host online, for example, SH1-Device1-Docker, SH2-Device2-Winx64.
* _Key -_ This is the key that the Stream Host will use to encrypt or decrypt secure [user settings](https://docs.xmpro.com/docs/data-stream-designer/concepts/agents/#agent-components), for example, a SQL Server password. As a DS Administrator, click the _Settings_ icon and copy the value for the _Encryption Key_
* _Unique ID_ - Use [https://www.guidgenerator.com/](https://www.guidgenerator.com/) to generate a unique identifier.

These settings can be found in Data Stream Designer:

![Fig 1: Collection details in Data Stream Designer](<../../../.gitbook/assets/image (1489).png>)

**Hardware and Software**

XMPro Stream Host requires certain hardware and software specifications to install and run. Complete these steps in the **1. Preparation** guide:

1. Meet the [**hardware** requirements](../../install.md#hardware-requirements)
2. Install the [**software** requirements](../../install.md#software-requirements)

## **Install**

Install the Stream Host using the following command:

```bash
docker run  --env-file=envfile --name stream-host xmpro.azurecr.io/stream-host:latest
```

With the environment variables created under prerequisites.

```yaml
#envfile contents
xm:xmpro:Gateway:ServerUrl=<Server URL>
xm:xmpro:Gateway:Id=<Unique ID>
xm:xmpro:Gateway:CollectionId=<Collection ID>
xm:xmpro:Gateway:Secret=<Collection Secret>
xm:xmpro:Gateway:Name=<Device Name>
xm:xmpro:XMCryptography:TripleDES:Key=<Key>
xm:xmpro:Gateway:featureFlags:enableLegacyCore=false
```

#### **Docker Compose Example**

```yml
stream-host:
  image: xmpro.azurecr.io/stream-host:latest
  container_name: 'stream-host'
  environment:
      - xm:xmpro:Gateway:ServerUrl=<Server URL>
      - xm:xmpro:Gateway:Id=<Unique ID>
      - xm:xmpro:Gateway:CollectionId=<Collection ID>
      - xm:xmpro:Gateway:Secret=<Collection Secret>
      - xm:xmpro:Gateway:Name=<Device Name>
      - xm:xmpro:XMCryptography:TripleDES:Key=<Key>
      - xm:xmpro:Gateway:featureFlags:enableLegacyCore=false
  restart: on-failure
```

```bash
docker-compose up -d stream-host 
```

## Uninstall/Stop

To uninstall a Stream Host, use the following command if docker run was used:

```bash
docker rm -f stream-host
```

To uninstall a Stream Host, use the following command if docker-compose was used:

```bash
docker-compose down
```

## Next Step: Agents & Connectors

The stream host installation is complete. Please click below to install the default Agents & Connectors:

{% content-ref url="../install-connectors.md" %}
[install-connectors.md](../install-connectors.md)
{% endcontent-ref %}
