# Manage Rules

A Rule is a condition that helps the [Recommendation](../../concepts/recommendation/) determine whether [Recommendation Alerts](../../concepts/recommendation/recommendation-alert.md) should be created, and what created Alerts should look like. This is needed for you to create the condition(s) that the Recommendation needs to look for. An example of a Rule is "If the temperature is greater than 50". This catches any data that does not stay within the safe parameters.

{% hint style="info" %}
It is recommended that you read the articles listed below to improve your understanding of Recommendations.

* [Rule](../../concepts/recommendation/rule.md)
* [Manage Recommendations](manage-recommendations.md)
{% endhint %}

## Create Rules

To create a Rule, follow the steps below:

1. Select the Recommendation in the list that you want to add a Rule to.
2. Click the + button at the top-right of the Rules list.
3. Enter the _Rule Name._
4. Enter the _Alert Headline_ and _Alert Description._ If you wish for the values received from the Data Stream to be added to the Headline or Description of the Alerts this Rule will generate, add a tag with the @ symbol and select the Data Stream output.
5. Select the Rule Factor.
6. (Optional) Select an Optional Factor.
7. Select an _Alert Ranking_.
8. (Optional) Select an _Icon_. Sample icons can be found in the [Icon Library](../../resources/icon-library.md).
9. (Optional) Choose an Impact Metric.
10. Design the Rule Logic that decides when this Rule should generate a Recommendation Alert based on the data received from the Data Stream
11. (Optional) Enable Form and Choose a Form and Form Version
12. Add an _Additional Recommendation Management Column._ If you wish for the values entered into the Form to be added to the Additional Information column of the Alerts this Rule will generate, add a tag with the @ symbol and select a Field from the Form.
13. Choose a _Resolution_ value. If you want the Alerts generated to automatically resolve themselves if new data is received that doesn't match the Rule Logic, choose _Automatic._
14. Choose a _Recurrence_ value. If you want a new Alert to be generated every time data is received that matches the Rule Logic, choose _All Occurrences_.
15. Choose a _Log Data On_ value. If you want the Event Data of the Alert to be replaced every time data is received that matches the Rule Logic, choose _All Occurrences._
16. (Optional) Enable and enter _Triage Instructions_ to be followed in order to resolve the Alert.
17. (Optional) Enable and add _Resources_ to link in the Alert for help in resolving the Alert.

![](/docs/images/Recommendations - Manage Rules - Create Rule 1.png>)

![](/docs/images/Recommendations - Manage Rules - Create Rule 2.png>)

![](/docs/images/Recommendations - Manage Rules - Create Rule 3.png>)

## View Timeline

To view the timeline for a rule, follow the following steps:

1. Select Recommendation
2. Click More
3. Click Timeline
4. Select Rule

<figure><img src="/docs/images/Recommendations - Manage Recommendations - View Recommendation.png" alt=""><figcaption></figcaption></figure>

<figure><img src="/docs/images/Recommendations - Manage Rules - View Timeline 2.png" alt=""><figcaption></figcaption></figure>

<figure><img src="/docs/images/Recommendations - Manage Rules - View Timeline 3.png" alt=""><figcaption></figcaption></figure>

## Delete Rules

To delete existing Rule, follow the steps below:

1. Select the Recommendation in the list that you want to delete a Rule from.
2. Select the Rule.
3. Click the Delete button.
4. Confirm the action.

![](/docs/images/image (1310).png>)

{% hint style="info" %}
Deleting a Rule will not permanently delete it or any Recommendation Alerts generated by it. Deletion can be undone or made permanent from [Deleted Items](../../concepts/recommendation/deleted-items.md).
{% endhint %}

## Further Reading

* [How to Manage Notifications](manage-notifications.md)




