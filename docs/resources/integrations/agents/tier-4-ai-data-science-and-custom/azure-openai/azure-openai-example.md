---
description: >-
  This example demonstrates how to use this AI & ML Agent to ask an Azure OpenAI
  model instance the answer to a math problem: to decuple the incoming sensor
  value.
---

# Azure OpenAI Example

{% hint style="info" %}
Refer to [configuration](azure-openai-configuration.md) to understand all configuration options of this Agent.
{% endhint %}

### Step 1: Add the Agent

1. Drag the Azure OpenAI Action Agent onto the canvas.
2. Rename the Agent, link the input endpoint to the sensor data and the output endpoint to the printer
3. Save the Data Stream.
4. Double-click to configure the Agent.

![Step 1: Add the Agent](<../../../../../.gitbook/assets/Azure OpenAI Example - Step 1.png>)

### Step 2: Configure Connection

Enter the Endpoint, Key Credential, and Deployment Name. In this case, keep use variables ticked and select the variables that represent the connection values.

![Step 2: Configure Connection](<../../../../../.gitbook/assets/Azure OpenAI Example - Step 2.png>)

### Step 3: Configure Messages

Click the plus button to add one or more messages, making sure to click Apply to add the message to the list. Each message is made up of a description, order, type, and message text.

In this example, add the following three messages:

1. A system message with the description "Assign Calculator Role" and the message text "You are an XMPro Calculation agent, designed to enrich event data in a Data Stream." \
   _This message informs the AI model of what role to assume._
2. A system message with the description "Format Response" and the message text "Your response must be limited to the result of the calculation only." \
   _This message informs the AI model how to format the response._
3. A user message with the description "User Multiply x 10" and the message text "What is \{{Value\}} multiplied by 10?" \
   _This message asks the model a question using a value from the input payload._

![Step 3: Configure Messages](<../../../../../.gitbook/assets/Azure OpenAI Example - Step 3.png>)

### Step 4: Results

Apply the changes, save the Data Stream, and publish it.&#x20;

Let's look at the Live Data View. Observe that the response string from the OpenAI model is appended to the input payload and printed.

<figure><img src="../../../../../.gitbook/assets/Azure OpenAI Example - Step 4.png" alt=""><figcaption><p>Step 4: Results</p></figcaption></figure>

Observe the impact of not instructing the model on how to format the response.

![Step 4: Unformatted Response](<../../../../../.gitbook/assets/Azure OpenAI Example - Step 4 Alt.png>)

### Files

<table><thead><tr><th width="150">File</th><th width="297" data-type="files">Link</th><th>Security Key</th></tr></thead><tbody><tr><td>Data Stream</td><td><a href="../../../../../.gitbook/assets/Azure OpenAI Example.xuc">Azure OpenAI Example.xuc</a></td><td>C0mp|ex123</td></tr></tbody></table>

{% hint style="info" %}
See the [Import, Export, and Clone - XMPro](https://documentation.xmpro.com/how-tos/import-export-and-clone#importing) article for steps to import a Data Stream.
{% endhint %}
