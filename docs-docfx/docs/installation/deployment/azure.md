# Azure

This document will guide you through how to set up the Azure infrastructure and deploy the XMPro Platform.

* [Install](#install)
* [Upgrade](#upgrade)
* [Uninstall](#uninstall)

## Architecture

The following deployment diagram shows an example architecture and the necessary resources for the XMPro platform in Microsoft Azure.

![Example XMPro architecture in Azure](../images/Azure_Architecture.png)

Set up of Cloud Stream Host, Master Data, [Azure Cache](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-dotnet-how-to-use-azure-redis-cache), or [Twilio](../index.md#twilio-account-optional) is optional and is dependent on client requirements. As a result, these resources will be excluded from this deployment.

## Prerequisites

In order to proceed with the deployment, you are required to complete the steps in the **1. Preparation** guide:

1. Select Azure resources that meet the [**hardware** requirements](../index.md#hardware-requirements) and [**software** requirements](../index.md#software-requirements).
2. Follow the [certificate and communication steps](../index.md#preparation-steps) for an [SMTP Account](../index.md#smtp-account) (Recommended).

As well as having:

* Azure portal administrative access
* Access to Subscription and Resource group

## Install

This section provides information about installing the XMPro platform from scratch in Azure.

1. Log on to the Azure Portal [https://portal.azure.com/](https://portal.azure.com/) (with Company Administrator access)
2. In the search bar type "Deploy" and select "Deploy a custom template"

![](../images/Azure-ARMTemplate-Search.PNG)

3. Click "Build your own template in the editor"

![](../images/image_146.png)

4. Download the latest mainTemplate_[Version].json file from your XMPro account manager or support team.

5. Select "Load File" and then Open the downloaded "mainTemplate_[Version].json"

![](../images/Azure-ARMTemplate-Upload.PNG)

6. Once loaded, click Save - do not change the template.

![](../images/Azure-ARMTemplate-Save.PNG)

7. Complete the form.

> [!WARNING]
> * Enter the username in the correct format i.e. firstname.lastname@companyname.onxmpro.com
> * The following special characters are **not** supported in the passwords: `` ` ' \ $ @ ``
> * Take note of the passwords used as this will not be displayed again and they are required later.

![](../images/Azure-ARMTemplate-Form.PNG)

8. Verify the information is correct and click Create.

![](../images/image_338.png)

After successful deployment, the following items have been installed:

* Subscription Manager
* Data Stream Designer
* App Designer
* Stream Host

Proceed to [Restart the App Services](#restarting-app-services) after they are all deployed.

### Restarting App Services

This step explains how to restart your app services in the Azure Portal.

1. Type "Resource groups" in the search bar and select "Resource groups".

![](../images/Azure-ARMTemplate-Restart-1.PNG)

2. Search for the Resource Group created during installation and select it.

![](../images/Azure-ARMTemplate-Restart-2.PNG)

3. Select Subscription Manager, Data Stream Designer, and App Designer and restart the applications.

![](../images/Restart_3.png)

4. The below GIF shows how to restart your app service.

![](../images/PI2GwPRNfr.gif)

### Logins

| User | Type | Password |
|------|------|----------|
| admin@xmpro.onxmpro.com | Super Admin | as entered during setup |
| firstname.lastname@companyname.onxmpro.com | Admin | as entered during setup |

### Request a License

A new company is created as part of the installation process but needs a valid license to work.

> [!NOTE]
> Login using the Super Admin account **admin@xmpro.onxmpro.com**.

1. Click Company in the left menu to open the Companies page.
2. Click on the Company.
3. Click on the Subscriptions gauge to open the Subscriptions page.
4. Click on a Subscription.
5. Click the Update License button in the command bar.
6. Click _Generate a license request_, enter the number of days, and submit.
7. When you have received the license from [XMPro support](http://xmpro.com/support/), upload it.
8. Click Save.

This sends a request to XMPro for an App Designer license for this Company.

![](../images/image_423.png)

> [!WARNING]
> The _Generate a license request_ link will only work if SMTP was set up during installation.

9. Change the Product to Data Stream Designer from the list and request another license

> [!NOTE]
> Licenses are given on an individual basis by the [XMPro support team](http://xmpro.com/support/).

When you have received a license for each product through an email sent to the email address given during installation, follow the steps below to upload the license for both App Designer and Data Stream Designer.

![](../images/License_3.png)

### Next Step: Complete Installation

The installation of the XMPro Platform is now complete but before you can use the platform, some steps are needed to set up the environment. Further instructions about the configuration can be found below:

[Install Connectors](../complete-installation/install-connectors.md)

## Upgrade

> [!WARNING]
> Before beginning the upgrade, back up databases using [this](https://docs.microsoft.com/en-us/azure/azure-sql/database/database-export#the-azure-portal) guide.

Follow the same steps as a new [Install](#install) to upgrade your XMPro platform. Make sure to:

* Download and use the latest "mainTemplate_[Version].json".
* Use the same Resource Group and credentials used during the **original** Install when completing the Custom deployment form.

![](../images/Azure-ARMTemplate-Upgrade.PNG)

## Uninstall

This section provides information about uninstalling the XMPro platform from Azure.

1. Open the resource group where XMPro is installed
2. Click Delete resource group

![](../images/Delete_1.png)

3. Enter the name of the resource group and click _Delete_

![](../images/Azure-ARMTemplate-Delete.PNG)
