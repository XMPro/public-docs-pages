# Metablock

Metablock allows pro-code designers to leverage libraries to add their custom, dynamic blocks in XMPro using script files.

We recommend leveraging generative AI to write the scripts. This approach can significantly streamline the development process and enhance the functionality of the blocks.

## Metablock Properties

### Behavior

#### HTML Script File

Upload the HTML script file that will be rendered in the Metablock control, which is used to create custom blocks that may display data from a Data Source. If you use data, it will be updated in real-time. [For more information on how to create scripts such as D3, visit this website](https://observablehq.com/@d3/learn-d3).

The template is the base of the script that is used to create the visualizations. Any sample code taken from examples can be copied into a script template.&#x20;

The HTML Script File property is required for the Metablock Block.

{% hint style="info" %}
To upload a script, it first needs to be uploaded using the App Files Manager. [See the Manage App Files article](../../how-tos/apps/manage-app-files.md) for more details.
{% endhint %}

Script template:

```html
<div id="myCanvas"></div>
//Supply the library paths here
<script src="https://sample.url.com/library_name.js"></script> 

<script>

/* Add script here to transform #myCanvas */
function onDataLoaded(data){
  //Apply data to metablock svg canvas
}

function onDataChanged(data, changes){
  //Respond to live updates on the dataset by updating metablock svg canvas
}

</script>
```

The _onDataLoaded(data)_ is optional - add this function if you have configured a data source. This is where you would write code to respond to the data sent into the script or Metablock control. For example, when the data gets loaded, you want to display the points.

The _onDataChanged(data, changes)_ is optional - add this function if you have configured a data source. This is where you would write code to respond to any changes made to the data so the visualization will adapt in real time and show live data.

[Below](metablock.md#script-file-example) is an example of a working script that shows an Autodesk Forge visualization.&#x20;

### Data Source

#### Common Properties

Data from this Data Source will be displayed using the script attached.&#x20;

Properties that are common to most Blocks include: _filter, sort, show # of results,_ and _skip # of results_;

[See the Common Properties article for more details on common Data Source properties.](../common-properties.md#data-source)

The Data Source property is optional for the Metablock Block.

## Script File Example

This example demonstrates how you could leverage generative AI to write the HTML script file for a basic 3D viewer using Autodesk Forge.

### Step 1: Search for a code snippet

We searched for sample Autodesk Forge code and found the following links:&#x20;

* Demo: [Very Basic 3D Viewer (autodesk-forge.github.io)](https://autodesk-forge.github.io/viewer-javascript-offline.sample/)
* Github: [viewer-javascript-offline.sample/index.html at gh-pages · Autodesk-Forge/viewer-javascript-offline.sample · GitHub](https://github.com/Autodesk-Forge/viewer-javascript-offline.sample/blob/gh-pages/index.html)

### Step 2: Generate your script with the help of Copilot

We only need parts of the sample code for the Metablock's HTML script file. Prompt Copilot to compare the attached sample script file and the code snippets to generate an HTML Script file. &#x20;

### **Step 3: Testing your code**

Since our code does not require a connection to a data source, perform an initial test locally to verify that it renders as anticipated.

### Step 4: Configure the Metablock

Next, add the Metablock Block to an App Page and upload the file to the ‘HTML Script File’ property. Launch your Application and observe the Autodesk Forge example renders on the page.

{% file src="../../.gitbook/assets/Metablock autodeskforge example.zip" %}
File 1: Decompress this file for a sample HTML script file
{% endfile %}
