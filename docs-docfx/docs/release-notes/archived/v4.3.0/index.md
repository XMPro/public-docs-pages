# v4.3.0

### XMPro AI

| Change Type | Description |
|-------------|-------------|
| Feature | <p>This feature infuses the Digital Twin Platform with XMPro AI.</p><p>This introduces the [XMPro Notebook](../../../concepts/xmpro-ai/xmpro-notebook.md), which is an embedded version of [Jupyterhub](https://jupyter.org/hub) and will be available for evaluation on new XMPro Freemium accounts.</p><p>Existing customers and Freemium users can [contact us](https://xmpro.com/contact-us/) for access and licensing options. Please visit [XMPro AI](https://xmpro.com/xmpro-ai/) for more information about XMPro AI and XMPro's Intelligent Digital Twin Suite.</p> |

### App Designer

| Change Type | Description |
|-------------|-------------|
| Enhancement | The number format displayed in the [Data Grid](../../../blocks-toolbox/basic/data-grid.md#columns), [Tree Grid](../../../blocks-toolbox/basic/tree-grid.md), and [Pivot Grid](../../../blocks-toolbox/visualizations/pivot-grid.md) now supports the comma format, providing improved readability and ease of data interpretation. |
| Fix | An issue has been addressed where the [Score Matrix](../../../concepts/recommendation/recommendation-scoring.md#viewing-the-recommendation-scoring) did not open. |
| Fix | An issue where an "Encryption Key" error was displayed when updating the "Enable Audit trail" and "Landing Page for Desktop/Mobile" Application Designer settings has been resolved. |
| Fix | The [Recommendation Chart](../../../blocks-toolbox/recommendations/recommendation-chart.md) block included all recommendations when not configured.<br>*If it is not configured, it will now state "This control is not yet configured. Please use the block properties to configure it".* |
| Fix | The XMPro logo was displayed in the XMPro mobile app.<br>*The mobile app correctly displays the company logo configured in Subscription Manager.* |

### Data Stream Designer

| Change Type | Description |
|-------------|-------------|
| Fix | When navigating to the connectors page and selecting a connector's version, all previous versions of the selected connector were highlighted.<br>*The selected version is the only row highlighted and the Applications blade opens correctly.* |

### Subscription Manager

| Change Type | Description |
|-------------|-------------|
| Enhancement | The Subscription page now shows the [license](../../../administration/companies/manage-license.md#update-a-license) expiry date and the number of days remaining. Previously, the global or company admin would have to open each subscription to view the expiration date of a license. |

### Common

| Change Type | Description |
|-------------|-------------|
| Feature | [Logging](../../../installation/complete-installation/configure-logging-optional.md) provider support via Serilog, a diagnostic logging library, enhances system logging functionality to provide administrators with valuable insights into the behavior and performance of XMPro.<br><br>Three logging outputs are supported: [Logging to file](../../../installation/complete-installation/configure-logging-optional.md#logging-to-file) support has been added for all XMPro products, whereas [Application Insights](../../../installation/complete-installation/configure-logging-optional.md#application-insights) and [Datadog](../../../installation/complete-installation/configure-logging-optional.md#datadog) support has been added for all products aside from Subscription Manager. These are cloud-based application monitoring and analytics services. |
| Enhancement | Standard logging has been improved across all products with the addition of more contextual information. Users can now access important details such as CompanyId, CompanyName, UserId, Username, and more, enabling efficient issue investigation. |
| Enhancement | <p>We've changed the way our database installs and upgrades are applied. For new installs, our products will automatically install the required database changes. For upgrades, our products will detect what database changes are needed and make these.</p><p>We are moving away from doing database installs and upgrades from the desktop installer, with all database installs and upgrades happening automatically from within the products.</p><p>Accelerate time to value by choosing to automatically deploy the regular, smaller releases to your pre-prod environment, rather than less frequent, larger upgrades.</p> |
| Fix | SignalR displayed errors in the browser console.<br>*These errors have been rectified.* |
| Fix | An issue has been resolved where the on-premise installer failed to create an AWS package. |
| Fix | Access token vulnerabilities have been addressed.<br>*XMPro has masked logging of sensitive data like access_tokens used in SignalR connections to align with best practices.* |
| Fix | When assigning Run Access to XMPro Objects, selection changes were lost if you scrolled out of sight (further down) in the user list.<br>*Selections are retained through scrolling and saved as expected.* |
| Fix | The link in the Help Blades' "Release Notes" section did not direct users to the version number that matched the release version of XMPro when they tried to navigate to it.<br>*The link now directs the user to the documentation version number corresponding with the release version of XMPro.* |
