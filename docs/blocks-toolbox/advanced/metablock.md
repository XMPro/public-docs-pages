# Metablock

Metablock allows pro-code designers to leverage libraries to add their custom, dynamic blocks in XMPro using script files.

We recommend leveraging generative AI to write the scripts. This approach can significantly streamline the development process and enhance the functionality of the blocks.

## Metablock Properties

### Behavior

#### HTML Script File

Upload the HTML script file that will be rendered in the Metablock control, which is used to create custom blocks that may display data from a Data Source or from Value Mapping. If you use data source, it will be updated in real-time while if you use value mapping you can only use the configured data on run time.

The HTML Script File property is _**required**_ for the Metablock Block.

#### Styling File (CSS)

Upload the Styling file that will be rendered in the Metablock control, The styling file isolates your styling within the Metablock, promoting better modularity.

The Styling File property is optional for the Metablock block, you can choose to include both your HTML and CSS code in a single HTML file.

There is no strict format requirement for the CSS file simply add your CSS contents as you would when developing an HTML and CSS application.

#### Script File (JavaScript)

Upload the Script file that will be rendered in the Metablock control, The Script file isolates your JavaScript within the Metablock promoting better modularity.

The Script File property is optional for the Metablock block, you can choose to include both your HTML and JavaScript code in a single HTML file.

There is no strict format requirement for the JavaScript file. Simply add your JavaScript content as you would when developing an HTML and JavaScript application.

{% hint style="info" %}
To upload a script (HTML / CSS / JavaScript), it first needs to be uploaded using the App Files Manager. [See the Manage App Files article](../../how-tos/apps/manage-app-files.md) for more details.
{% endhint %}

### Data Source

#### Common Properties

Data from this Data Source will be displayed using the script attached.&#x20;

Properties that are common to most Blocks include: _filter, sort, show # of results,_ and _skip # of results_;

