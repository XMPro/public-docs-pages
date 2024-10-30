---
description: XMPro Capabilities and Design Patterns, July 2024
---

# Unified Recommendation Alert Management

{% file src="../../.gitbook/assets/Design Patterns for APM Capabilities and Recommendation Alerts.pdf" %}

## Audience

The readers who will find this documentation most useful should have a working knowledge of XMPro and use XMPro to address asset performance business problems. It is suggested that new users of XMPro should workshop their requirements with their XMPro partners. It is useful to emphasize that XMPro is an Intelligent Business Operations Solution (iBOS).&#x20;

### Problem Statement&#x20;

The overall problem we are seeking to address can be stated as:&#x20;

As an Engineer \
I want **“to be able to manage centrally all my Recommendation Alerts through a process, apply filtered views, and have the Recommendation Alerts re-scored for prioritization based on the real-time industrial data”** \
So that **“non-performing assets or processes can be addressed in a timely manner and interruptions to operations can be avoided.”**

## **Introduction**

This document arises from the work done with partners and seeks to align some APM capabilities pertaining to Recommendation Alert Management with XMPro configurations based on standard XMPro capability. For ease of use, we have labelled those configurations ‘Design Patterns' and when grouped for a common use requirement are referred to as ‘Composable Business Capabilities’ (CBC **1**). The customer should adapt the design pattern to their own situation. Some of the Design Patterns have been further developed and are available as Apps in our GitHub repository **2** – these are ‘Packaged Business Capabilities’ (PBC) **3**.&#x20;

In the context of a plant or mine, the Reliability Engineer uses the XMPro Asset Digital Twin Apps to monitor assets and equipment in order to identify or predict failures and faults. The goal of effective Recommendation Alert management is to support the overall objective: _“The goal of XMPro iBOS solutions is to ensure optimal application performance and user experience by monitoring, diagnosing, and resolving performance issues proactively.”_

{% hint style="info" %}
**References**

**1** Gartner Reference Model for Intelligent Composable Business Applications

**2** https://xmpro.github.io/Blueprints-Accelerators-Patterns/

**3** Gartner Reference Model for Intelligent Composable Business Applications
{% endhint %}

<figure><img src="../../.gitbook/assets/image (1875).png" alt=""><figcaption><p>Fig 1 - Life cycle of Digital Twin Events in asset performance monitoring</p></figcaption></figure>

The Asset Digital Twins act as a monitoring and reliability system that continuously gathers, computes, and presents events relevant to the operational performance, maintenance, and reliability of a plant. Assets such as pumps, compressors, heat exchangers, turbines, and furnaces are monitored at frequent intervals. The engineering-based formulas, fault, and performance calculation models are continuously executed to detect and report faults and performance degradation early to avoid costly failures.&#x20;

This document seeks to address the overall APM capability of a unified view of scored Recommendation Alerts. We link these APM capabilities with the Design Patterns of XMPro capability. We address other APM requirements in separate documents. Future Practice Notes will address Predictive Maintenance, Condition Monitoring, False Positive Management, and other requirements.

Features of Asset Digital Twins, delivered by XMPro, within an APM context include:

* Aggregate data from different sources and present in a single window, per equipment, for easy analysis, trending, and monitoring.
* Provide the users with a unified interface that will be used in daily activities.
* Management of equipment data that is needed to monitor equipment health and performance.
* Near real-time performance analysis and alert notifications.
* Near real-time monitoring of critical operating parameters.
* Single version of truth for similar equipment by standardizing the calculations.
* Compare the performance of equipment against design.
* Displaying equipment properties such as equipment type, manufacturer, etc.
* Filtering and grouping of equipment condition data.
* Predict asset faults by using advanced pattern recognition.

### Summary

