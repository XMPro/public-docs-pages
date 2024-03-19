---
description: This section explains each of the properties in the configuration blade.
---

# Azure Digital Twin Connector Configuration

![Fig 1: Azure Digital Twin Connector configuration](<../../../../../.gitbook/assets/ADT Connector Config 1.png>)

![Fig 2: Azure Digital Twin Connector's Azure Data Explorer configuration](<../../../../../.gitbook/assets/ADT Connector Config 2.png>)

### General Properties

#### Name

The name that will appear in the Data Source list.

### Authentication Properties

#### Use Variables

Tick to select saved variables for the [Tenant ID](azure-digital-twin-connector-configuration.md#tenant-id), [Client ID](azure-digital-twin-connector-configuration.md#client-id), [Client Secret](azure-digital-twin-connector-configuration.md#client-secret), [Endpoint Uri](azure-digital-twin-connector-configuration.md#endpoint-uri), [Cluster](azure-digital-twin-connector-configuration.md#cluster), [ADX Client ID](azure-digital-twin-connector-configuration.md#client-id-1), and [ADX Secret Key](azure-digital-twin-connector-configuration.md#secret-key) properties; or enter the text manually.

#### Tenant ID

The ID of the tenant to which the Client belongs.

#### Client ID

The ID of the Azure App Registration the Connector will use to connect to the Azure Digital Twin instance.

#### Client Secret

The Secret of the Azure App Registration the Connector will use to connect to the Azure Digital Twin instance.

### Digital Twins Properties

<figure><img src="../../../../../.gitbook/assets/ADT Connector Config 3.png" alt=""><figcaption><p>Fig 3: Azure Digital Twin Connector's query configuration</p></figcaption></figure>

#### Endpoint Uri

The Host Name of the Azure Digital Twins instance. This is in the format "https://\*\*\*.api.aue.digitaltwins.azure.net".

#### Specify Query

Tick to enable custom query input. The results of the custom query will be available as a separate entity.

#### Query

Enter a custom Digital Twin query (applies when [Specify Query](azure-digital-twin-connector-configuration.md#specify-query) is ticked).

#### Fetch Query Properties

Click to populate [Query Properties](azure-digital-twin-connector-configuration.md#query-properties-name-type) and [Primary Key](azure-digital-twin-connector-configuration.md#primary-key), based on the [Query](azure-digital-twin-connector-configuration.md#query) entered (applies when [Specify Query](azure-digital-twin-connector-configuration.md#specify-query) is ticked). The [Type](azure-digital-twin-connector-configuration.md#query-properties-name-type) may need adjusting if the sample data is inconclusive.&#x20;

#### Query Properties (Name, Type)

The Name and Type of each column in the source query, as they will appear in the output payload (applies when [Specify Query](azure-digital-twin-connector-configuration.md#specify-query) is ticked).&#x20;

The attribute data types used for the output payload are String, Long, Double, Boolean, DateTime, or Integer. &#x20;

#### Primary Key

The columns or attributes returned by the query that represents a unique and distinct key for every result (applies when [Specify Query](azure-digital-twin-connector-configuration.md#specify-query) is ticked).

### Azure Data Explorer Properties

The Connector can also fetch data from the integrated Azure Data Explorer instance.

#### Cluster

The Host Name used to create, start, edit, list, terminate, and delete clusters - in the format _https://{clusterName}.{location}.kusto.windows.net_. \
\
You can find the URL on the Azure Portal blade for the Data Explorer Cluster under the "URI" property.

#### Override Client Secret

Tick if the ADX instance Client ID and Secret Key differ from the [Client ID](azure-digital-twin-connector-configuration.md#client-id) and [Secret Key](azure-digital-twin-connector-configuration.md#client-secret) of the Digital Twin.

#### Client ID

The Client ID of the ADX Cluster (applies when [Override Client Secret](azure-digital-twin-connector-configuration.md#override-client-secret) is ticked).

#### Secret Key

The Secret Key of the ADX Cluster (applies when [Override Client Secret](azure-digital-twin-connector-configuration.md#override-client-secret) is ticked).

#### Database

The name of the database to connect to.\
Once selected, the [Table](azure-digital-twin-connector-configuration.md#table) property is populated with the list of available tables in the database.

#### Table

The name of the table to connect to.

#### Default Range (hours)

A timespan to specify how often to fetch events, starting from the time of the request and working backward.

### Live Notifications Properties

#### Enable Polling

Tick to enable fetching the latest up-to-date information by polling the Digital Twin and Time Series instances.

#### Polling Interval (seconds)

A timespan to specify how often the Connector should check for new data/changes and update its cache (applies when [Enable Polling](azure-digital-twin-connector-configuration.md#enable-polling) is ticked).
