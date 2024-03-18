---
description: >-
  This example Data Stream demonstrates how to use this Listener to retrieve a
  pump's heat (I), money forecast (M), and pressure (R) tag values from the OPC
  DA Server.
---

# Listener Example

{% hint style="info" %}
Refer to [configuration](listener-configuration.md) to understand all configuration options of this Agent.
{% endhint %}

### Step 1: Add the Agent

1. Drag the OPC DA Listener onto the canvas.
2. Rename the Agent and link the output endpoint to the printer
3. Save the Data Stream.
4. Double-click to configure the Agent.

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Step 1.png" alt=""><figcaption><p>Step 1: Add the Agent</p></figcaption></figure>

### Step 2: Configure Settings

Enter the Connection details of your OPC DA Server.&#x20;

In this case, select the server "Matrikon.OPC.Simulation". Do tick to include the Timestamp, Check For Quality, and Enable Tag Browsing.

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Step 2.png" alt=""><figcaption><p>Step 2: Configure Settings</p></figcaption></figure>

### Step 3: Configure Browse Tags/Items

Select the Branch Type and Path/Level. In this case, select Using Drilldown, and add Simulation Items and Random levels.

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Step 3.png" alt=""><figcaption><p>Step 3: Configure Browse Tags/Items</p></figcaption></figure>

### Step 4: Configure Items

Select from the Available Tags and click Add Selected Tags to populate the Items Grid. \
In this case, select Money, Int4, and Real8.

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Step 4.png" alt=""><figcaption><p>Step 4: Configure Items</p></figcaption></figure>

### Step 5: Configure Data Mapping

Enter the Alias and Type for the tags in the Items Grid. \
In this case, enter their alias as I, M, and R. Leave their type as String.

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Step 5.png" alt=""><figcaption><p>Step 5: Configure Data Mapping</p></figcaption></figure>

### Step 6: Results

Apply the changes, save the Data Stream, and publish it.

Let's look at the Live Data View. Observe that the current values and timestamps of the pump's I, M, and R tags are printed.

<figure><img src="../../../../../.gitbook/assets/OPC DA Listener Step 6.png" alt=""><figcaption><p>Step 6: Results</p></figcaption></figure>

### Files

<table><thead><tr><th width="206.87658056443786">File</th><th width="326.87287411060635" data-type="files">Link</th><th>Security Key</th></tr></thead><tbody><tr><td>Data Stream</td><td></td><td>C0mp|ex123</td></tr></tbody></table>

{% hint style="info" %}
See the [Import, Export, and Clone - XMPro](https://documentation.xmpro.com/how-tos/import-export-and-clone#importing) article for steps to import a Data Stream.
{% endhint %}