| Summary Requirement                                  | APM Capability                                                                                                                                                                                                                                                                                       | Associated Design Pattern  | Application Description                                                                                                                     |
| ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| Management of Prioritized Recommendation Alerts      | <p>Unified view of Recommendation Alerts, reliability health, and risk scores. </p><p>Asset and alert rating</p><ul><li>Asset criticality</li><li>Recommendation severity</li><li>Recommendation alert priority </li></ul><p>Recommendation alert management. Priority map of asset criticality.</p> | Strategy Pattern           | <ul><li>Recommendation alert scoring</li><li>Workbench</li><li>Asset Analysis meta tags</li><li>Recommendation Analysis meta tags</li></ul> |
| Categorization of Recommendation Alerts              | Recommendation alert management.                                                                                                                                                                                                                                                                     | Decorator Pattern          | <ul><li>Recommendation Analysis meta tags</li></ul>                                                                                         |
| Categorization of Assets                             | Asset hierarchy will cater for user-defined categorization. Asset hierarchy capability within the system and not rely on the historian asset hierarchies.                                                                                                                                            | Decorator Pattern          | <ul><li>Asset Analysis meta tags</li></ul>                                                                                                  |
| Management of Recommendation Alerts during Shutdowns | Capability to suspend alerts during a Shutdown process.                                                                                                                                                                                                                                              | State and Observer Pattern | <ul><li>Shutdown</li></ul>                                                                                                                  |
|                                                      | Reliability-Centred Maintenance (RCM) and Work Order Management.                                                                                                                                                                                                                                     | Aggregator Pattern         | <ul><li>Work Bench</li><li>Configured Recommendation Alert page</li></ul>                                                                   |

### Glossary

<table data-header-hidden><thead><tr><th width="172">Acronym</th><th>Description</th></tr></thead><tbody><tr><td>ADT    </td><td>Asset Digital Twin</td></tr><tr><td>APM </td><td>Asset Performance Management</td></tr><tr><td>CBC </td><td>Composable Business Capabilities </td></tr><tr><td>CMMS </td><td>Computerized Maintenance Management System</td></tr><tr><td>EAM </td><td>Enterprise Asset Management </td></tr><tr><td>EWMA </td><td>Exponentially Weighted Moving Average </td></tr><tr><td>LOESS </td><td>Locally estimated scatterplot smoothing </td></tr><tr><td>LOWESS </td><td>Locally weighted scatterplot smoothing</td></tr><tr><td>PBC </td><td> Packaged Business Capabilities</td></tr><tr><td>RPN </td><td> Risk Priority Number</td></tr></tbody></table>

### Asset Prioritization Definitions

<table data-header-hidden><thead><tr><th width="172">Term</th><th>Definition</th></tr></thead><tbody><tr><td>Criticality</td><td>Criticality is an attribute (numeric value) associated with an asset. It denotes the relative importance of an asset based on process, financial, and safety considerations and is asset class agnostic. The values of criticality are between 1 – 5.</td></tr><tr><td>Severity / RPN</td><td><p>Severity is an attribute (numeric value) associated with faults and symptoms. It indicates the relative performance impact (severity) of the fault and symptom on an asset. The values of severity are 1 – 10. </p><p>The three key factors that make up the Risk Priority Number (RPN): severity, occurrence, and detection. </p><p>In XMPro severity is assigned to the Recommendation category, Recommendation &#x26; Recommendation rule rankings. Occurrence is measured by the frequency of Recommendation Alerts created.</p></td></tr><tr><td>Priority</td><td><p>Priority = RPN (or severity) * Criticality </p><p>Priority is a parameter of an asset that indicates the health of the asset. The priority value is calculated by multiplying the numeric values of RPN (severity * occurrence) and criticality. The priority value determines the asset’s icon color which indicates a fault. It enhances sorting capabilities within the asset’s view and alert management.</p></td></tr></tbody></table>

## APM Capability

### Management of Prioritized Recommendation Alerts

**APM capabilities**

* Unified view of Recommendation Alerts, reliability health and risk scores
* Asset and alert rating
  * Asset criticality
  * Recommendation severity
  * Recommendation alert priority
* Recommendation alert management
* Priority map of asset criticality

**Design Pattern**

* Recommendation alert scoring – Strategy Pattern
* Workbench – Aggregator Pattern
* Asset Analysis Meta Tags – Decorator Pattern
* Recommendation Analysis Meta Tags – Decorator Pattern

**APM requirements**&#x20;

