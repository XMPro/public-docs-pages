# OPC DA

<img src="../../../../../.gitbook/assets/opc (2).png" alt="" data-size="line">   [OPC DA](https://opcfoundation.org/developer-tools/specifications-classic/data-access/), or "OLE for Process Control - Data Access", is a set of classic standards and specifications used in industrial automation and process control systems. It is a communication protocol that enables data exchange between industrial automation devices and software applications, primarily for real-time data access and monitoring.

The [**Listener**](listener-example.md) allows you to retrieve tag values on the OPC DA Server.&#x20;

The [**Action Agent**](action-agent-example.md) allows you to publish the supplied tag values and timestamps on the OPC DA Server.&#x20;

## Pre-requisites

[This redistributable](https://opcfoundation.org/developer-tools/samples-and-tools-classic/core-components) **must** be installed on the Stream Host server if the OPC DA environment is not hosted on the same server.

## Current Version

* [Request](mailto:support@xmpro.com?subject=Listener-opc-da-1.46) the OPC DA Listener v1.46
* [Request](mailto:support@xmpro.com?subject=Action-Agents-opc-da-1.33) the OPC DA Action Agent v1.33

Please [contact](mailto:support@xmpro.com?subject=opc-ua-older-version) XMPro if you're looking for an older version of this Agent.&#x20;

## OPC DA Listener Release Notes

### v1.46, 06 Mar 2024

* Added variable support
* Standardized property names
* Handled error when opening previously configured agent
* Optimized Agent's UI flow

### v1.45, 12 Jan 2024

* Added support to include the Quality of each tag value in the output payload

### v1.44, 21 Nov 2023

* Repackaged to standardize the Agent name

### v1.43, 14 Nov 2023

* Return null value for tags that are not defined for some equipment

### v1.42, 13 Nov 2023

* Added support to import tags from CSV file
* Added support to transpose data by Equipment ID

### v1.32, 30 Oct 2023

* Repackaged the resource to be in the resource group&#x20;

### v1.31, 26 Oct 2023

* Added error handling if pre-requisite redistributable is not installed
  * Error check added to the Integrity Check
  * Handle error gracefully when a new Agent is added to the canvas and configuration opened

### 2020

#### v1.3, 18 Sep 2020

* Added name filter and limiting results to 100

#### v1.2, 10 Sep 2020

* Added tag browsing functionality&#x20;

#### v1.1, 28 Aug 2020

* Added server discovery and authentication options&#x20;

#### v1.03, 22 May 2020

* Moved connection and disconnection into runtime function to reduce the chance of connection errors

#### v1.02, 22 May 2020

* Added additional checks to ensure that the server is connected before it attempts to read server data

#### v1.01, 18 May 2020

* Added error handling&#x20;

#### v1.0, 06 May 2020

* Initial release&#x20;

#### v0.5, 03 Apr 2020

* First draft

## OPC DA Action Agent Release Notes

### v1.33, 06 Mar 2024

* Added variable support
* Standardized property names
* Handled error when opening previously configured agent

### v1.32, 21 Nov 2023

* Repackaged to standardize the Agent name

### v1.31, 26 Oct 2023

* Added error handling if pre-requisite redistributable is not installed
  * Error check added to the Integrity Check
  * Handle error gracefully when a new Agent is added to the canvas and configuration opened

### 2020

#### v1.3, 18 Sep 2020

* Added name filter and limiting results to 100 items

#### v1.2, 10 Sep 2020

* Added tag browsing functionality&#x20;

#### v1.1, 28 Aug 2020

* Added server discovery and authentication options&#x20;

#### v1, 18 May 2020

* Initial Release
