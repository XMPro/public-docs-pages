---
description: >-
  This section explains each of the properties in the Azure OpenAI configuration
  blade.
---

# Azure OpenAI Configuration

<figure><img src="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F27cqp1fhoqA23mCVDSQw%2Fuploads%2FE5mysFW5I381qsTQIF8Z%2FAzure%20OpenAI%20Example%20-%20Config%201.png?alt=media&#x26;token=004344d1-08ee-46af-a5cd-e8702f949c5d" alt=""><figcaption><p>Fig 1: Azure OpenAI Configuration</p></figcaption></figure>

### General Properties <a href="#general-properties" id="general-properties"></a>

**Collection**

This associates the Agent to a specific Collection (default to that of the current Data Stream).

{% hint style="info" %}
Refer to [Collections and Stream Hosts](https://documentation.xmpro.com/collection) to understand more about Collections.
{% endhint %}

### Connection Properties <a href="#connection-properties" id="connection-properties"></a>

**Use Variables**

Tick to select saved variables; or enter the values manually for the [Endpoint](https://app.gitbook.com/o/-MZASoMaVZCmWsNG58Xo/s/27cqp1fhoqA23mCVDSQw/how-to-use/configuration/\~/files#endpoint), [Key Credential](https://app.gitbook.com/o/-MZASoMaVZCmWsNG58Xo/s/27cqp1fhoqA23mCVDSQw/how-to-use/configuration/\~/files#key-credential), and [Deployment Name](https://app.gitbook.com/o/-MZASoMaVZCmWsNG58Xo/s/27cqp1fhoqA23mCVDSQw/how-to-use/configuration/\~/files#deployment-name).

**Endpoint**

The Endpoint Url of the Azure OpenAI instance.

**Key Credential**

A valid key for the Azure OpenAI instance.

**Deployment Name**

The Deployment Name of a deployed model. The [Endpoint](https://app.gitbook.com/o/-MZASoMaVZCmWsNG58Xo/s/27cqp1fhoqA23mCVDSQw/how-to-use/configuration/\~/files#endpoint) and [Key Credential](https://app.gitbook.com/o/-MZASoMaVZCmWsNG58Xo/s/27cqp1fhoqA23mCVDSQw/how-to-use/configuration/\~/files#key-credential) can be found in the Keys and Endpoint menu on the Azure Portal page.

### Message Properties <a href="#message-properties" id="message-properties"></a>

The Messages list contains the messages sent to the OpenAI model. The response is generated once every message has been sent, allowing you to split a command into separate messages.

**Description**

A unique, friendly name to describe the message that appears in the message list.

**Order**

Adjust this automatically generated value to rearrange the order in which the messages are sent.

**Type**

The options for the message originator are:

* Assistant: messages that establish a history of the AI's responses for it to draw from.
* System: messages that inform the AI of its role.
* User: messages that prompt a response.

Read [here](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/advanced-prompt-engineering?pivots=programming-language-chat-completions#system-message) for more on prompt engineering.

**Message**

The message to send. Insert columns from the input payload by enclosing them in double curly braces. For instance, to insert the value of the property ReadingNo, use the text "\{{ReadingNo\}}".

<figure><img src="../../../../../.gitbook/assets/Azure OpenAI Example - Config 2.png" alt=""><figcaption><p>Fig 2: Azure OpenAI Message Configuration</p></figcaption></figure>

{% hint style="warning" %}
Before configuring the **AI** Agent, please ensure that its input endpoint is connected to a parent Agent which will be sending data to it.
{% endhint %}

### Endpoints

#### **Input**&#x20;

This endpoint is used to receive data from the parent Agent.

#### Output

Events received from the parent Agent are made available to this endpoint, with the OpenAI model's response appended in a new Response attribute (string).

#### Error

Errors encountered during the execution of this Agent will be published on this endpoint.