[See the Common Properties article for more details on common Data Source properties.](../common-properties.md#data-source)

The Data Source property is optional for the Metablock Block.

There is a predefined JavaScript function that must be available in the script file if the user intends to use the Data Source property.

**JavaScript within an HTML Script template:**

```html
<div id="myCanvas"></div>

<!--Supply the library paths here-->
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

**JavaScript in external file:**

```javascript
function onDataLoaded(data){
  //Apply data to metablock svg canvas
}

function onDataChanged(data, changes){
  //Respond to live updates on the dataset by updating metablock svg canvas
}
```

The **`onDataLoaded(data)`** is optional - add this function if you have configured a data source. This is where you would write code to respond to the data sent into the script or Metablock control. For example, when the data gets loaded, you want to display the points.

<details>

<summary><code>onDataLoaded(data)</code> sample data format</summary>

```json
[
    {
        "ReadingNo": 911,
        "Timestamp": "2024-08-16T07:24:00.1791525Z",
        "value": 3.6695501388374483,
        "entityid": "static",
        "_$parentProperties": {},
        "_$parentExpressions": [],
        "_$state": {
            "_$typeName": "EntityState",
            "name": "Unchanged"
        }
    }
]
```

The data above originates from a data stream that we’ve set up. It’s generated once upon page load. Keep in mind that the data format might differ based on the configured data source. However, for this example, we’ve utilized a simple data source, which you can download from [**here**](metablock.md#data-source-exported-file) and upload into the DS.

</details>

The **`onDataChanged(data, changes)`** is optional - add this function if you have configured a data source. This is where you would write code to respond to any changes made to the data so the visualization will adapt in real time and show live data.

<details>

<summary><code>onDataChanged(data, changes)</code> sample data format</summary>

```json
//data from `data` variable
[
    {
        "ReadingNo": 1156,
        "Timestamp": "2024-08-16T08:04:52.3154712Z",
        "value": 1.5450710600917559,
        "entityid": "static",
        "_$parentProperties": {},
        "_$parentExpressions": [],
        "_$state": {
            "_$typeName": "EntityState",
            "name": "Unchanged"
        }
    }
]
```

```json
//data from `changes` variable
[
    {
        "ReadingNo": 1156,
        "Timestamp": "2024-08-16T08:04:52.3154712Z",
        "value": 1.5450710600917559,
        "entityid": "static",
        "_$parentProperties": {},
        "_$parentExpressions": [],
        "_$state": {
            "_$typeName": "EntityState",
            "name": "Unchanged"
        }
    }
]
```

The data above originates from a data stream that we’ve set up. It’s generated once upon page load. Keep in mind that the data format might differ based on the configured data source.&#x20;

In this example, both the `data` and `changes` variables contain identical data, indicating that there are no updates. However, in a real-world scenario, the `changes` variable would capture any modifications to the initial data.

For testing purposes, we’ve utilized a simple data source. You can download it from [**here**](metablock.md#data-source-exported-file) and upload it into the designated data stream.

</details>

#### Data Source Exported File ()

The security key is `C0mp|ex123`

{% file src="../../.gitbook/assets/Metablock Example.xuc" %}

_We have an example of a working script that demonstrates an Autodesk Forge visualization_ [_here_](metablock.md#script-file-example)_._&#x20;

### Value

#### Value Mapping&#x20;

User-configurable key-value pairs for runtime use. Note that these values remain static during application rendering.&#x20;

The Value Mapping property is optional for the Metablock Block.

There is a predefined JavaScript function that must be available in the script file if the user intends to use the Value Mapping property.

**JavaScript within an HTML Script template:**

```html
<div id="myCanvas"></div>

<!--Supply the library paths here-->
<script src="https://sample.url.com/library_name.js"></script> 

<script>

    function onValueMappingLoaded(data){
      //Apply value mapping data to metablock svg canvas
    }

</script>
```

**JavaScript in external file:**

```javascript
function onValueMappingLoaded(data){
    //Apply value mapping data to metablock svg canvas
}
```

The **`onValueMappingLoaded(data)`** is optional - add this function if you have Value Mapping data configured. This is where you would write code to respond to the data sent into the script or Metablock control. For instance, when the page loads, this function allows you to display the data dynamically on the canvas or incorporate it into the logic of your Metablock application.

<details>

<summary><code>OnValueMappingLoaded(data)</code> sample data format</summary>

```json
  [
      {
          "key" : "Value"
      },
      {
          "isWorking" : true
      },
      {
          "counter" : 10
      }
  ]
```



</details>

**Real World Use Cases**

<figure><img src="../../.gitbook/assets/Metablock - Enhance Chart Display.png" alt=""><figcaption><p>Fig 1: Enhancing chart display</p></figcaption></figure>

<details>

<summary>Enhancing Chart Display with Value Mapping in Metablock</summary>

The need to incorporate user input for displaying Harmonic Frequency. Initially, we addressed this by modifying the data source—adding the Harmonic Frequency parameter both as an input and as part of the response. However, a more elegant solution has emerged: value mapping. By leveraging this approach, we achieve our goal without tinkering with the connector itself. Imagine a streamlined process where harmonics dance effortlessly across our charts, all while maintaining connector integrity. In this exploration, we’ll delve into the magic of value mapping and unlock new dimensions of data visualization.&#x20;

</details>

<figure><img src="../../.gitbook/assets/Metablock - Pump status display.png" alt=""><figcaption><p>Fig 2: Pump status display</p></figcaption></figure>

<details>

<summary>Streamlining Pump Status Display with Dynamic URLs in Metablock</summary>

In our ongoing efforts to enhance the functionality of Metablock, we’ve encountered a specific challenge related to displaying pump statuses. Currently, our setup involves connecting Metablock to a data stream that fetches real-time data for these pumps. When users interact with a specific pump, they are directed to a drill-down page where detailed pump information is presented.

However, there’s room for improvement. At present, we hardcode the URL directly within the JavaScript code. This approach has its drawbacks: whenever a new version is created, manual intervention is required to download the JavaScript, update the URL, and then re-upload it. This process is not only time-consuming but also prone to errors.

Value mapping—a more elegant solution. By leveraging value mapping, we can dynamically pass URLs from other data sources or utilize expressions. This eliminates the need for manual URL adjustments during each version update. Instead, we achieve seamless navigation through the pump data, ensuring a smoother user experience.

</details>

## Script File Example

This example demonstrates how you could leverage generative AI to write the HTML script file for a basic 3D viewer using Autodesk Forge.

### Step 1: Search for a code snippet

We searched for sample Autodesk Forge code and found the following links:&#x20;

* Demo: [Very Basic 3D Viewer (autodesk-forge.github.io)](https://autodesk-forge.github.io/viewer-javascript-offline.sample/)
* Github: [viewer-javascript-offline.sample/index.html at gh-pages · Autodesk-Forge/viewer-javascript-offline.sample · GitHub](https://github.com/Autodesk-Forge/viewer-javascript-offline.sample/blob/gh-pages/index.html)

### Step 2: Writing your Metablock script

In this step, we’ll create the Metablock script using relevant portions from the provided sample code. We’ll concentrate on following the suggested script format of creating Metablocks.

<details>

<summary>Sample Custom Script</summary>

```html
<style>
	h1 {
	  font-family: 'Montserrat', sans-serif;
	  font-size: 3.5rem;
	  font-weight: 700;
	  color: #333;
	  text-align: center;
	  text-transform: uppercase;
	  letter-spacing: 2px;
	  margin-top: 2rem;
	  margin-bottom: 1.5rem;
	  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
	  animation: fadeIn 1s ease-in-out;
	}

	@keyframes fadeIn {
	  0% {
		opacity: 0;
		transform: translateY(-20px);
	  }
	  100% {
		opacity: 1;
		transform: translateY(0);
	  }
	}
</style>

<h1>3D Model Viewer</h1>

<div id="myCanvas"></div>

<!-- Load the Autodesk Forge Viewer API -->
<script src="https://developer.api.autodesk.com/modelderivative/v2/viewers/7.*/viewer3D.min.js"></script>

<script>
  // Configure and initialize the Autodesk Forge Viewer
  var myViewerDiv = document.getElementById('myCanvas');
  var viewer = new Autodesk.Viewing.Private.GuiViewer3D(myViewerDiv);

  var options = {
    'env': 'Local',
    'document': 'https://developer-autodesk.github.io/translated-models/dwfx-sample-house/f0224dd3-8767-45c1-ff99-5c9c881b9fee/0.svf'
  };

  Autodesk.Viewing.Initializer(options, function onInitialized() {
    viewer.start(options.document, options);
  });

  function onDataLoaded(data) {
    // Apply data to metablock svg canvas
  }

  function onDataChanged(data, changes) {
    // Respond to live updates on the dataset by updating metablock svg canvas
  }

  function onValueMappingLoaded(data) {
    // Apply value mapping data to metablock svg canvas
  }
</script>

```

</details>

### **Step 3: Testing your code**

Since our code does not require a connection to a data source, perform an initial test locally to verify that it renders as anticipated. You can test it by opening the HTML file with your preferred browser.

### Step 4: Configure the Metablock

Next, add the Metablock Block to an App Page and upload the file to the ‘HTML Script File’ property. Launch your Application and observe the Autodesk Forge example renders on the page.

{% file src="../../.gitbook/assets/Metablock autodeskforge example.zip" %}
File 3: Decompress this file for a sample HTML script file
{% endfile %}

## Security Features

We have added security features in Metablock to safeguard the users from potential attacks, When developing applications, we have selectively enabled the following features:

* Form Submission
* Pop-up windows
* Modal Dialogs
* JavaScript Features
* External Resources

In addition, Metablocks permits the use of hardware APIs for enhanced application capabilities. Below is the list of allowed hardware APIs:

<table><thead><tr><th width="206">Hardware APIs</th><th>Description</th></tr></thead><tbody><tr><td><strong>camera</strong></td><td>for capturing images or videos</td></tr><tr><td><strong>encrypted-media</strong></td><td>securely handle encrypted media content</td></tr><tr><td><strong>full-screen</strong></td><td>full-screen mode for immersive experience</td></tr><tr><td><strong>geo-location</strong></td><td>obtain location information (w/ user consent)</td></tr><tr><td><strong>speaker</strong></td><td>control audio output</td></tr><tr><td><strong>accelerometer</strong></td><td>access device motion data</td></tr><tr><td><strong>gyroscope</strong></td><td>retrieve orientation data</td></tr><tr><td><strong>magnetometer</strong></td><td>detect magnetic field strength</td></tr><tr><td><strong>midi</strong></td><td>interact with MIDI devices</td></tr></tbody></table>

Due to the security restrictions we’ve implemented, certain functionalities within your application may not be working as expected. We kindly request information on any actions you’ve taken or observed to help us address this issue.

## FAQs

### Why did the JavaScript code in my Metablock not execute on page load?

The JavaScript didn't load as anticipated due to the timing of function instantiation within the JavaScript file. In Metablock, we inject JavaScript and CSS at runtime. Consequently, the load event might have already fired by the time the script is injected.

We recommend not relying solely on the load event. Instead, check the document’s ready state, to call the initialization function when appropriate - ensuring that your logic runs whether the load event has already fired or not.

```javascript
// [X] Instead of using load event 
window.addEventListener('load', function());

// [/] check the document’s ready state.
if (document.readyState === 'complete') {
    //function()
}
```

### Why is the Metablock throwing 500 errors related to styling and script files?

_"The application successfully loads, but the Metablock is not operational. I checked the console and noted 500 errors related to the JavaScript and CSS imported files._\
`net::ERR_ABORTED 500 (Internal Server Error)`"\
\
This can occur if the files include unnecessary inline script import code. The Metablock handles CSS and JavaScript injection at runtime, so explicit import code isn’t needed and will result in the 500 error.

Below is an example HTML snippet that contains invalid import script that causes the 500 error.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!--start: invalid import script that causes 500 error-->
    <link rel="stylesheet" href="styles.css">
    <!--end: invalid import script that causes 500 error-->
</head>
    <body>

        <!--start: invalid import script that causes 500 error-->
        <script src="app.js"></script>
        <!--end: invalid import script that causes 500 error-->
    </body>
</html>
```
