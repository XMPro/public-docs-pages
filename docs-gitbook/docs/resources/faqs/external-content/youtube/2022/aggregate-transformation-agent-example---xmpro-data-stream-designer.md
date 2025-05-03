# Aggregate Transformation Agent Example - XMPRO Data Stream Designer
{% embed url="https://www.youtube.com/watch?v=HFwbSJHkz0E" %}

Follow this step-by-step example to configure the Aggregate Transformation Agent in the XMPro Data Stream Designer.

Need help with creating your XMPRO Data Streams? Visit [https://documentation.xmpro.com](https://documentation.xmpro.com) or send an email to support@xmpro.com.

Visit [https://xmpro.com](https://xmpro.com) if you want to learn more about how you can build real-time applications with our No-Code Application Composition Platform.
<details>
<summary>Transcript</summary>this example demonstrates how to use the

aggregate agent to group by pump id and

find its average and maximum

temperatures in three second windows

first drag the agent onto the canvas

link the input to the streamed pump data

and output to the printer save the data

stream

and click on the agent to configure it

we'll group by pump id

add an aggregate for the average

temperature called temp average

and a second aggregate for the maximum

temperature

called temp max

set the windows unit to second and size

3

apply

save the data stream

publish it and let's look at the live

data view

the streamed events within the 3 second

window are grouped and a single event

for pump a is printed with the id and 2

aggregates

you can download the file below to try

it out yourself

and for more information about this

agent's properties head to the

configuration page thank you
</details>