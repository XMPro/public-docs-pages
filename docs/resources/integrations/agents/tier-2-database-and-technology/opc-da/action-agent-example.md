---
description: >-
  This example Data Stream demonstrates how to use this Action Agent to update
  the pump's temperature (Int4), money forecast (money), and pressure (Real8)
  Item Values on the OPC DA Server.
---

# Action Agent Example

{% hint style="info" %}
Refer to [configuration](action-agent-configuration.md) to understand all configuration options of this Agent.
{% endhint %}

### Step 1: Add the Agent

1. Drag the OPC DA Action Agent onto the canvas.
2. Rename the Agent, link the input endpoint to the sensor data and link the output endpoint to the printer.
3. Save the Data Stream.
4. Double-click to configure the Agent.

<figure><img src="../../../../../.gitbook/assets/OPC DA AA Step 1.png" alt=""><figcaption><p>Step 1: Add the Agent</p></figcaption></figure>

### Step 2: Configure Settings

Enter the Connection details of your OPC DA Server: server, and security.

In this case, select the server "Matrikon.OPC.Simulation", and leave Use Authenticaion unticked. Do tick to specify the timestamp, quality, and Enable Tag Browsing.

<figure><img src="../../../../../.gitbook/assets/OPC DA AA Step 2.png" alt=""><figcaption><p>Step 2: Configure Settings</p></figcaption></figure>

### Step 3: Configure Browse Tags/Items

Select the Branch Type and Path/Level. In this case, select Using Drilldown, and add Simulation Items and Bucket Brigade levels.

<figure><img src="../../../../../.gitbook/assets/OPC DA AA Step 3.png" alt=""><figcaption><p>Step 3: Configure Browse Tags/Items</p></figcaption></figure>

### Step 4: Configure Items

Select from the Available Tags and click Add Selected Tags to populate the Items Grid. \
In this case, select Money, Int4, and Real8.

<figure><img src="../../../../../.gitbook/assets/OPC DA AA Step 4.png" alt=""><figcaption><p>Step 4: Configure Items</p></figcaption></figure>

### Step 5: Configure Data Mapping

Select the column or attribute from the input payload for the corresponding values, quality, and timestamp in the Mapping Grid.

In this case, select the Pump Heat, Money, and Pressure as the item values. Select the Quality as the item quality and Timestamp as the item timestamp.

<figure><img src="../../../../../.gitbook/assets/OPC DA AA Step 5.png" alt=""><figcaption><p>Step 5: Configure Data Mapping</p></figcaption></figure>

### Step 6: Results

Apply the changes, save the Data Stream, and publish it.

Let's look at the Live Data View. Observe the incoming data is printed and the asset's Int8 and Qualities values are updated on the OPC DA Server.

<figure><img src="../../../../../.gitbook/assets/OPC DA AA Step 6.png" alt=""><figcaption><p>Step 6: Results</p></figcaption></figure>

And you can use the OPC DA Listener to observe the Pump's updated Temp, Money and Pressure tags.&#x20;

<figure><img src="../../../../../.gitbook/assets/OPC DA AA Step 6a.png" alt=""><figcaption><p>Step 6: The updated tag values </p></figcaption></figure>

### Files

<table><thead><tr><th width="187.87658056443786">File</th><th width="377.87287411060635" data-type="files">Link</th><th>Security Key</th></tr></thead><tbody><tr><td>Data Stream</td><td><a href="../../../../../.gitbook/assets/OPC DA Action Agent Example.xuc">OPC DA Action Agent Example.xuc</a></td><td>C0mp|ex123</td></tr></tbody></table>

{% hint style="info" %}
See the [Import, Export, and Clone - XMPro](https://documentation.xmpro.com/how-tos/import-export-and-clone#importing) article for steps to import a Data Stream.
{% endhint %}
