# Azure Digital Twin Connector

<img src="../../../../../.gitbook/assets/AzureDigitalTwin.png" alt="" data-size="line"> The Azure Digital Twin Connector allows you to connect your Data Stream to an Azure Digital Twins instance.

The Azure Digital Twin platform is a cloud-based IoT offering that helps you create digital representations of real-world devices or business entities, including their intrinsic attributes as well as their relationships with each other. For more information about the Azure Digital Twin platform, please see their [store page](https://azure.microsoft.com/en-us/services/digital-twins/) and [documentation](https://docs.microsoft.com/en-us/azure/digital-twins/).

Read on for an [example](azure-digital-twin-connector-example.md), its [configuration](azure-digital-twin-connector-configuration.md), and [release notes](./#connector-release-notes).

## Live Updates

This Connector supports Live Updates, i.e. it can update the entity to display the most up-to-date information.&#x20;

This capability is available when the Connector is configured for polling (See [Enable Polling](azure-digital-twin-connector-configuration.md#enable-polling)).

## Pre-requisites

The following is required to use this Connector:

* The credentials of an [Azure App Registration](https://learn.microsoft.com/en-us/azure/digital-twins/how-to-create-app-registration?tabs=portal) with permission to read the Azure Digital Twin instance.&#x20;

## Current Version

* [​Request](mailto:support@xmpro.com?subject=AP-Connector-azure-digital-twin-connector-1.10) the Azure Digital Twin Connector v1.10

[Contact](mailto:support@xmpro.com?subject=azure-digital-twin-connector-older-version) XMPro if you're looking for an older version of this Agent.&#x20;

## Connector Release Notes

### v1.10, 16 May 2023

* Replace the deprecated Time Series Insights integration with Azure Data Explorer.

### v1.09, 14 Sep 2022

* Resolved App Designer's inability to save changes when the Fetch Properties button was not clicked at least once.

### v1.08, 09 Sep 2022

* Added support for custom Digital Twins query

### 2021

#### v1.07, 01 Nov 2021

* Added support to get asset hierarchy

### 2020

#### v1.06, 20 Nov 2020

* Added relationships and relationship properties to Digital Twins

#### v1.05, 11 Nov 2020

* Added parameter to Time Series for Read range beginning

#### v1.04, 04 Nov 2020

* Entities are sorted into a tree list based on Digital Twin or Time Series
* Digital Twin entities can now be updated

#### v1.03, 27 Oct 2020

* Connector can now read from Time Series Insights events

#### v1.02, 16 Oct 2020

* Added option to use variables to connect to Azure Digital Twins app

#### v1.01, 15 Oct 2020

* Added polling for live updates

#### v1.00, 12 Oct 2020

* Initial Release
