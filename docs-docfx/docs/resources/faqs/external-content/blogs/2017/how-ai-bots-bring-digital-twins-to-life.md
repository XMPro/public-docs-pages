# How AI Bots Bring Digital Twins to Life

[**Blog**](https://xmpro.com/category/blog/)**,** [**CEO'S Blog**](https://xmpro.com/category/blog/pieter-blog/)

## How AI Bots Bring Digital Twins to Life

Posted on [March 1, 2017](https://xmpro.com/ai-bots-bring-digital-twins-life/) by [Pieter van Schalkwyk](https://xmpro.com/author/pietervs/)

<figure><img src="https://xmpro.com/wp-content/uploads/2017/03/BlogImage.png" alt="" height="305" width="660"><figcaption></figcaption></figure>

Industry 3.0 was characterized by factory automation where manufacturing robots replaced humans to do repetitive, manual tasks at a much higher productivity rate, doing it safer, for longer shifts and more importantly with highly predictable production and quality outcomes.

Industry 4.0 adoption is racing ahead faster than expected and brings with it the promise of smart factories where machines are interconnected and publish and subscribe to information from other machines. The Industrial Internet of Things (IIoT) brings classic factory automation through Operational Technology (OT) into the World Wide Web world of IT. It exposes industrial sensing and control equipment to internet protocols such as https and MQTT. Machines can now talk a universal language instead of their historical and proprietary past.

Information about these smart machines can now be captured and stored in a new master data management system or what IIoT calls [Digital Twins](https://xmpro.com/digital-twins-the-ultimate-guide/). We now have a digital representation of the physical world. Just like Master Data Management, Digital Twins provide context about the machine, its operational information and potentially its health and likelihood to fail.

Most IIoT solutions focus on turning machine-born big data into smart data through analytics. Engineers can then create dashboards and reporting solutions to gain some business intelligence around these machines and how they operate.

How about letting a machine talk to you, explain its operational conditions, challenges and tell you when it is not feeling well and what the symptoms are? This is not a futuristic vision, but something that is possible and done by some of the best in class organizations in the world right now.

Imagine a machine sending you a Skype or Slack message and then engaging in a conversation with you.



Software robots are deployed across multiple industries to run help desks, provide customer support and do repetitive configuration and scripting tasks. Your bank or telco’s online support chat function is likely a “bot” that has been trained to assist you with 95% of common support questions. It continuously trains and new bots have cognitive capability that allows it to learn on its own. Subject matter experts (SMEs) are used to train these bots and they use machine learning in the background to make sense of large data sets that we as humans cannot process. Some bots can read incoming invoices attached to an email and enter the details into the AP module of the ERP, while sending the supplier an acknowledgment of receipt email.

The same bots can be used to give your machine, or their Digital Twins at least, a voice. Rockwell Automation recently announced Shelby, the Siri of the M2M world which is built on the Microsoft Cortana Analytics suite. Microsoft released its [bot framework](https://dev.botframework.com/) that enables developers to create and deploy these bots. I created my own bot on Skype that can chat to me.  QED (quite easily done).

The real challenge comes in on how to make these bots context aware (which machine’s voice are they?) and bring them into the day-to-day operational processes in an organization. The Digital Twin repository brings a vast amount of data about an asset, machine or “thing” and IoT analytics makes it possible.

The challenge lies in the practical implementation of these bots in IoT enabled operational processes. Creating smart bots is one thing (and becoming easier by the day) but baking them into the operational processes of a manufacturing plant, a mine or an oil well is more challenging.

XMPro’s visual, model-driven way of creating new IoT process apps provides a mechanism to have these intelligent bots as “action agents” instead of just sending an email, SMS, or create a simple task. The XMPro “context providers” in our visual event streams provide rich data to feed the bot with the information it needs to run diagnostics, predict failure and communicate possible next best actions to take. XMPro’s Action Agents provides an ideal platform to introduce bots that take action.

**Here is an example of a bot calling me up on Skype:**



This is an example of how a bot could interact with a user and it is initiated in XMPro by the following event flow:

_Real-time temperature and vibration data is read from IoT devices or a historian application like OSIsoft and is combined with information from SAP AIN (Asset Intelligence Network), for example, to provide context for a failure prediction model. In this example, we first predict if it is going to fail and if it returns a positive result we run another model that will predict the remaining useful life. It also checks the EAM (Enterprise Asset Management) system for any open maintenance orders. If no order exists it creates one in the ERP system and at the same time it starts the interactive discussion in the Skype example._ ([Contact us](https://xmpro.com/contact-us/) if you want a demonstration of our IoT Application Suite to see how to easily create these event streams)



Right now, robotic processes or “bots” are not associated with IoT, but at XMPro we see this as one of the most influential aspects of IoT in the future. It will become as important on the process end as data aggregation from sensors are on the front end.

These bots have the capacity to process vast amounts of data and bring machines to life through the voice of their digital twin. Integrating this with augmented reality will not only bring a voice, but potentially a face, to digital twins. Assistive technologies like Siri and Cortana are becoming part of our everyday life and changing the way we interact with our mobile smart devices. Future generations of IoT users will expect the same level of interaction and built in intelligence in the way they interact with machines.




