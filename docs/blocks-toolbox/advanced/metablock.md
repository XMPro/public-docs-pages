# Metablock

Metablock allows pro-code designers to leverage libraries to add their dynamic blocks in XMPro using script files.

We recommend leveraging generative AI to write the scripts. This approach can significantly streamline the development process and enhance the functionality of the blocks.

{% hint style="info" %}
Only the [Presentation File (HTML)](metablock.md#presentation-file-html) is required. Utilize the other properties based on your specific needs for the Metablock behavior.
{% endhint %}

## Metablock Properties

### Behavior

#### Presentation File (HTML)

Upload the HTML script file that will be rendered in your Metablock, which is used to create dynamic blocks that may display data from a [Data Source](metablock.md#data-source) or from [Value Mapping](metablock.md#value-mapping-optional).&#x20;

```html
<div class="foo">bar</div>
```

Alternatively, you can write your scripts in a single HTML file that includes both CSS and JavaScript. This approach is ideal for smaller applications.

```html
<!-- Style with CSS the div element with class foo the color blue -->
<style>
    .foo { color: blue }
</style>

<!-- Html to show the text "foo" -->
<div class="foo">foo</div>

<!-- JavaScript to change the text "foo" to "bar" when the page has loaded -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const fooDiv = document.querySelector('.foo');
        fooDiv.innerHTML = 'bar';
    });
</script>
```

#### Styling File (CSS)

If you wish to add styling, upload a CSS file to style your Metablock control.

```css
.foo {
    color : green;
}
```

#### Script File (JavaScript)

If you wish to run JavaScript, upload a JavaScript file for your Metablock. Place any initial/startup values as constants in this file.

```javascript
const foo = 'foo';
```

### Data Source

#### Common Properties

Common properties include: _filter, sort, show # of results,_ and _skip # of results_;

[See the Common Properties article for more details on common Data Source properties.](../common-properties.md#data-source)

To use the Data Source property, include these predefined JavaScript functions in your [Script File](metablock.md#script-file-javascript-optional):

<pre class="language-javascript"><code class="lang-javascript"><strong>// Access data source when the metablcok is loaded (optional) 
</strong><strong>function onDataLoaded(data){
</strong>  //Access a value from the data source
  const foo = data.find(obj => 'foo' in obj).foo;
}

// Access live updates on the data source after the metablock has been loaded (optional)
function onDataChanged(data, changes){
  
}
</code></pre>

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

The data above originates from a data stream that we’ve set up and it runs once upon page load. Keep in mind that the data format might differ based on your data source configuration.

</details>

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

In this example, both the `data` and `changes` variables contain identical data, indicating that there are no updates. However, in a real-world scenario, the `changes` variable would capture any modifications to the initial data.

</details>

_You can refer to a working example script that demonstrates an Autodesk Forge visualization_ [_here_](metablock.md#example-files)_._&#x20;

### Value

#### Value Mapping (optional)

If you wish to define value mappings for run-time use, you can configure user-defined key-value pairs. These values remain static during application rendering.

{% hint style="warning" %}
Do not map sensitive values like keys, secrets or passwords. If you are attempting to connect to a 3rd party system that requires authentication in your Metablock, use a Connector as a data source and map the output of the data source into your Metablock.
{% endhint %}

To use Value Mapping, include this predefined JavaScript function in your [Script File](metablock.md#script-file-javascript-optional):

```javascript
// Access Value mapping data when the metablock is loaded (optional)
function onValueMappingLoaded(data){
    //Apply a value from the value mapping
    const foo = data.find(obj => 'foo' in obj).foo;
}
```

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

## **Real World Use Cases**

### Enhancing Chart Display

Use Value Mapping to incorporate user input for displaying Harmonic Frequency, maintaining connector integrity while improving data visualization.

<figure><img src="../../.gitbook/assets/Metablock - Enhance Chart Display.png" alt=""><figcaption><p>Fig 1: Enhancing chart display</p></figcaption></figure>

The security key is `C0mp|ex123`

{% file src="../../.gitbook/assets/Metablock Chart Example.xapp" %}
File 1: Metablock Chart Example
{% endfile %}

### Streamlining Pump Status Display

Leverage Value Mapping to dynamically pass URLs from other data sources or utilize expressions, eliminating the need for manual URL adjustments during version updates.

<figure><img src="../../.gitbook/assets/Metablock - Pump status display.png" alt=""><figcaption><p>Fig 2: Pump status display</p></figcaption></figure>

The security key is `C0mp|ex123`

{% file src="../../.gitbook/assets/Metablock Pump Example.xapp" %}
File 2: Metablock Pump Example
{% endfile %}

## Creating a Metablock Script: Step-by-Step Guide

### Step 1: Search for a code snippet

Find relevant sample, we search for sample Autodesk Forge code and found the following links:

* Demo: [Very Basic 3D Viewer (autodesk-forge.github.io)](https://autodesk-forge.github.io/viewer-javascript-offline.sample/)
* Github: [viewer-javascript-offline.sample/index.html at gh-pages · Autodesk-Forge/viewer-javascript-offline.sample · GitHub](https://github.com/Autodesk-Forge/viewer-javascript-offline.sample/blob/gh-pages/index.html)

### Step 2: Writing your Metablock script

Adapt the sample code to the Metablock format. For simplicity, the HTML, CSS & JavaScript has been combined into a single file.

```html
<!-- main.html -->
<h1>Autodesk Forge Viewer</h1>
<div id="main"></div>
```

```css
/* main.css */
h1 {
    font-family: Arial, sans-serif; 
    color : #333;
}
```

```javascript
// main.js

var hasInitialized = false;

function onValueMappingLoaded(data) {
    
    // Prevent multiple initializations
    if (hasInitialized) 
        return;
    
    hasInitialized = true;
    
    // Load the CSS forge dependencies
    const cssViewerUrl = 'https://developer.api.autodesk.com/modelderivative/v2/viewers/style.min.css?v=v7.*';
    loadCSSViewer(cssViewerUrl);
    
    // Load the forge viewer
    var viwerUrl = 'https://developer.api.autodesk.com/modelderivative/v2/viewers/7.*/viewer3D.min.js';
    var viewer = loadViewer(viwerUrl);
    
    // Get the model URL from the data
    const modelUrl = data.find(obj => 'model_url' in obj).model_url

    // Load the model into the viewer
    loadModel(viewer, modelUrl);
}

function loadViewer(viewer_url) {
    return new Promise((resolve, reject) => {
        const script = document.createElement('script');
        script.src = viewer_url;
        script.onload = resolve;
        script.onerror = reject;
        document.head.appendChild(script);
    });
}

function loadCSSViewer(css_viewer_url){
    return new Promise((resolve, reject) => {
        const link = document.createElement('link');
        link.rel = "stylesheet";
        link.type = "text/css";
        link.href = css_viewer_url;
        link.onload = resolve;
        link.onerror = reject;
        document.head.appendChild(link);
    });
}

// Loads the model into the viewer
function loadModel(viewer, modelUrl) {
    viewer.then(() => {
        var myViewerDiv = document.getElementById('main');
        var viewer = new Autodesk.Viewing.Private.GuiViewer3D(myViewerDiv);
        var options = {
            'env': 'Local',
            'document': modelUrl
        };
        Autodesk.Viewing.Initializer(options, function onInitialized() {
            viewer.start(options.document, options);
        });
    }).catch((error) => {
        console.error('Failed to load Forge viewer:', error);
    });
}
```

### **Step 3: Testing your code locally (Optional)**

Test it locally before implementation by running it from another html file (test-harness.html) via a local webserver. A 3D interactive model of a house should load in your browser.

1. Create the `test-harness.html` file in the same directory as your Metablock files.

```html
!-- test-harness.html -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Harness for XMPro Metablocks</title>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="/favicon.ico">
    <!-- Link to the Metablock CSS file -->
    <link rel="stylesheet" href="main.css">
</head>
<body>
    <!-- Container for the Metablock HTML content -->
    <div id="main">
        <p id="loading">Loading content...</p>
    </div>
        
    <!-- Include the Metablock JavaScript file -->
    <script src="main.js"></script>

    <script>
        // Fetch the content of main.html and inject it into the #main div
        fetch('main.html')
            .then(response => response.text())
            .then(html => {
                // Insert the fetched HTML into the #main div
                document.getElementById('main').innerHTML = html;

                // Initialize static data for the Metablock
                // This object allows passing specific initialization data to the JavaScript
                // through the onValueMappingLoaded function
                var data = [{

                    // model_url: The url of the model to be displayed in the Metablock
                    // This would be passed in from the XMPro Metablock configuration Value Mapping.

                    model_url: "https://developer-autodesk.github.io/translated-models/dwfx-sample-house/f0224dd3-8767-45c1-ff99-5c9c881b9fee/0.svf"

                    // Add any other required initialization parameters here, for example:
                    // api_endpoint: "https://api.example.com/v1",
                    // debug_mode: true,
                    // theme: "dark"
                    
                }]

                // Call the onValueMappingLoaded function with the initialization data
                // This function should be defined in main.js and will use the provided data
                // to set up the Metablock's initial state
                onValueMappingLoaded(data);
            })
            .catch(error => {
                // Log any errors that occur during the fetch operation
                console.error('Error loading main.html:', error);
            });
    </script>
</body>
</html>
```

2. Run the `test-harness.html` in a webserver (node.js)
   1. Make sure you have Node.js installed on your computer. You can download it from [https://nodejs.org/](https://nodejs.org/).
   2. Open a terminal or command prompt and navigate to your project folder where the metablock files are.
   3. Initialize a new Node.js project by running `npm init -y`
   4. Install Express by running `npm install express`
   5. Create `public` folder and moved your `HTML`, `CSS` & `JavaScript` files inside
   6. Create a file named `server.js`
   7.  copy and past below code in `server.js` file

       ```javascript
       // server.js

       const express = require('express');
       const path = require('path');
       const app = express();
       const port = process.env.PORT || 3000;

       // Serve static files from the 'public' directory
       app.use(express.static(path.join(__dirname , 'public')));

       app.get('/', (req, res) => {
           res.sendFile(path.join(__dirname, 'public', 'test-harness.html'));
       });

       app.use((req,res) => {
           res.status(404);
           res.send(`<h1>Error 404: Resource not found</h1>`);
       });

       // Start the server
       app.listen(port, () => {
           console.log(`Server is running on http://localhost:${port}`);
       });
       ```
   8. To start the server, run `node server.js`
   9. Open a web browser and go to [http://localhost:3000](http://localhost:3000/)

### Step 4: Configure the Metablock in App Designer

1. Drag the Metablock onto your page.
2. Open Block Properties.
3. Add the 3 Metablock files by clicking on the plus icon and uploading the `main.html`, `main.css`, `main.js` files and selecting each from their respective dropdown.
4. Add a Value Mapping of key `model_url` and Value `https://developer-autodesk.github.io/translated-models/dwfx-sample-house/f0224dd3-8767-45c1-ff99-5c9c881b9fee/0.svf`
5. Save the page
6. Launch the page

### Example Files

The example script files and exported app for this demo can be found in the below attachment.  The security key for the App Designer Application export is `C0mp|ex123`

{% file src="../../.gitbook/assets/Metablock Autodesk Example (1).zip" %}

## Security Features

We have added security features in Metablock to safeguard the users from potential attacks, When developing applications, we have selectively enabled the following features:

* Form Submission
* Pop-up windows
* Modal Dialogs
* JavaScript Features
* External Resources

Additionally, Metablock allows the use of specific hardware APIs for enhanced application capabilities, including camera, encrypted-media, full-screen, geo-location, speaker, accelerometer, gyroscope, magnetometer, and midi.

## FAQs

### Why did the JavaScript code in my Metablock not execute on page load?

Due to the timing of function instantiation, we recommend checking the document's ready state instead of relying on the load event:

Check document's ready state:

```javascript
if (document.readyState === 'complete') {
    // add your logic here
}
```

Alternatively use one of the existing functions.

```javascript
function onValueMappingLoaded(data) {
    // add your logic here
}
```

### Why is the Metablock throwing 500 errors related to styling and script files?

This can occur if your HTML file includes inline script import code. Remove explicit import statements for CSS and JavaScript, and use the dedicated script file configuration property.

```html
<!-- unsupported import script -->
<link rel="stylesheet" href="styles.css">

<!-- unsupported import script -->
<script src="app.js"></script>

<!-- valid html -->
<span>foo</span>   
```

### How can I load multiple script files?

At present we only support configuration of a single HTML, CSS, and JavaScript file for each Metablock. To simulate multiple JavaScript files, you can dynamically load script from your JavaScript file.&#x20;

See the [Creating a Metablock Script: Step-by-Step Guide](metablock.md#creating-a-metablock-script-step-by-step-guide) for an example on how this is done.&#x20;
