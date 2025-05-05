# Use Data Sources in the Page

Once a Data Source has been added to a Page, it can be used on a number of Blocks. Data Sources can be bound to certain Blocks that allow you to store data or display data, such as a data grid. These can be used if you want to display data in a grid view to the user, or if you want the user to enter some details and have it stored directly into the connected Data Source, such as an SQL Server Database.

{% hint style="info" %}
It is recommended that you read the article listed below to improve your understanding of Data Integration.

* [Data Integration](../../concepts/application/data-integration.md)
* [How to Manage Data Sources](manage-data-sources.md)
{% endhint %}

## Adding a Data Source to a page

To add a Data Source onto the Page of an Application, follow the steps below:

1. Open the Editor for the Application.

![](/docs/images/image (835).png>)

&#x20;   2\. Drag a Block that can display data, such as a Data Grid.

![](/docs/images/image (399).png>)

&#x20;   3\. Highlight the Block that you want to bind the Data Source to.\
&#x20;   4\. Select _Block Properties_.\
&#x20;   5\. Select a Data Source from the list.\
&#x20;   6\. Click on _Save_.

![](/docs/images/image (977).png>)

The block highlight color will change to yellow to show it has a Data Source. Click on _Launch_ to launch the Application and view the data.

![](/docs/images/_4.png)

{% hint style="info" %}
If the Data Source is properly configured, the data will display and can be visible when the app is launched.
{% endhint %}

![](/docs/images/_5.png)

## Filtering records from a Data Source

To filter and limit the number of records the Data Source displays, follow the steps below:

1. Open the Editor for the Application.

![](/docs/images/image (1594).png>)

&#x20;   2\. Highlight the block of the Data Source you want to filter.\
&#x20;   3\. Click on the _edit_ button to Filter.

![](/docs/images/_7.png)

&#x20;   4\. Add a filtering condition or group.

![](/docs/images/_8.png)

&#x20;   5\. Click on _Apply_.\
&#x20;   6\. Click on _Save_.

![](/docs/images/_9.png)

## Sorting records from a Data Source

To sort the records the Data Source displays, follow the steps below:

1. Open the Editor for the Application.

![](/docs/images/image (447).png>)

&#x20;   2\. Highlight the block of the Data Source you want to sort.\
&#x20;   3\. Click on the _plus_ button to add a new field to sort by.

![](/docs/images/_11.png)

&#x20;   4\. Sort the field in ascending or descending order.\
&#x20;   5\. Click on _Save_.

![](/docs/images/_12.png)

## Showing specific records from a Data Source

### Show # of Results

To show a limited number of the records the Data Source displays, follow the steps below:

1. Highlight the block of the Data Source.
2. Click on _Block Properties_.
3. Show the number of results.
4. Click on _Save_.

![](/docs/images/_13.png)

### Skip # of Results

To skip certain rows, follow the steps below:

1. Highlight the block of the Data Source.
2. Click on _Block Properties_.
3. Skip a number of results.
4. Click on _Save_.

![](/docs/images/_14.png)

## Show Default Row

To change the settings for the default row, follow the steps below:

1. Highlight the block of the Data Source.
2. Click on _Block Properties_.
3. Change the default row.
4. Click on _Save_.

![](/docs/images/_15.png)