A number of the requirements are addressed out of the box. Design patterns can be used to enhance the system's capability further.

* Unified view
  * The APM system will provide a unified view of the reliability health and risk scores through the integration of asset strategy, condition monitoring, analytics, and APM data systems to measure cost, failure rates, and compliance metrics.
* Priority
  * The APM system will provide a standard process for defining the criticality of assets. o The APM system will provide a standard process for defining the Risk Priority Number (RPN) / severity score of recommendation alerts.
  * The APM system will provide a standard process for prioritizing recommendation alerts by the measure of an alert’s Risk Priority Number (RPN) and an asset criticality score.
  * The APM system will provide a modifiable risk matrix that can be adjusted to the company’s definition of risk.
* Recommendation management
  * The APM system will provide the ability to create recommendations within each area of functionality that can be associated with an equipment ID or functional location.
  * The APM system will provide means to track and follow up recommendations from several hierarchical levels perspective in the organization (site, areas, units, system, and assets).
  * The APM system will provide the ability to schedule an alert email message to be sent to the person responsible for ensuring that the recommendation is addressed.
  * The APM system will provide concise reporting and alerting capability to track outstanding and past-due recommendations.
  * The APM system will provide the ability to initiate recommendations into EAM/CMMS systems for further planning and execution.

### Categorization of Recommendation Alerts

A Recommendation Meta Tag App uses the Decorator Pattern to dynamically enhance asset data without altering the original schema. The app enriches contextual data by assigning meta tags such as performance metrics, maintenance recommendations, and operational statuses to assets, enabling more informed decision-making. This approach allows for flexible and scalable data enhancement, improving predictive maintenance, performance monitoring, and overall asset management within the APM framework.

**APM capability**

* Asset monitoring Unified view of filtered Recommendation Alerts

**Design Pattern**

* Workbench – Aggregator Pattern
* Recommendation Analysis meta tags – Decorator Pattern&#x20;

**APM requirements**

A number of the requirements are addressed out of the box. Design patterns can be used to enhance the system's capability further.

* Recommendation management
  * The APM system will provide the capability to filter and categorize alerts.
  * The APM system will provide the capability to filter and categorize alerts by fault mechanism.

### Categorization of Assets

An Asset Master Hierarchy App utilizes the Decorator Pattern to dynamically enhance the hierarchical representation of assets without altering the original asset structure. This App assigns hierarchical meta tags, such as parent-child relationships, asset dependencies, and location mappings, to assets, for more informed decision-making.&#x20;

**APM capability**

* Asset hierarchy will cater for user-defined categorization.
* Asset hierarchy capability within the system and not rely on the historian asset hierarchies. Associated

**Design Pattern**

* Asset Analysis meta tags – Decorator Pattern

**APM requirements**&#x20;

A number of the requirements are addressed out of the box. Design patterns can be used to enhance the system's capability further.

* Recommendation management
  * The APM system will provide the capability to filter and categorize assets.
  * The APM system will provide the capability to allocate a criticality score to each asset.

### Management of Recommendation Alerts during Shutdowns

The Shutdown Management App uses the State and Observer Patterns to manage preplanned shutdowns effectively. During a shutdown, the app transitions assets to a "Disabled" state using the State Pattern, silencing recommendations and preventing the creation of equipment alerts based on anomalies. The Observer Pattern ensures stakeholders are notified about the shutdown schedule via email, enhancing communication and coordination. This approach maintains system integrity and operational efficiency by ensuring that no unnecessary alerts are generated during maintenance periods.&#x20;

**APM capability**

* Capability to suspend alerts during a Shutdown process.&#x20;

**Associated Design Pattern**

* Shutdown – Object, Observer patterns&#x20;

**APM requirements**&#x20;

A number of the requirements are addressed out of the box. Design patterns can be used to enhance the system's capability further.

* The APM system will provide the capability to automatically suspend generate alerts during a planned shutdown / start-up.
* The APM system will provide the capability to amend planned shutdown and startup times for a planned shutdown / start-up.
* The APM system will optionally categorize and store alerts generated during the shutdown and start-up procedures.

