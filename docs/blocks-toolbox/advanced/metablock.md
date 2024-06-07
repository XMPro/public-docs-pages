# Metablock

Metablock gives designers the flexibility to leverage libraries to add their custom, dynamic blocks in XMPro using script files.

We recommend leveraging generative AI to write the scripts. This approach can significantly streamline the development process and enhance the functionality of the blocks.

![](<../../.gitbook/assets/image (1801).png>)

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
<script src="../../content/scripts/d3.js"></script>

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

The _onDataLoaded(data)_ function is where you would write code to respond to the data that is being sent into the script or Metablock control. For example, when the data gets loaded, you would want to display the points.

The _onDataChanged(data, changes)_ function is where you would write code to respond to any changes made to the data so the visualization will adapt in real-time and show live data.

Below is an example of a working script that shows data along an X-axis and Y-axis.&#x20;

{% file src="../../.gitbook/assets/D3 Chart v2.zip" %}

### Data Source

#### Common Properties

Data from this Data Source will be displayed using the script attached.&#x20;

Properties that are common to most Blocks include: _filter, sort, show # of results,_ and _skip # of results_;

[See the Common Properties article for more details on common Data Source properties.](../common-properties.md#data-source)

The Data Source property is optional for the Metablock Block.
