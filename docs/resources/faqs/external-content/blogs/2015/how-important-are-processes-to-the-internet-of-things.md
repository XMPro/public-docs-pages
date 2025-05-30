# How Important Are Processes To The Internet Of Things?

[**Blog**](https://xmpro.com/category/blog/)**,** [**CEO'S Blog**](https://xmpro.com/category/blog/pieter-blog/)

## How Important Are Processes To The Internet Of Things?

Posted on [February 18, 2015](https://xmpro.com/how-important-are-processes-to-the-internet-of-things/) by [Pieter van Schalkwyk](https://xmpro.com/author/pietervs/)

In my view the question should be focused on the business outcome: How important is it to sense key business events from machine-born data (devices, sensors and IoT), decide if action is needed and then respond in an appropriate manner.

Deconstructing the question like this leads to 3 key elements for consideration.

![](https://xmpro.com/wp-content/uploads/2015/02/SDA_VennDiagram_v2.png)

Firstly, organizations need to gather Operational Intelligence using event stream processing and complex event processing. To do this the OI platform needs some form of adapters or connectors to easily “Ingest” information into the OI platform. The streaming event data (from IoT or other sources) may need “Conditioning” before it is “Integrated” with contextual business data before “Rules” are applied to identify key business moments or trends.

The second element is to provide decision support. It can be as simple as a business rule or it can be more involved with social collaboration (asking others for their opinion) or provide BI style analytical support. Machine Learning can applied at this point for predictive analysis if the use case supports it. The objective of the decision support element is to decide if an action is required. Not all IoT data needs to be acted on.

The third element requires an “appropriate” response based on application. Sometimes it can as simple as a well-defined workflow for a planned response to an anticipated exception. BPM adds value in this scenario. More often than not it requires an unplanned response to an unanticipated event. In this case it may be as simple as sending an SMS alert or, as we often suggest to customers, an Adaptive Case Management (ACM) solution to orchestrate the response on a case by case basis. The appropriate response often requires automation of actions in another business system such as the Supply Chain Management module of an ERP solution. In that case BPM does not play a role as an OI solution with agent behavior can accomplish this.

There is no simple answer for dealing the sea of data from IoT other than creating some Operational Intelligence from it, deciding if any action should be taken, and then using the appropriate technology to manage (machine or human) the response.

BTW my simple definition on the difference between BI and OI is that BI requires storing data and then creating some retrospective intelligence over it (what happened) where OI first interrogates event data (what is happening) before deciding if it should be stored.