### Ability to track Work Orders arising from Recommendation Alerts

**APM capability**

* Paper-free integration to CMMS for the work order process.&#x20;

**Associated Design Pattern**

* Work Bench – Aggregator Pattern
* Custom Recommendation Alert page – Aggregator Pattern&#x20;

**APM requirements**&#x20;

A number of the requirements are addressed out of the box. Design patterns can be used to enhance the system's capability further.

* The APM system will provide linkage from the analysis of recommendation alerts to the resulting work order.
* The APM system will provide integration to a maintenance management/paper-free work order process.

## XMPro configurations as Design Patterns

This section articulates how, through using XMPro capabilities, the APM requirement is addressed.&#x20;

The authors have used standard XMPro functionality to create the various design patterns. The most popular design pattern is ‘Work Bench’, but we recommend that the other design patterns should be reviewed and considered.&#x20;

The thrust of this Practice Note is the effective management of Recommendation Alerts. Below highlights the XMPro capability of composable low code application by highlighting an alternative composed Recommendation Alert page. This contrasts with the standard Recommendation Alert page available in XMPro.

<figure><img src="../../.gitbook/assets/image (1876).png" alt=""><figcaption><p>Fig 2 - Example Recommendation Alerts detail page</p></figcaption></figure>

### Work Bench

The objective of the Recommendation Alerts Workbench design pattern is to allow for the prioritization, categorization, and filtering of alerts. The workbench addresses the following APM capabilities:

* Unified view of Recommendation Alerts, reliability health and risk scores
* Asset and alert rating (Asset criticality, Recommendation severity, and Recommendation alert priority)
* Recommendation alert management
* Priority map of asset criticality
* Generic querying, reporting, graphing, and searching capabilities for all asset types, alert histories, and work orders.

Users have a high-level unified view to assist in their workflow process by providing the ability to see XMPro alerts filtered by criticality and status as well as associated work orders (WOs).

<figure><img src="../../.gitbook/assets/image (1877).png" alt=""><figcaption><p>Fig 3 - Workbench Landing Page – Unassigned Alerts</p></figcaption></figure>

In the above example the first three tabs focus on the status of Recommendation Alerts – open through to assigned. The landing page alert tabs will include all unassigned alerts. The last three tabs focus on linked work orders and the appropriate status as they are created through to closure. The filtering, tabs, actions, and various statuses would be set for your circumstance. Users may sort, group or filter as required.

<figure><img src="../../.gitbook/assets/image (1878).png" alt=""><figcaption><p>Fig 4 - Workbench – Alerts Page</p></figcaption></figure>

The aim is to give the user situational awareness of all the elements of the Recommendation Alert.&#x20;

The above example page provides the relevant information on an alert to allow users to:

* See a holistic view of a piece of equipment (ability to see all alerts related to that asset)
* Any associated discussion that may provide insights into the investigation and actions taken
* Data at the time of alert triggering
* Relevant metrics (schematics, score history)

<figure><img src="../../.gitbook/assets/image (1879).png" alt=""><figcaption><p>Fig 5 - Workbench Application – Creation of a WO</p></figcaption></figure>

This page provides the ability to assign a WO to one or multiple alerts.

<figure><img src="../../.gitbook/assets/image (1880).png" alt=""><figcaption><p>Fig 6 - Workbench – Open Work Orders</p></figcaption></figure>

This page shows all open work orders and associated Recommendation Alerts.

### Recommendation Meta Tags Administration

The Recommendation Meta Tag Application enriches asset data by dynamically adding meta tags with maintenance recommendations, operational statuses, and performance metrics.&#x20;

This contextual information aids in making informed maintenance decisions and optimizing asset performance. By enhancing data without altering the original asset schema, the application supports predictive maintenance and improves overall asset management, leading to increased operational efficiency and reliability.

<figure><img src="../../.gitbook/assets/image (1881).png" alt=""><figcaption><p>Fig 7 - Recommendation Meta Tag Administration – Reference Grid</p></figcaption></figure>

On this page, we have opted to distinguish between ‘Not Allocated’ and ‘Not Reviewed’.&#x20;

