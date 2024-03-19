# Azure Data Explorer

<img src="../../../../../.gitbook/assets/Azure Data Explorer Icon.png" alt="" data-size="line"> The Azure Data Explorer Connector allows you to connect to an Azure Data Explorer instance and retrieve data as requested by the Application.

The Azure Data Explorer platform is a fully managed, high-performance, big data analytics platform that makes it easy to analyze high volumes of data in near real-time.&#x20;

Please see their [store page](https://azure.microsoft.com/en-us/services/data-explorer/) and [documentation](https://docs.microsoft.com/en-us/azure/data-explorer/) for more information about the Azure Data Explorer platform.&#x20;

Read on for an [example](examples.md),[ ](broken-reference)its [configuration](configuration.md), and [release notes](./#connector-release-notes).

## Live Updates

This Connector supports Live Updates, i.e. it can update the entity to display the most up-to-date information.&#x20;

This capability is available when the Connector is configured for time series data (See [Is Time Series](broken-reference)) and polling (See [Enable Polling](broken-reference)).

## Pre-requisites

The user must have credentials to an Azure subscription with permission to read Azure Data Explorer instances.

{% hint style="info" %}
Azure Data Explorer's Kusto limits the number of records returned to **500,000**, and the overall data size for those records to **64 MB**. Read more about limits on the result set size [here](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/concepts/query-limits#limit-on-result-set-size-result-truncation).
{% endhint %}

## Current Version

* [Request](mailto:support@xmpro.com?subject=AP-Connector-azure-data-explorer-connector-1.97) the Azure Data Explorer Connector v1.97

[Contact](mailto:support@xmpro.com?subject=azure-data-explorer-connector-older-version) XMPro if you're looking for an older version of this Connector.&#x20;

## Connector Release Notes

### v1.97, 22 Jun 2023

* Include Materialized Views in the Table property dropdown

### v1.96, 08 Mar 2023

* Handle column names with allowed special characters

### v1.95, 27 Feb 2023

* Made Column To Return optional unless Timeseries Aggregation is selected

### 2022

#### v1.94, 14 Oct 2022

* Fixed live update issue

#### v1.93, 26 Sep 2022

* Handle sub-queries within the ADX query

#### v1.92, 30 Jun 2022

* When the app page does not supply query parameter values during runtime, the Connector will use the original values that were specified as query parameters in the ADX query&#x20;

#### v1.91, 28 Jun 2022

* Disable default date filter parameters when using query parameters

#### v1.90, 27 Jun 2022

* Implemented query parameters functionality

#### v1.83, 22 Jun 2022

* Optimized aggregation query using shuffle strategy and materialize function

#### v1.82, 22 Jun 2022

* All non-numeric columns are added by default to the group by clause when using aggregation
* Changed the KQL operator from contains to has in filter module for better performance

#### v1.81, 21 Jun 2022

* Added help text to the Aggregation Parameters section: at least one column must be numeric

#### v1.80, 16 Jun 2022

* Added live update functionality

#### v1.70, 14 Jun 2022

* Added Timeseries dynamic aggregation functionality

### 2021

#### v1.60, 30 Nov 2021

* Resolved minor issue to make Sort, Take, and Order work at the source i.e. ADX

#### v1.50, 01 Sep 2021

* Added Insert and Update operations to the entity to support refresh on button click without actual insert/update functionality

#### v1.40, 28 Jun 2021

* Fixed issue with GetCustomQueryColumns

#### v1.30, 25 Jun 2021

* Name change

#### v1.20, 24 Jun 2021

* Non-static with token caching and HttpClient

#### v1.10, 23 Jun 2021

* Non-static without token caching

#### v1.00, 23 Jun 2021

* Initial Release
