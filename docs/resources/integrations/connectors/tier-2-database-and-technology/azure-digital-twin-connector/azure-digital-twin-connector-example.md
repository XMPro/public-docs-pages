---
description: >-
  This example Application demonstrates how to read pump data from a Digital
  Twin instance using the Azure Digital Twin Connector.
---

# Azure Digital Twin Connector Example

You can download the files [here](azure-digital-twin-connector-example.md#files) to try it out for yourself - adjusting the steps to use your **own** Azure credentials.&#x20;

{% hint style="info" %}
Refer to [configuration](azure-digital-twin-connector-configuration.md) to understand all configuration options of this Connector.
{% endhint %}

### Step 1: Add the Connection

From the Properties blade of the widget to which the Digital Twin Connector will be linked, a data grid in our example, select the Data Source tab.&#x20;

Click the plus icon next to Data Source and then the plus icon next to Connection.

![Step 1a: Add the Connection](<../../../../../.gitbook/assets/ADT Connector Step 1.png>)

Select the Azure Digital Twin Connector and enter a name for the connection. In this case, set the name to "Pump Data".

<figure><img src="../../../../../.gitbook/assets/ADT Connector Step 1b.png" alt=""><figcaption><p>Step 1b: Select the Connector</p></figcaption></figure>

### Step 2: Configure Authentication

Enter the authentication details: the Tenant ID, Client ID, and Client Secret. In this case, tick to use variables.

![Step 2: Configure Authentication](<../../../../../.gitbook/assets/ADT Connector Step 2.png>)

### Step 3: Configure Digital Twins

Select the Endpoint Uri for the Azure Digital Twin instance. Keep the default range as 24 hours and live notifications unticked.

Click Save.

![Step 3: Configure Digital Twins](<../../../../../.gitbook/assets/ADT Connector Step 3.png>)

### Step 4: Use the Connection

Use the Connection that was just created to complete entering the new Data Source. Save the Data Source.

In this case, set the name to "Pump Data", the connection to "Pump Data", and entity to "Pump".

**Note:** the primary key is auto-populated once the entity is selected.

![Step 4: Use the Connection](<../../../../../.gitbook/assets/ADT Connector Step 4.gif>)

### Step 5: Use the Data Source

Select the Data Source we just added, and save the Application. Click the Launch button and view the data grid.

![Step 5: Use the Data Source](<../../../../../.gitbook/assets/ADT Connector Step 5.gif>)

### Step 6: Results

Observe that data is returned from the Pump entity of the Azure Digital Twin.

![Step 6: Results](<../../../../../.gitbook/assets/ADT Connector Step 6.gif>)

### Files

<table><thead><tr><th width="150">File</th><th width="373.9375" data-type="files">Link</th><th>Security Key</th></tr></thead><tbody><tr><td>Application</td><td><a href="../../../../../.gitbook/assets/Azure DT Connector Example.xapp">Azure DT Connector Example.xapp</a></td><td>C0mp|ex123</td></tr></tbody></table>

{% hint style="info" %}
See the [Import, Export, and Clone - XMPro](https://documentation.xmpro.com/how-tos/import-export-and-clone#importing) article for steps to import a Data Stream.
{% endhint %}