‘Not Allocated’ means that the Meta Tag is not relevant to the Asset (in the above, this is the preferred allocation as it is not blank), and ‘Not Reviewed’ means that no selection has been decided for this asset.

<figure><img src="../../.gitbook/assets/image (1882).png" alt=""><figcaption><p>Fig 8 - Recommendation Meta Tag Administration – Recommendation Assignment Page</p></figcaption></figure>

In the page above we have assigned Meta Tag Values to an Asset.

<figure><img src="../../.gitbook/assets/image (1883).png" alt=""><figcaption><p>Fig 9 - Recommendation Meta Tag Administration – Meta Tag Value</p></figcaption></figure>

This page creates or edits the Meta Tag Values. The Meta Tag column will populate a dropdown of existing options from the list of available options Created on the Meta Tags page.

<figure><img src="../../.gitbook/assets/image (1884).png" alt=""><figcaption><p>Fig 10 - Recommendation Meta Tag Administration – Email Administration</p></figcaption></figure>

This page contains a grid where the user can create or edit the Meta Tags.

### Asset Meta Tags Administration

The Asset Meta Tag Application enhances asset management by dynamically adding meta tags to asset data. These tags include performance metrics, maintenance recommendations, and operational statuses, providing enriched contextual information.&#x20;

This additional data helps in predictive maintenance, performance monitoring, and informed decision-making without altering the original asset schema. The application enables better asset tracking and management, leading to improved operational efficiency and reliability.

<figure><img src="../../.gitbook/assets/image (1885).png" alt=""><figcaption><p>Fig 11 - Asset Meta Tag Administration – Reference Grid</p></figcaption></figure>

On this page, we have opted to distinguish between ‘Not Allocated’ and ‘Not Reviewed’.

‘Not Allocated’ means that the Meta Tag is not relevant to the Asset (a preferred allocation rather than blank), and ‘Not Reviewed’ means that no selection has been made for this asset.

<figure><img src="../../.gitbook/assets/image (1886).png" alt=""><figcaption><p>Fig 12 - Asset Meta Tag Administration – Asset Assignment Page</p></figcaption></figure>

This page will be used to assign Meta Tag Values to an Asset. Each Meta Tag will populate a row with the corresponding Meta Tag Values for selection from the dropdown.

<figure><img src="../../.gitbook/assets/image (1887).png" alt=""><figcaption><p>Fig 13 - Asset Meta Tag Administration – Meta Tag Value</p></figcaption></figure>

This page contains a grid where users can create or edit the Meta Tag Values. The Meta Tag column will populate a dropdown of existing options from the list of available options created on the Meta Tags page.

<figure><img src="../../.gitbook/assets/image (1888).png" alt=""><figcaption><p>Fig 14 - Asset Meta Tag Administration – Meta Tag Values</p></figcaption></figure>

By way of example, this page creates the individual values for the “Location” Meta Tag.

### Recommendation Alert Scoring

Recommendation Alert Priority Score = _Recommendation Alert settings (<mark style="color:blue;">**Severity**</mark> x <mark style="color:blue;">**Occurrence**</mark> x <mark style="color:blue;">**Detectability**</mark>) x <mark style="color:blue;">**Asset Criticality**</mark> settings (assigned at Asset level)._&#x20;

_<mark style="color:blue;">**Severity**</mark>_  is set at the Recommendation level with the Recommendation Category Factor, the Recommendation Factor, and the Recommendation Rule Factor.&#x20;

_<mark style="color:blue;">**Occurrence**</mark>_ is measured in the Data Stream and updated with the ‘Run Recommendation’ agent. The value is updated to the Recommendation Rule Optional Factor.&#x20;

_<mark style="color:blue;">**Detectability**</mark>_ is omitted as we assume that the Failure Mode is detectable if a recommendation rule exists.&#x20;

_<mark style="color:blue;">**Asset Criticality**</mark>_ is assigned at an Asset level in the Asset Master, Asset Hierarchy, or Asset meta tags. The value is included and processed in the applicable Data Stream. The value is updated to the Recommendation Rule Optional Factor.&#x20;

