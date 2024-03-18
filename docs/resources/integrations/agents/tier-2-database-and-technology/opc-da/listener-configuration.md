---
description: This section explains each of the properties in the configuration blade.
---

# Listener Configuration

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Config 1.png" alt=""><figcaption><p>Fig 1: OPC DA Listener Configuration</p></figcaption></figure>

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Config 2.png" alt=""><figcaption><p>Fig 2: OPC DA Listener Configuration - Items Section</p></figcaption></figure>

### General Properties

#### Collection

This associates the Agent to a specific Collection (default to that of the current Data Stream).

{% hint style="info" %}
Refer to [Collections and Stream Hosts](https://documentation.xmpro.com/collection) to understand more about Collections.
{% endhint %}

#### Polling Interval (seconds)

A timespan to specify how often should the Agent check for new data/changes or update its cache.

### Settings Properties

Once the [Server](listener-configuration.md#server) is provided, the Agent will attempt to connect to the specified OPC DA Server.

#### Use Variables

Tick to select the (manual) [Server Url](listener-configuration.md#server-url), [Username](listener-configuration.md#username), and [Password](listener-configuration.md#password) variables; or enter the text manually

#### Server

Select from the list of accessible OPC DA servers.

#### Specify Server Manually

Tick to manually enter the server URL (or use a _variable_), or select an accessible OPC DA server from the [Server](listener-configuration.md#server)

#### Server URL

The OPC DA Server to connect to (applies when [Specify Server Manually](listener-configuration.md#specify-server-manually) is ticked).

#### Use Authentication

Tick to use basic authentication.

#### Username

The name of the user used to authenticate with the server (applies when [Use Authentication](listener-configuration.md#use-authentication) is ticked).

#### Password

The password used to authenticate with the server (applies when [Use Authentication](listener-configuration.md#use-authentication) is ticked).

#### Include Timestamp

Tick to include in the output payload the most recent time the server assessed the value read from the device.

#### Include Quality

Tick to include in the output payload the representation of how well the cache value matches the device value, namely Good, Bad, or Uncertain.

#### Check For Quality

Tick to check the quality (Good/Bad) of the data being updated.&#x20;

#### Transpose Data By Equipment

Tick this option to add an Equipment column to the [Items grid](listener-configuration.md#items-grid-item-name-type-alias-equipment) - used when specifying the same set of tags for multiple equipment.

#### Import Tags From CSV File

Tick to populate the tag information using a [CSV file](listener-configuration.md#csv-file-template).

#### CSV Template File

Download this template, modify it to represent your tags, and upload it to [CSV File To Import](listener-configuration.md#csv-file-to-import) (applies when [Import Tags From CSV File](listener-configuration.md#import-tags-from-csv-file) is ticked).

#### CSV File To Import

Upload the CSV file that contains the tags you want to import (applies when [Import Tags From CSV File](listener-configuration.md#import-tags-from-csv-file) is ticked).

#### Enable Tag Browsing

Tick to use tag browsing to specify the Items to retrieve data (**not** available when [Import Tags From CSV File](listener-configuration.md#import-tags-from-csv-file) is ticked).

### Browse Tags/Items Properties

The method used to navigate/specify the Items to retrieve the data (applies when [Enable Tag Browsing](listener-configuration.md#enable-tag-browsing) is ticked).

When the Connection details are completed, the Agent attempts to authenticate with the OPC DA Server. If successful, the Server's Address Space is made available to the Agent, allowing the navigation of branches for the Branch Path and Levels.

#### Browse Type

The method used to navigate to the Node where the Item values are retrieved:&#x20;

* **Using Dot Notation**: the branch name and each child branch are separated by a dot.
* **Using Drill Down**: select each level of the branch.

#### Branch Path

The dot-separated Branch path to the Node where the Item values are retrieved (applies to **Using Dot Notation** [Browse Type](listener-configuration.md#browse-type) only). \
A path that is invalid or does not exist will not display any available Items.

Do not use dots (.) in the Branch names to ensure the Address Space is traversed correctly.

#### Level 1 (up to Level 10)

Select the Branch path to the Node where the Item values are retrieved - limited to 10 Levels (applies to **Using Drill Down** [Browse Type](listener-configuration.md#browse-type) only).&#x20;

### Data Mapping  Properties

#### Item Name Filter

Filter items by a specified value (applies when [Enable Tag Browsing](listener-configuration.md#enable-tag-browsing) is ticked).

Use \* as a wild card character.

#### Available Items

The available readable Item values for the branch specified at any Level or with a Branch Path (applies when [Enable Tag Browsing](listener-configuration.md#enable-tag-browsing) is ticked).

#### Add Selected Items

Tick to add the [Available Items](listener-configuration.md#available-items) selection to the [Items Grid](listener-configuration.md#items-grid-item-name-type-alias-equipment) (applies when [Enable Tag Browsing](listener-configuration.md#enable-tag-browsing) is ticked).

#### Items Grid (Item Name, Type, Alias, Equipment)

The grid defines the output payload:

* Item Name: The Branch Path of the Tag including its name.
* Type: The data type used as the column or attribute data type in the output payload. The options are String, Integer, Double, Boolean, DateTime, or Array. Select Array for Tags with a complex data type, such as a JSON formatted string.\
  Selecting a Type that does not match the Tag value will cause an error on the published data stream e.g., selecting "Double" for text.
* Alias: The name used as the column or attribute name in the output payload.
* Equipment: Identify which equipment this tag relates to (applies when [Transpose Data By Equipment](listener-configuration.md#transpose-data-by-equipment) is ticked).

### Endpoints

#### Output

An event per poll will be made available on this endpoint, with attributes matching the configured Tags Grid. Configure in settings whether to include the tag value's timestamp and quality too.

#### Error

Errors encountered during the execution of this Agent will be published on this endpoint.

### CSV File Template

Download this template, modify it to represent your tags, and upload it to [CSV File To Import](listener-configuration.md#csv-file-to-import) (applies when [Import Tags From CSV File](listener-configuration.md#import-tags-from-csv-file) is ticked).

{% file src="../../../../../.gitbook/assets/OpcDaTagsTemplate.csv" %}
