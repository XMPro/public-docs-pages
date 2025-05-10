# Integrations

## Overview

XMPro has several different integrations:

* [Agents](#agents) are the building blocks of _Data Stream Designer_ \
  (default Agents bulk download [here](#download-default-agents)).
* [Connectors](#connectors) integrate to third-party data sources in _App Designer_\
  (default Connectors bulk download [here](#connectors))
* [Visualization Blocks](#visualization-blocks) are the building blocks of _App Designer_ to create rich user experiences

## Agents

An [_Agent_](../concepts/agent/) is a reusable object that forms the building block of a Data Stream. When several Agents are connected, a Data Stream is formed.

Each Agent is designed to perform a specific function in the stream. For example, they can be used to retrieve data from a database in real-time, display data, filter, sort the data, or save the data somewhere else, depending on the function of that individual Agent.

Looking for an Agent that is not on the list? Send us a [request](mailto:support@xmpro.com) or check out the [Framework](../how-tos/agents/building-agents.md#overview) to create a new Agent yourself.

### Generative AI & Large Language Models

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/Azure AI Document Intelligence.png" alt="" style="height:20px;"> [Azure AI Document Intelligence](https://xmpro.gitbook.io/azure-ai-document-intelligence) | Generative AI | 5 |
| <img src="images/openai-logo.png" alt="" style="height:20px;"> [Azure OpenAI](https://xmpro.gitbook.io/azure-openai/) | Generative AI | 4 |
| <img src="images/openai-logo.png" alt="" style="height:20px;"> [OpenAI Assistant](https://xmpro.gitbook.io/openai-assistant/) | Generative AI | 5 |
| <img src="images/ollama.png" alt="" style="height:20px;"> [Ollama](https://xmpro.gitbook.io/ollama/) | Generative AI | 5 |

### AI & Machine Learning

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/anomaly-detection.png" alt="" style="height:20px;"> [Anomaly Detection](https://xmpro.gitbook.io/anomaly-detection/) | AI & Machine Learning* | 5 |
| <img src="images/Azure ML.png" alt="" style="height:20px;"> [Azure ML](https://xmpro.gitbook.io/azure-ml/) | AI & Machine Learning | 5 |
| <img src="images/Binary Classification.png" alt="" style="height:20px;"> [Binary Classification](https://xmpro.gitbook.io/binary-classification/) | AI & Machine Learning* | 5 |
| <img src="images/Amber.png" alt="" style="height:20px;"> [Boon Amber](https://xmpro.gitbook.io/boon-amber/) | AI & Machine Learning | 4 |
| <img src="images/Forecasting.png" alt="" style="height:20px;"> [Forecasting](https://xmpro.gitbook.io/forecasting-agent/) | AI & Machine Learning* | 5 |
| <img src="images/KMeans Clustering.png" alt="" style="height:20px;"> [Kmeans Clustering](https://xmpro.gitbook.io/kmeans-clustering/) | AI & Machine Learning* | 5 |
| <img src="images/MLflow icon.png" alt="" style="height:20px;"> [MLflow](https://xmpro.gitbook.io/mlflow/) | AI & Machine Learning | 5 |
| <img src="images/issue-labeler.png" alt="" style="height:20px;"> [Multi Class Classification](https://xmpro.gitbook.io/multi-class-classification/) | AI & Machine Learning* | 5 |
| <img src="images/python2.png" alt="" style="height:20px;"> [Python](https://xmpro.gitbook.io/python/) | AI & Machine Learning | 5 |
| <img src="images/Regression.png" alt="" style="height:20px;"> [Regression](https://xmpro.gitbook.io/regression/) | AI & Machine Learning* | 5 |
| <img src="images/R.png" alt="" style="height:20px;"> [RScript](https://xmpro.gitbook.io/rscript/) | AI & Machine Learning | 5 |

### Social & Communication

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/Email.png" alt="" style="height:20px;"> [Email](https://xmpro.gitbook.io/email/) | Listener, Action Agent | 1 |
| <img src="images/Twilio.png" alt="" style="height:20px;"> [Twilio](https://xmpro.gitbook.io/twilio/) | Action Agent | 1 |

### Database & Technology

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/icon (1).png" alt="" style="height:20px;"> [Azure Data Explorer](https://xmpro.gitbook.io/azure-data-explorer/) | Listener, Context Provider, Action Agent | 2 |
| <img src="images/Azure Data Factory Icon.png" alt="" style="height:20px;"> [Azure Data Factory](https://xmpro.gitbook.io/azure-data-factory/) | Action Agent | 2 |
| <img src="images/azure data lake.svg" alt="" style="height:20px;"> [Azure Data Lake](https://xmpro.gitbook.io/azure-data-lake/) | Action Agent | 2 |
| <img src="images/AzureDigitalTwin.png" alt="" style="height:20px;"> [Azure Digital Twin](https://xmpro.gitbook.io/azure-digital-twin/) | Listener, Context Provider, Action Agent | 2 |
| <img src="images/Azure Event Hub.png" alt="" style="height:20px;"> [Azure Event Hub](https://xmpro.gitbook.io/azure-event-hub/) | Listener, Action Agent | 2 |
| <img src="images/azure-iot-hub.png" alt="" style="height:20px;"> [Azure IoT Hub](https://xmpro.gitbook.io/azure-iot-hub/) | Listener | 2 |
| <img src="images/cognite.png" alt="" style="height:20px;"> [Cognite](https://xmpro.gitbook.io/cognite/) | Listener, Context Provider | 2 |
| <img src="images/Ethereum Icon.png" alt="" style="height:20px;"> [Ethereum Smart Contract](https://xmpro.gitbook.io/ethereum-smart-contract/) | Listener, Action Agent | 2 |
| <img src="images/Excel File Reader.png" alt="" style="height:20px;"> [Excel File Reader](https://xmpro.gitbook.io/excel-file-reader/) | Action Agent | 2 |
| <img src="images/ifm.png" alt="" style="height:20px;"> [ifm](https://xmpro.gitbook.io/ifm/) | Listener | 2 |
| <img src="images/influx db.png" alt="" style="height:20px;"> [InfluxDB](https://xmpro.gitbook.io/influxdb/) | Listener, Context Provider, Action Agent | 2 |
| <img src="images/Litmus.png" alt="" style="height:20px;"> [Litmus Edge OPC UA](https://xmpro.gitbook.io/litmus-edge-opc-ua/) | Listener, Action Agent | 2 |
| <img src="images/mongodb-icon.png" alt="" style="height:20px;"> [MongoDB](https://xmpro.gitbook.io/mongodb/) | Listener, Context Provider, Action Agent | 2 |
| <img src="images/MOVUS.png" alt="" style="height:20px;"> [MOVUS](https://xmpro.gitbook.io/movus/) | Listener, Context Provider, Action Agent | 2 |
| <img src="images/mysql.png" alt="" style="height:20px;"> [MySQL](https://xmpro.gitbook.io/mysql/) | Listener, Context Provider, Action Agent | 2 |
| <img src="images/Neo4j Icon.png" alt="" style="height:20px;"> [Neo4j](https://xmpro.gitbook.io/neo4j/) | Listener, Context Provider, Action Agent | 2 |
| <img src="images/OData.png" alt="" style="height:20px;"> [OData](https://xmpro.gitbook.io/odata/) | Context Provider, Action Agent | 2 |
| <img src="images/ODBC Icon.png" alt="" style="height:20px;"> [ODBC](https://xmpro.gitbook.io/odbc/) | Listener, Context Provider | 2 |
| <img src="images/opc (2).png" alt="" style="height:20px;"> [OPC DA](https://xmpro.gitbook.io/opc-da/) | Listener, Action Agent | 2 |
| <img src="images/opc.png" alt="" style="height:20px;"> [OPC UA](https://xmpro.gitbook.io/opc-ua/) | Listener, Action Agent | 2 |
| <img src="images/Oracle.png" alt="" style="height:20px;"> [Oracle](https://xmpro.gitbook.io/oracle/) | Action Agent | 2 |
| <img src="images/Snowflake logo.png" alt="" style="height:20px;"> [Snowflake](https://xmpro.gitbook.io/snowflake/) | Listener, Context Provider, Action Agent | 2 |

### ERP

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/Coupa Icon.png" alt="" style="height:20px;"> [Coupa](https://xmpro.gitbook.io/coupa) | Context Provider, Action Agent | 3 |
| <img src="images/Erbessed.png" alt="" style="height:20px;"> [Erbessed](https://xmpro.gitbook.io/erbessd/) | Listener, Context Provider | 3 |
| <img src="images/iPOS.png" alt="" style="height:20px;"> [iPOS](https://xmpro.gitbook.io/ipos/) | Action Agent | 3 |
| <img src="images/FinOps.PNG" alt="" style="height:20px;"> [FinOps](https://xmpro.gitbook.io/finops/) | Context Provider, Action Agent | 3 |
| <img src="images/OSIsoft.png" alt="" style="height:20px;"> [OSIsoft PI](https://xmpro.gitbook.io/osisoft-pi/) | Listener, Context Provider, Action Agent | 3 |
| <img src="images/Salesforce.png" alt="" style="height:20px;"> [Salesforce](https://xmpro.gitbook.io/salesforce/) | Listener, Context Provider, Action Agent | 3 |
| <img src="images/sap.png" alt="" style="height:20px;"> [SAP](https://xmpro.gitbook.io/sap/) | Context Provider, Action Agent | 3 |
| <img src="images/sap (1).png" alt="" style="height:20px;"> [SAP HANA](https://xmpro.gitbook.io/sap-hana/) | Context Provider, Action Agent | 3 |

### Advanced App

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/FFT.png" alt="" style="height:20px;"> [FFT](https://xmpro.gitbook.io/fft/) | Function | 4 |
| <img src="images/Nanoprecise.png" alt="" style="height:20px;"> [Nanoprecise](https://xmpro.gitbook.io/nanoprecise/) | Listener, Context Provider, Action Agent | 3 |
| <img src="images/SignalFilter.jpg" alt="" style="height:20px;"> [Signal Filter](https://xmpro.gitbook.io/signal-filter/) | Function | 4 |
| <img src="images/sparkplug icon.png" alt="" style="height:20px;"> [Sparkplug B](https://xmpro.gitbook.io/sparkplug-b/) | Listener, Action Agent | 4 |
| <img src="images/Tango.png" alt="" style="height:20px;"> [Tango](https://xmpro.gitbook.io/tango/) | Listener, Context Provider | 3 |
| <img src="images/deviceWISE_favicon_144x144.png" alt="" style="height:20px;"> [Telit deviceWise](https://xmpro.gitbook.io/telit-devicewise/) | Listener, Context Provider, Action Agent | 3 |
| <img src="images/image (1).png" alt="" style="height:20px;"> [Telit MQTT](https://xmpro.gitbook.io/telit-mqtt) | Listener, Action Agent | 3 |
| <img src="images/image (1) (1).png" alt="" style="height:20px;"> [Telit OPC UA](https://xmpro.gitbook.io/telit-opc-ua/) | Listener, Action Agent | 3 |
| <img src="images/webscraper icon.png" alt="" style="height:20px;"> [WebScraper](https://xmpro.gitbook.io/webscraper/) | Context Provider | 4 |

### Open Source

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/AzureSQL.png" alt="" style="height:20px;"> [Azure SQL](https://xmpro.gitbook.io/azure-sql/) | Listener, Context Provider, Action Agent | 5 |
| <img src="images/CFU.png" alt="" style="height:20px;"> [Convert Flow Units](https://xmpro.gitbook.io/convert-flow-units/) | Function | 5 |
| <img src="images/icon.png" alt="" style="height:20px;"> [CRC16](https://xmpro.gitbook.io/crc16/) | Function | 5 |
| <img src="images/CSV.png" alt="" style="height:20px;"> [CSV](https://xmpro.gitbook.io/csv/) | Listener, Context Provider, Action Agent | 5 |
| <img src="images/Fixed Width.png" alt="" style="height:20px;"> [Fixed Width File Reader](https://xmpro.gitbook.io/fixed-width-file-reader/) | Action Agent | 5 |
| <img src="images/GoalSeek.png" alt="" style="height:20px;"> [Goal Seek](https://xmpro.gitbook.io/goal-seek/) | Function | 5 |
| <img src="images/hivemq-bee.png" alt="" style="height:20px;"> [HiveMQ](https://xmpro.gitbook.io/hivemq/) | Listener, Action Agent | 5 |
| <img src="images/JSON File Context Provider.png" alt="" style="height:20px;"> [JSON](https://xmpro.gitbook.io/json/) | Context Provider, Transformation | 5 |
| <img src="images/linear interpolation.png" alt="" style="height:20px;"> [Linear Interpolation](https://xmpro.gitbook.io/linear-interpolation/) | Function | 5 |
| <img src="images/Min Max.png" alt="" style="height:20px;"> [Min Max](https://xmpro.gitbook.io/min-max/) | Function | 5 |
| <img src="images/MQTT.png" alt="" style="height:20px;"> [MQTT](https://xmpro.gitbook.io/mqtt-listener/) | Listener, Action Agent | 5 |
| <img src="images/pdf converter.png" alt="" style="height:20px;"> [PDF Converter](https://xmpro.gitbook.io/pdf-converter/) | Action Agent | 5 |
| <img src="images/rest.png" alt="" style="height:20px;"> [REST API](https://xmpro.gitbook.io/rest-api/) | Context Provider, Action Agent | 5 |
| <img src="images/Rounding.png" alt="" style="height:20px;"> [Rounding](https://xmpro.gitbook.io/rounding/) | Function | 5 |
| <img src="images/SQL Server.png" alt="" style="height:20px;"> [SQL Server](https://xmpro.gitbook.io/sql-server/) | Listener, Context Provider, Action Agent | 5 |
| <img src="images/XML Reader.png" alt="" style="height:20px;"> [XML File Reader](https://xmpro.gitbook.io/xml-file-reader/) | Action Agent | 5 |

### XMPro Internal

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/Aggregate.png" alt="" style="height:20px;"> [Aggregate](https://xmpro.gitbook.io/aggregate/) | Transformation | 6 |
| <img src="images/alter-attribute-64.png" alt="" style="height:20px;"> [Alter Attributes](https://xmpro.gitbook.io/alter-attributes/) | Transformation | 6 |
| <img src="images/AUC.png" alt="" style="height:20px;"> [Area Under the Curve](https://xmpro.gitbook.io/area-under-the-curve/) | Function | 6 |
| <img src="images/Batch Identifier.png" alt="" style="height:20px;"> [Batch Identifier](https://xmpro.gitbook.io/batch-identifier/) | Transformation | 6 |
| <img src="images/Broadcast.png" alt="" style="height:20px;"> [Broadcast](https://xmpro.gitbook.io/broadcast/) | Transformation | 6 |
| <img src="images/Calculated Field.png" alt="" style="height:20px;"> [Calculated Field](https://xmpro.gitbook.io/calculated-field/) | Transformation | 6 |
| <img src="images/concat.png" alt="" style="height:20px;"> [Concatenate Row Values](https://xmpro.gitbook.io/concatenate-row-values/) | Transformation | 6 |
| <img src="images/Data Conversion.png" alt="" style="height:20px;"> [Data Conversion](https://xmpro.gitbook.io/data-conversion) | Transformation | 6 |
| <img src="images/Edge Analysis.png" alt="" style="height:20px;"> [Edge Analysis](https://xmpro.gitbook.io/edge-analysis/) | Transformation | 6 |
| <img src="images/Event Printer.png" alt="" style="height:20px;"> [Event Printer](https://xmpro.gitbook.io/event-printer/) | Action Agent | 6 |
| <img src="images/Event Simulator.png" alt="" style="height:20px;"> [Event Simulator](https://xmpro.gitbook.io/event-simulator/) | Listener | 6 |
| <img src="images/File Monitor.png" alt="" style="height:20px;"> [File Listener](https://xmpro.gitbook.io/file/) | Listener | 6 |
| <img src="images/Filter.png" alt="" style="height:20px;"> [Filter](https://xmpro.gitbook.io/filter/) | Transformation | 6 |
| <img src="images/GeoFence.png" alt="" style="height:20px;"> [Geofence](https://xmpro.gitbook.io/geofence/) | Function | 6 |
| <img src="images/Group and Merge.png" alt="" style="height:20px;"> [Group & Merge](https://xmpro.gitbook.io/group-and-merge/) | Transformation | 6 |
| <img src="images/Join.png" alt="" style="height:20px;"> [Join](https://xmpro.gitbook.io/join/) | Transformation | 6 |
| <img src="images/Meta Icon.png" alt="" style="height:20px;"> [Meta](https://xmpro.gitbook.io/meta/) | Action Agent | 6 |
| <img src="images/Missing Values Detector.png" alt="" style="height:20px;"> [Missing Value Detector](https://xmpro.gitbook.io/missing-values-detector/) | Transformation | 6 |
| <img src="images/Missing Values Substitutor.png" alt="" style="height:20px;"> [Missing Value Substitutor](https://xmpro.gitbook.io/missing-value-substitutor/) | Transformation | 6 |
| <img src="images/NormalizeFieldsIcon.png" alt="" style="height:20px;"> [Normalize Fields](https://xmpro.gitbook.io/normalize-fields/) | Transformation | 6 |
| <img src="images/Pass Through.png" alt="" style="height:20px;"> [Pass Through](https://xmpro.gitbook.io/pass-through/) | Transformation | 6 |
| <img src="images/pivot.png" alt="" style="height:20px;"> [Pivot Table](https://xmpro.gitbook.io/pivot-table/) | Transformation | 6 |
| <img src="images/RandomNumberIcon.png" alt="" style="height:20px;"> [Random Number](https://xmpro.gitbook.io/random-numbers/) | Transformation | 6 |
| <img src="images/Row Count.png" alt="" style="height:20px;"> [Row Count](https://xmpro.gitbook.io/row-count/) | Transformation | 6 |
| <img src="images/Row Padding.png" alt="" style="height:20px;"> [Row Padding](https://xmpro.gitbook.io/row-padding/) | Transformation | 6 |
| <img src="images/Sort.png" alt="" style="height:20px;"> [Sort](https://xmpro.gitbook.io/sort/) | Transformation | 6 |
| <img src="images/Threshold Monitor.png" alt="" style="height:20px;"> [Threshold Monitor](https://xmpro.gitbook.io/threshold-monitor/) | Transformation | 6 |
| <img src="images/pivot.png" alt="" style="height:20px;"> [Transpose](https://xmpro.gitbook.io/transpose/) | Transformation | 6 |
| <img src="images/Trim.png" alt="" style="height:20px;"> [Trim](https://xmpro.gitbook.io/trim/) | Transformation | 6 |
| <img src="images/Union.png" alt="" style="height:20px;"> [Union](https://xmpro.gitbook.io/union/) | Transformation | 6 |
| <img src="images/UnzipIcon.png" alt="" style="height:20px;"> [Unzip](https://xmpro.gitbook.io/unzip/) | Action Agent | 6 |
| <img src="images/Window.png" alt="" style="height:20px;"> [Window](https://xmpro.gitbook.io/window/) | Transformation | 6 |
| <img src="images/XMPro App.png" alt="" style="height:20px;"> [XMPro App](https://xmpro.gitbook.io/xmpro-app/) | Action Agent | 6 |

### Recommendations

| Agent | Category | Tier |
|-------|----------|------|
| <img src="images/ActionRequestIcon.png" alt="" style="height:20px;"> [Close Action Request](https://xmpro.gitbook.io/action-request-agents/) | Recommendation | 6 |
| <img src="images/ActionRequestIcon.png" alt="" style="height:20px;"> [Read Action Request](https://xmpro.gitbook.io/action-request-agents/) | Recommendation | 6 |
| <img src="images/Read Recommendation.png" alt="" style="height:20px;"> [Read Recommendation](https://xmpro.gitbook.io/read-recommendation/) | Recommendation | 6 |
| <img src="images/Resolve Recommendation.png" alt="" style="height:20px;"> [Resolve Recommendation](https://xmpro.gitbook.io/resolve-recommendation/) | Recommendation | 6 |
| <img src="images/Run Recommendation.png" alt="" style="height:20px;"> [Run Recommendation](https://xmpro.gitbook.io/run-recommendation) | Recommendation | 6 |
| <img src="images/Update Recommendation.png" alt="" style="height:20px;"> [Update Recommendation](https://xmpro.gitbook.io/update-recommendation/) | Recommendation | 6 |

### Download Default Agents

#### Tier 5

Download the tier 5 files [here](https://xmappstore.blob.core.windows.net/tier5/Tier%205%20-%20Agents.zip).

Use these individual files if you are not on v4.1.13 or higher:

| [Action Agents](https://xmappstore.blob.core.windows.net/tier5/Tier%205%20-%20Action%20Agents.zip)<br>[AI & ML](https://xmappstore.blob.core.windows.net/tier5/Tier%205%20-%20AI_ML.zip) | [Context Providers](https://xmappstore.blob.core.windows.net/tier5/Tier%205%20-%20Context%20Providers.zip)<br>[Functions](https://xmappstore.blob.core.windows.net/tier5/Tier%205%20-%20Functions.zip) | [Listeners](https://xmappstore.blob.core.windows.net/tier5/Tier%205%20-%20Listeners.zip) |
|---|---|---|

*Note: Links for the larger AI & ML Agents are on their individual documentation pages.

#### Tier 6

Download the tier 6 files [here](https://xmappstore.blob.core.windows.net/tier6/Tier%206%20-%20Agents.zip).

Use these individual files if you are not on v4.1.13 or higher:

| [Action Agents](https://xmappstore.blob.core.windows.net/tier6/Tier%206%20-%20Action%20Agents.zip)<br>[Functions](https://xmappstore.blob.core.windows.net/tier6/Tier%206%20-%20Functions.zip) | [Listeners](https://xmappstore.blob.core.windows.net/tier6/Tier%206%20-%20Listeners.zip)<br>[Recommendations](https://xmappstore.blob.core.windows.net/tier6/Tier%206%20-%20Recommendations.zip) | [Transformations](https://xmappstore.blob.core.windows.net/tier6/Tier%206%20-%20Transformations.zip) |
|---|---|---|

## Connectors

A [_Connector_](../concepts/connector.md) is a pre-built integration plug-in for the XMPro App Designer that allows you to connect to third-party data sources without coding.

Whereas the Agents in a published Data Stream continuously poll for data, the Connectors in a published App retrieve data on an ad-hoc basis.

> [!NOTE]
> Download the tier 5 & 6 Connector files [here](https://xmappstore.blob.core.windows.net/tier5/Tier%205%20%26%206%20-%20Connectors.zip).

### Database & Technology

| Connector | Tier |
|-----------|------|
| <img src="images/icon (1).png" alt="" style="height:20px;"> [Azure Data Explorer](https://xmpro.gitbook.io/azure-data-explorer-connector/) | 2 |
| <img src="images/Azure Data Explorer Icon.png" alt="" style="height:20px;"> [TSA Azure Data Explorer](https://xmpro.gitbook.io/tsa-azure-data-explorer-connector) | 2 |
| <img src="images/AzureDigitalTwin.png" alt="" style="height:20px;"> [Azure Digital Twin](https://xmpro.gitbook.io/azure-digital-twin-connector/) | 2 |
| <img src="images/Neo4j Icon.png" alt="" style="height:20px;"> [Neo4J](https://xmpro.gitbook.io/neo4j-connector/) | 2 |
| <img src="images/Snowflake logo.png" alt="" style="height:20px;"> [Snowflake](https://xmpro.gitbook.io/snowflake-connector/) | 2 |

### ERP

| Connector | Tier |
|-----------|------|
| <img src="images/Erbessd Logo.png" alt="" style="height:20px;"> [Erbessd](https://xmpro.gitbook.io/erbessd-connector/) | 3 |
| <img src="images/OSIsoft.png" alt="" style="height:20px;"> [OSIsoft PI](https://xmpro.gitbook.io/osisoft-pi-connector/) | 3 |
| <img src="images/OSIsoft.png" alt="" style="height:20px;"> [OSIsoftPI Histogram](https://xmpro.gitbook.io/osisoft-pi-histogram-connector/) | 3 |

### Advanced App

| Connector | Tier |
|-----------|------|
| <img src="images/Nanoprecise.png" alt="" style="height:20px;"> [Nanoprecise](https://xmpro.gitbook.io/nanoprecise-connector/) | 3 |

### Open Source

| Connector | Tier |
|-----------|------|
| <img src="images/AzureSQL.png" alt="" style="height:20px;"> [Azure SQL](https://xmpro.gitbook.io/azure-sql-connector/) | 5 |
| <img src="images/http icon.png" alt="" style="height:20px;"> [HTTP](https://xmpro.gitbook.io/http-connector/) | 5 |
| <img src="images/JSON.png" alt="" style="height:20px;"> [JSON](https://xmpro.gitbook.io/json-connector/) | 5 |
| <img src="images/rest.png" alt="" style="height:20px;"> [REST API](https://xmpro.gitbook.io/rest-api-connector/) | 5 |
| <img src="images/SQL Server.png" alt="" style="height:20px;"> [SQL Server](https://xmpro.gitbook.io/sql-server-connector/) | 5 |
| <img src="images/SQL Server.png" alt="" style="height:20px;"> [TSA SQL Server](https://xmpro.gitbook.io/tsa-sql-server-connector/) | 5 |

### XMPro Internal

| Connector | Tier |
|-----------|------|
| <img src="images/DS Icon.png" alt="" style="height:20px;"> [Data Streams](https://xmpro.gitbook.io/data-streams-connector/) | 6 |

## Visualization Blocks

An App Designer [_visualization block_](../blocks-toolbox/visualizations/) allows a no-code way to integrate with third-party systems and create rich user experiences. Listed below are _some_ of the integration blocks found in the App Designer toolbox:

| Visualization Block |
|---------------------|
| <img src="images/Autodesk-Forge-icon (1).png" alt="" style="height:20px;"> [Autodesk Forge](../blocks-toolbox/visualizations/autodesk-forge.md) |
| <img src="images/d3widget-icon.png" alt="" style="height:20px;"> [D3 Visualization](../blocks-toolbox/visualizations/d3-visualization.md) |
| <img src="images/esri-arcgis-icon.png" alt="" style="height:20px;"> [Esri Map](../blocks-toolbox/visualizations/esri-map.md) |
| <img src="images/pivot-grid-icon.png" alt="" style="height:20px;"> [Pivot Grid](../blocks-toolbox/visualizations/pivot-grid.md) |
| <img src="images/powerbi-icon.png" alt="" style="height:20px;"> [Power BI](../blocks-toolbox/visualizations/power-bi.md) |
| <img src="images/trendchart-icon.png" alt="" style="height:20px;"> [Time Series Chart](../blocks-toolbox/visualizations/time-series-analysis.md) |
| <img src="images/unity-icon.png" alt="" style="height:20px;"> [Unity](../blocks-toolbox/visualizations/unity-1.md) |