In FMEA, RPN is defined as _Severity x Occurrence x Detectability_.&#x20;

Recommendation Alert Priority Score = _RPN x Asset Criticality_.&#x20;

With existing recommendation alert scoring and criticality from either an ERP, Asset Master or Asset Meta Tag, assigning alert scores based on FMECA is possible using embedded solutions.&#x20;

XMPro capability on Recommendation scoring **4**.

{% hint style="info" %}
**4** [How is scoring calculated?](../../concepts/recommendation/recommendation-scoring.md#how-is-the-scoring-calculated)
{% endhint %}

<figure><img src="../../.gitbook/assets/image (1889).png" alt=""><figcaption><p>Fig 15 - Assigned score is visible for each Recommendation Alert.</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (1890).png" alt=""><figcaption><p>Fig 16 - Each Recommendation contains the Recommendation Factor, Rule factor and Optional Factor.</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (1891).png" alt=""><figcaption><p>Fig 17 - Recommendation Category Factor</p></figcaption></figure>

### Asset Shutdown

The purpose of the app is to allow users to silence alert generation for specific assets in recommendations while still maintaining the published state of the recommendation.&#x20;

This activation/deactivation will take place automatically based on predefined start/stop dates. The application will also notify users when the shutdown starts and ends to determine if a modification is necessary and as a verification step.

<figure><img src="../../.gitbook/assets/image (1892).png" alt=""><figcaption><p>Fig 18 - Shutdown Master – Shutdown Creation Page</p></figcaption></figure>

This page will be used to create new shutdowns and edit existing shutdowns. For existing shutdowns, assigned assets will appear below the shutdown grid.

<figure><img src="../../.gitbook/assets/image (1893).png" alt=""><figcaption><p>Fig 19 - Shutdown Master – Asset Assignment Page</p></figcaption></figure>

This page will be used to assign Assets to an existing shutdown. The “Previously Selected” column tells shutdown planners what Assets are already assigned to a shutdown.

<figure><img src="../../.gitbook/assets/image (1894).png" alt=""><figcaption><p>Fig 20 - Shutdown Master – Email Administration</p></figcaption></figure>

This page will allow users to subscribe to all Shutdown Start/Stop alerts by Site level.

## Appendix 1 APM Capability & Design Patterns addressed by XMPro

<table><thead><tr><th width="222">APM Capability</th><th width="200">Design Pattern</th><th>Description</th></tr></thead><tbody><tr><td>Instrumentation and Monitoring</td><td>Observer Pattern</td><td>Enables objects to subscribe to events and get notified of changes, useful for monitoring updates.</td></tr><tr><td>Centralized Logging</td><td>Aggregator Pattern</td><td>Collects and combines logs from multiple sources into a central repository. </td></tr><tr><td>Distributed Tracing </td><td>Chain of Responsibility Pattern</td><td>Passes a request along a chain of handlers to trace the path of a request through services. </td></tr><tr><td>Health Checks and Heartbeats </td><td>Strategy Pattern </td><td> Defines interchangeable algorithms for performing health checks on various services.</td></tr><tr><td>Alerting and Notifications </td><td>Observer Pattern</td><td>Subscribes to specific events and triggers notifications when conditions are met. </td></tr><tr><td>Auto Scaling and Self-Healing</td><td>Command Pattern </td><td>Encapsulates requests for scaling or healing actions as objects, enabling flexible execution.</td></tr><tr><td>Synthetic Monitoring </td><td>Template Method Pattern </td><td>Defines a skeleton of steps for simulating user interactions, with some steps customizable. </td></tr><tr><td>Service Mesh for Observability </td><td>Proxy Pattern </td><td>Acts as an intermediary to manage and observe service-to-service communication. </td></tr><tr><td>Capacity Planning and Load Testing</td><td>Decorator Pattern </td><td>Dynamically adds responsibilities (like different load scenarios) to objects. </td></tr><tr><td>Service Level Objectives and Indicators </td><td> Specification Pattern</td><td>Encapsulates business rules to check if performance metrics meet defined criteria.</td></tr></tbody></table>
