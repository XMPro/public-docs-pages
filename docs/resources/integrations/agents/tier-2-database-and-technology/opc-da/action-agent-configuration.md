---
description: This section explains each of the properties in the configuration blade.
---

# Action Agent Configuration

<figure><img src="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FLkywF9HJKaAEjXLqd6oc%2Fuploads%2FvFA9xHjjGL8JAxfvMz26%2FAction%20Agent%20Config%201.png?alt=media&#x26;token=df38104b-7440-4d0c-8904-d0449d8fc57d" alt=""><figcaption><p>Fig 1: OPC DA Action Agent Configuration</p></figcaption></figure>

<figure><img src="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FLkywF9HJKaAEjXLqd6oc%2Fuploads%2FGp2Ln2RJSMbWDDfySy0n%2FAction%20Agent%20Config%202.png?alt=media&#x26;token=7ba16ab8-567c-4247-9c8d-08f76946cce9" alt=""><figcaption><p>Fig 2: OPC DA Action Agent Configuration - Data Mapping Section</p></figcaption></figure>

### General Properties

#### Collection

This associates the Agent to a specific Collection (default to that of the current Data Stream).

{% hint style="info" %}
Refer to [Collections and Stream Hosts](https://documentation.xmpro.com/collection) to understand more about Collections.
{% endhint %}

### Settings Properties

Once the [Server](action-agent-configuration.md#server) is provided, the Agent will attempt to connect to the specified OPC DA Server.

#### Use Variables

Tick to select the (manual) [Server Url](action-agent-configuration.md#server-url), [Username](action-agent-configuration.md#username), and [Password](action-agent-configuration.md#password) variables; or enter the text manually.

#### Server

Select from the list of accessible OPC DA servers.

#### Specify Server Manually

Tick to manually enter the [Server URL](action-agent-configuration.md#server-url) (or use a _variable_), or select an accessible OPC DA server from the [Server](action-agent-configuration.md#server).

#### Server Url

The OPC DA Server to connect to (applies when [Specify Server Manually](action-agent-configuration.md#specify-server-manually) is ticked).

#### Use Authentication

Tick to use basic authentication.

#### Username

The name of the user used to authenticate with the server (applies when [Use Authentication](action-agent-configuration.md#use-authentication) is ticked).

#### Password

The password used to authenticate with the server (applies when [Use Authentication](action-agent-configuration.md#use-authentication) is ticked).

#### Specify Quality

Tick to add an "Item Quality" property to the [Mapping Grid](action-agent-configuration.md#mapping-grid-item-name-item-value-item-quality-item-timestamp) to specify the quality (Good/Bad) of the updated data.

#### Specify Time Stamp

Tick to add an "Item Timestamp" property to the [Mapping Grid](action-agent-configuration.md#mapping-grid-item-name-item-value-item-quality-item-timestamp) to specify the timestamp of the updated data.

#### Enable Tag Browsing

Tick to use tag browsing to specify the Items to update; or enter the [Mapping Grid](action-agent-configuration.md#mapping-grid-item-name-item-value-item-quality-item-timestamp) values manually.

### Browse Tags/Items

The method used to navigate/specify the Items to update (applies when [Enable Tag Browsing](action-agent-configuration.md#enable-tag-browsing) is ticked).

When the Connection details are completed, the Agent attempts to authenticate with the OPC DA Server. If successful, the Address Space of the Server is made available to the Agent, allowing the navigation of branches for the Branch Path and Levels.

#### Browse Type

The method used to navigate to the Node where the Item values are retrieved:&#x20;

* **Using Dot Notation**: the branch name and each child branch are separated by a dot.
* **Using Drill Down**: select each level of the branch.

#### Branch Path

The dot-separated Branch path to the Node where the Item values are retrieved (applies to **Using Dot Notation** [Browse Type](action-agent-configuration.md#browse-type) only). A path that is invalid or does not exist will not display any available Items.&#x20;

Do not use dots (.) in the Branch names to ensure the Address Space is traversed correctly.

#### Level 1 (up to Level 10)

Select the Branch path to the Node where the Item values are retrieved - limited to 10 Levels (applies to **Using Drill Down** [Browse Type](action-agent-configuration.md#browse-type) only).&#x20;

### Items Properties

A wizard used to populate the Items to update in the [Mapping Grid](action-agent-configuration.md#mapping-grid-item-name-item-value-item-quality-item-timestamp) (applies when [Enable Tag Browsing](action-agent-configuration.md#enable-tag-browsing) is ticked).

#### Item Name Filter&#x20;

Filter items by specified value.&#x20;

Use \* as wild card character.

#### Available Item

The available Item values for the branch, specified at any Level or with a Branch Path.

#### Add Selected Item

Tick to add the [Available Item](action-agent-configuration.md#available-item) selection to the [Mapping Grid](action-agent-configuration.md#mapping-grid-item-name-item-value-item-quality-item-timestamp).

### Data Mapping Properties

#### Mapping Grid (Item Name, Item Value, Item Quality, Item Timestamp)

The grid defines the output payload and the values to be published:

* Item Name: The Branch Path of the Item including its name where the Item Value will be published.
* Item Value: The column or attribute of the input payload that contains the value to publish.\
  \
  Assigning an Item Value that does not match the Type of that Item will cause an error on the published data stream e.g., selecting "Double" for text.&#x20;
* Item Quality:  The column or attribute of the input payload that contains the (Good/Bad) quality (applies when [Specify Quality](action-agent-configuration.md#specify-quality) is ticked).
* Item Timestamp:  The column or attribute of the input payload that contains the timestamp that the value changed (applies when [Specify Time Stamp](action-agent-configuration.md#specify-time-stamp) is ticked).

{% hint style="warning" %}
Before configuring the Action Agent, please ensure that its input endpoint is connected to a parent Agent which will be sending data to it.
{% endhint %}

### Endpoints

#### Input

This endpoint is used to receive data from the parent Agent.

#### Output

Events received from the parent Agent are published to the OPC DA server and made available to this endpoint with unchanged attributes and data.

#### Error

Errors encountered during the execution of this Agent will be published on this endpoint.
