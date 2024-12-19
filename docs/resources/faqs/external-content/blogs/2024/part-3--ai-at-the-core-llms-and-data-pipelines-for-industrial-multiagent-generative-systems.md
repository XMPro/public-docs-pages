
<article class="post-17239 post type-post status-publish format-standard has-post-thumbnail hentry category-articles-blog category-blog category-pieter-blog tag-agentic-ai" id="post-17239">
<div class="article-inner">
<header class="entry-header">
<div class="entry-header-text entry-header-text-top text-center">
<h6 class="entry-category is-xsmall"><a href="https://xmpro.com/category/blog/articles-blog/" rel="category tag">Articles</a>, <a href="https://xmpro.com/category/blog/" rel="category tag">Blog</a>, <a href="https://xmpro.com/category/blog/pieter-blog/" rel="category tag">CEO'S Blog</a></h6><h1 class="entry-title">Part 3 – AI at the Core: LLMs and Data Pipelines for Industrial Multi-Agent Generative Systems</h1><div class="entry-divider is-divider small"></div>
<div class="entry-meta uppercase is-xsmall">
<span class="posted-on">Posted on <a href="https://xmpro.com/part-3-ai-at-the-core-llms-and-data-pipelines-for-industrial-multi-agent-generative-systems/" rel="bookmark"><time class="entry-date published" datetime="2024-07-24T01:38:41+00:00">July 24, 2024</time></a></span> <span class="byline">by <span class="meta-author vcard"><a class="url fn n" href="https://xmpro.com/author/pietervs/">Pieter van Schalkwyk</a></span></span> </div>
</div>
</header>
<div class="entry-content single-page">
<div class="banner has-hover" id="banner-616135117">
<div class="banner-inner fill">
<div class="banner-bg fill">
<img height="583" src="https://xmpro.com/wp-content/uploads/2024/07/1721190831981-1024x585.png" width="1020"/>
 <div class="overlay"></div>
</div>
<div class="banner-layers container">
<div class="fill banner-link"></div>
<div class="text-box banner-layer x50 md-x50 lg-x50 y50 md-y50 lg-y50 res-text" id="text-box-1709050075">
<div class="text-box-content text dark">
<div class="text-inner text-center">
<div class="text" id="text-607674987">
<h1 class="reader-article-header__title" dir="ltr"><strong>Part 3 – AI at the Core: LLMs and Data Pipelines for Industrial Multi-Agent Generative Systems</strong></h1>
<style>
#text-607674987 {
  font-size: 0.75rem;
}
</style>
</div>
</div>
</div>
<style>
#text-box-1709050075 {
  width: 90%;
}
#text-box-1709050075 .text-box-content {
  font-size: 100%;
}
</style>
</div>
</div>
</div>
<style>
#banner-616135117 {
  padding-top: 500px;
}
#banner-616135117 .overlay {
  background-color: rgba(0, 57, 82, 0.599);
}
</style>
</div>
<div class="gap-element clearfix" id="gap-1952489523" style="display:block; height:auto;">
<style>
#gap-1952489523 {
  padding-top: 30px;
}
</style>
</div>
<h1 class="reader-article-header__title" dir="ltr"><strong>Part 3 – AI at the Core: LLMs and Data Pipelines for Industrial Multi-Agent Generative Systems</strong></h1>
<div class="gap-element clearfix" id="gap-1769017622" style="display:block; height:auto;">
<style>
#gap-1769017622 {
  padding-top: 30px;
}
</style>
</div>
<div class="icon-box testimonial-box icon-box-left text-left">
<div class="icon-box-img testimonial-image circle" style="width: 80px">
<img height="150" src="https://xmpro.com/wp-content/uploads/2022/03/Pieter-2019-Square-Web-150x150.jpeg" width="150"/>
 </div>
<div class="icon-box-text p-last-0">
<div class="testimonial-text line-height-small italic test_text first-reset last-reset is-italic">
<h3><strong>Pieter Van Schalkwyk</strong></h3>
<p><strong>CEO at XMPRO</strong>, Author – Building Industrial Digital Twins, DTC Ambassador, Co-chair for AI Joint Work Group at Digital Twin Consortium</p>
</div>
<div class="testimonial-meta pt-half">
<strong class="testimonial-name test_name"></strong>
<span class="testimonial-company test_company"></span>
</div>
</div>
</div>
<p>July 14, 2024 – Originallly posted on <a href="https://www.linkedin.com/pulse/part-3-ai-core-llms-data-pipelines-industrial-pieter-van-schalkwyk-1rdnc">Linkedin</a></p>
<p class="ember-view reader-text-block__paragraph" id="ember1483">In <a class="app-aware-link" data-test-app-aware-link="" href="https://xmpro.com/part-1-from-railroads-to-ai-the-evolution-of-game-changing-utilities/" rel="noopener" target="_self">Part 1</a>, “<strong>From Railroads to AI: The Evolution of Game-Changing Utilities,” </strong>I shared my thoughts on why GenAI will become a “utility” like electricity and why we have an opportunity to create “appliances” that will change the way we work and improve the quality of life for everyone.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1484">In <a class="app-aware-link" data-test-app-aware-link="" href="https://xmpro.com/part2-the-future-of-work-harnessing-generative-agents-in-manufacturing/" rel="noopener" target="_self">Part 2</a>, “<strong>The Future of Work: Harnessing Generative Agents in Manufacturing</strong>,” I explained that skills shortages and gaps, productivity challenges, and the complexity of doing business at the speed of thought is forcing us to look at alternate, novel ways to do work and have a  “Technology Enabling Focus” as <a class="ember-view" href="https://www.linkedin.com/in/michael-carroll-0106367/" id="ember1485">Michael Carroll</a> so accurately commented.</p>
<blockquote class="ember-view reader-text-block__blockquote" id="ember1486">
<p><em> Utilizing technology to foster focus instead of allowing it to become a distraction or creating additive sickness. This means avoiding constant alerts from dashboards and warnings from analytics that divert attention away from meaningful work – Mike Carroll</em></p>
</blockquote>
<p class="ember-view reader-text-block__paragraph" id="ember1487">As I was writing Part 3 on the architecture of Multi Agent Generative Systems (MAGS) with examples from applications with XMPro, I realized that I first have to explain <strong>“What”</strong> the reason is for using agents in the first place, that it is not just writing procedural code with some LLM capabilities baked in. So this became Part 3, with <a class="app-aware-link" data-test-app-aware-link="" href="https://xmpro.com/part-4-pioneering-progress-real-world-applications-of-multi-agent-generative-systems/" rel="noopener" target="_self">Part 4</a> following to show the architecture and <strong>“How”</strong> to build an XMPro MAGS agent team with some examples. I also decided to add Part 5, which will discuss governance, ethical use, trustworthiness, and some thoughts on managing change in organizations planning to use MAGS with the help of <a class="ember-view" href="https://www.linkedin.com/in/zorandmilosevic/" id="ember1488">Zoran Milosevic</a></p>
<p class="ember-view reader-text-block__paragraph" id="ember1489">Through parts 3 and 4, I explain XMPro MAGS using an Industrial Predictive Maintenance Agent Team and will explore the anatomy of this Reliability and Root Cause Agent as an example.</p>
<div class="reader-image-block reader-image-block--full-width">
<figure class="reader-image-block__figure">
<div class="ivm-image-view-model">
<div class="ivm-view-attr__img-wrapper"> </div>
</div>
</figure>
</div>
<div class="img has-hover x md-x lg-x y md-y lg-y" id="image_1693227598">
<div class="img-inner dark">
<img height="806" src="https://xmpro.com/wp-content/uploads/2024/07/1721191917497-1536x806.jpeg" width="1536"/>

</div>
<style>
#image_1693227598 {
  width: 100%;
}
</style>
</div>
<p><em><strong>Figure 1 – XMPro MAGS Reliability and Root Cause Agent in a Data Pipeline</strong></em></p>
<p class="ember-view reader-text-block__paragraph" id="ember1491">The following key topics will guide the discussion <strong>“Chain of Thought”</strong> in this paper:</p>
<ul>
<li><strong>Understanding Industrial Processes</strong>: What distinguishes industrial processes from others, and how do the agents within these systems operate differently?</li>
<li><strong>Employing LLM-based Agents</strong>: How can Large Language Models (LLMs) be utilized within industrial processes?</li>
<li><strong>Data Pipelines in Industrial Systems</strong>: Why are data pipelines crucial for assembling industrial MAGS?</li>
</ul>
<p class="ember-view reader-text-block__paragraph" id="ember1493">In part 4 “<strong>Pioneering Progress: Real-World Applications of Multi-Agent Generative Systems</strong>” I will continue and expand on:</p>
<ul>
<li><strong>Anatomy of MAGS</strong>: What are the structural and functional components of MAGS?</li>
<li><strong>Examples of XMPro MAGS Applications</strong>: What are some real-world applications of XMPro MAGS in industrial contexts?</li>
</ul>
<hr class="reader-divider-block__horizontal-rule"/>
<p class="ember-view reader-text-block__paragraph" id="ember1495">In my career, I’ve worked with both industrial and non-industrial operational business processes. Here is why I think industrial processes are different and why their agent teams are different.</p>
<h2 class="ember-view reader-text-block__heading-2" id="ember1496">Understanding the Uniqueness of Industrial Processes</h2>
<p class="ember-view reader-text-block__paragraph" id="ember1497">Operational processes in industrial settings markedly differ from typical business workflows found in non-industrial environments. The operational impact of industrial processes often results in safety issues or significant loss, and decisions are made on real-time operations intelligence through SCADA, IoT, Digital Twins, and other operational technology applications.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1498">Traditional business processes are mostly <strong>deterministic</strong>, designed to follow a predetermined workflow that ensures consistency and efficiency. Such processes execute tasks based on “If-then-else” logic, where every step is predefined and structured to enable consistent performance, even by the least skilled personnel. This model is great for Robotic Process Automation (RPA), where tasks are clearly defined, and outcomes are predictable.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1499">In the image below, I asked Claude to create a Mermaid diagram of the agent process that typical GenAI Agent frameworks like CrewAI, Autogen, and LangChain follow:</p>
<div class="row align-center" id="row-417647502">
<div class="col medium-6 small-12 large-6" id="col-1445506255">
<div class="col-inner text-center">
<div class="img has-hover x md-x lg-x y md-y lg-y" id="image_1999982660">
<div class="img-inner dark">
<img height="616" src="https://xmpro.com/wp-content/uploads/2024/07/1721191965711.png" width="330"/>

</div>
<style>
#image_1999982660 {
  width: 82%;
}
</style>
</div>
<p><em><strong>Figure 2 – Typical Task-based LLM Agent</strong></em></p>
</div>
</div>
</div>
<p class="ember-view reader-text-block__paragraph" id="ember1501">These GenAI Agent frameworks are tailored to support defined workflow tasks by generating content, curating, and reviewing within these deterministic processes. These frameworks enhance efficiency by automating routine content generation and curation processes governed by set rules and procedures. <em>Creating the Mermaid diagram is an example of a typical deterministic content generation task that I can assign to one of these agents to improve my efficiency.</em></p>
<h3 class="ember-view reader-text-block__heading-3" id="ember1502">“The Decision is the Task” for Many Industrial Processes</h3>
<p class="ember-view reader-text-block__paragraph" id="ember1503">In contrast, operational business processes in industrial applications rely on dynamic and complex data inputs. They generally use real-time operational and sensor data that frequently changes, requiring integrating this data with recent contextual information. This information is synthesized and presented to Subject Matter Experts (SMEs) such as Operations Managers, Reliability Engineers, or Quality Supervisors.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1504">These subject matter experts use detailed data, combined with their skills and available documentation, to make informed decisions. It is most often presented in a dashboard to provide the information and context. Their decision-making further involves causal analysis to determine why (<em>Knowing What Causes What, and When – more on this in the future</em>) before taking any action.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1505">We describe these as <strong>Emergent Processes</strong>, where the next best steps emerge based on the SME’s ability to observe, reflect, plan, and determine actionable options, making these processes fundamentally adaptive and responsive to the changing environment.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1506">MAGS is an example of a GenAI Agent framework that <strong><em>mimics these SME actions</em></strong>. It supports emergent, non-deterministic processes that must handle far more complex and dynamic decision-making than its deterministic counterparts.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1507">MAGS’ primary focus is to use advanced reasoning processes to recommend actions, and in fully automated industrial environments, potentially execute these actions directly. In such scenarios, the SME assumes a critical oversight role as the <strong><em>‘Human On The Loop’</em></strong>, ensuring that the automated actions align with strategic objectives and operational safety standards.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1508">This shift emphasizes the framework’s ability to operate independently while still under expert governance, enhancing efficiency without compromising control or quality.</p>
<h2 class="ember-view reader-text-block__heading-2" id="ember1509">What is MAGS?</h2>
<p class="ember-view reader-text-block__paragraph" id="ember1510">Multi Agent Generative Systems (MAGS) are systems that <em>consist of multiple agents, each with a defined role, working together to deconstruct and solve complex problems. These systems mimic the hierarchical structure of enterprises and mirror real-world team dynamics. </em>They can also scale intelligently by adding more agents to handle increased workloads.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1511">Each agent in the system <em>handles modular decision-making steps</em>that contribute to the overall problem-solving process in a composable way. The agents can further collaborate and cooperate to achieve defined goals without human intervention.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1512">Inspired by this <strong><em>foundational research</em></strong> at Stanford, <a class="app-aware-link" data-test-app-aware-link="" href="https://arxiv.org/pdf/2304.03442" rel="noopener" target="_self"><em>Generative Agents: Interactive Simulacra of Human Behavior</em></a>, XMPro MAGS enables a collaborative environment where multiple agents share insights, learn from each other, and make more informed and contextually relevant decisions. XMPro MAGS has the ability to observe, reflect, memorize, learn, plan, and act using LLMs to simulate the same behavior human SMEs use to make operational decisions.</p>
<h2 class="ember-view reader-text-block__heading-2" id="ember1513">From Coding to Commanding: Leveraging LLMs for Enhanced Decision-Making in Industrial Applications</h2>
<p class="ember-view reader-text-block__paragraph" id="ember1514">A <strong><em>common application</em></strong> for existing GenAI Agents, including platforms like CrewAI, Autogen, and LangChain, is <strong><em>optimizing the software development process.</em></strong> These GenAI agents enhance efficiency by specializing in distinct roles within the project workflow.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1515">Project Manager Agents break projects into manageable subtasks, Coding Agents handle the actual development of software, Testing Agents are responsible for quality assurance, and Documentation Agents create comprehensive user guides. This specialization streamlines the entire development process, from conception to completion, ensuring each phase meets high standards of quality and efficiency.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1516">Here, large language models primarily automate tasks like coding and testing, focusing on individual steps without integrating them into broader decision-making processes.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1517">Conversely, Multi-Agent Generative Systems (MAGS) use LLMs for <strong><em>complex decision-making </em></strong>in industrial settings.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1518">For example, an Expert OEE MAGS, which is explained in more detail later, actively improves manufacturing efficiency by deploying specialized AI agents focusing on availability, performance, quality monitoring, and predictive maintenance. These agents can reason and decide on actions based on their observations, reflections, memory, and planning, as shown in Figure 3. They dynamically optimize operations and adapt to evolving industrial challenges by continuously analyzing real-time data.</p>
<div class="img has-hover x md-x lg-x y md-y lg-y" id="image_1210579130">
<div class="img-inner dark">
<img height="707" src="https://xmpro.com/wp-content/uploads/2024/07/1721192042079-1536x707.jpeg" width="1536"/>

</div>
<style>
#image_1210579130 {
  width: 100%;
}
</style>
</div>
<div class="text" id="text-485197174">
<div class="reader-image-block reader-image-block--full-width"><em><strong>Figure 3 – XMPro MAGS Agent Observe, Reflect, Plan, Act</strong></em></div>
<style>
#text-485197174 {
  text-align: center;
}
</style>
</div>
<div class="gap-element clearfix" id="gap-51741446" style="display:block; height:auto;">
<style>
#gap-51741446 {
  padding-top: 30px;
}
</style>
</div>
<p class="ember-view reader-text-block__paragraph" id="ember1520">In systems like the Expert OEE Optimizer, MAGS monitors equipment performance, analyzes data to uncover patterns, devises optimization strategies, and executes these plans, significantly impacting operational outcomes. The primary value of LLMs in MAGS lies not just in performing tasks, but in driving sophisticated reasoning processes that enhance decision-making and operational efficiency.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1521">This contrast <strong><em>highlights significant differences in LLM utilization</em></strong>:</p>
<ul>
<li><strong>Task vs. Decision-Making Focus</strong>: In typical non-industrial GenAI agent applications, LLMs enhance task execution. In industrial settings, they support a cycle of observation, reflection, planning, and action, directly influencing strategic, tactical, and operational decisions.</li>
<li><strong>Integration and Impact</strong>: Non-industrial LLM GenAI agent integration is often compartmentalized, focusing on specific tasks. Industrial LLMs work holistically, with agents interacting and adapting based on collective insights, boosting system intelligence and responsiveness.</li>
<li><strong>Scope of Automation</strong>: While non-industrial automation targets reducing manual labor in routine tasks (like me drawing the Mermaid diagram), industrial automation through MAGS aims to optimize entire processes, employing GenAI to create effective decision intelligence.</li>
</ul>
<p class="ember-view reader-text-block__paragraph" id="ember1523">Another key distinction between traditional GenAI Agent frameworks for task-based processes and Multi-Agent Generative Systems (MAGS) lies in their development and deployment methodologies. Task-oriented agent frameworks typically <strong><em>employ a procedural, coded approach</em></strong> that defines LLM content tasks and sequences.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1524">In contrast, MAGS, particularly those developed with XMPro, favor a <strong><em>visual data pipeline approach.</em></strong> This method enables an agile and flexible composition of work teams and agents, enabling more dynamic interaction and rapid adaptation to changing conditions in the operational environment.</p>
<h2 class="ember-view reader-text-block__heading-2" id="ember1525">Why Data Pipelines are Superior to Traditional Procedural Approaches in MAGS</h2>
<p class="ember-view reader-text-block__paragraph" id="ember1526">Traditional task-based Generative AI (GenAI) agents primarily employ procedural coding to execute predefined tasks in a sequence defined by a controller or “supervisor,” as shown in the Mermaid flow diagram in Figure 2. Some platforms assign the “CEO” role to the orchestration functions.  While effective for straightforward content generation and curation tasks, this approach struggles in dynamic and complex decision-making applications typical of industrial settings.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1527">In contrast, data pipelines or data streams offer a transformative approach to building MAGS. Unlike procedural coding, data pipelines utilize a fluid, dynamic method that allows for continuous data integration. This integration ensures decisions are based on the most up-to-date and relevant information, which is critical in fast-paced industrial environments. The flexibility of data pipelines allows for modular changes with minimal disruption to the overall system, facilitating easier adaptation to evolving requirements and conditions.</p>
<div class="img has-hover x md-x lg-x y md-y lg-y" id="image_1124990309">
<div class="img-inner dark">
<img height="666" src="https://xmpro.com/wp-content/uploads/2024/07/1721192083008-1536x666.jpeg" width="1536"/>

</div>
<style>
#image_1124990309 {
  width: 100%;
}
</style>
</div>
<div class="text" id="text-3631565592">
<div class="reader-image-block reader-image-block--full-width">
<figure class="reader-image-block__figure"><figcaption class="reader-image-block__figure-image-caption display-block full-width text-body-small-open t-sans text-align-center t-black--light"><em><strong>Figure 4 – Example of a typical Data Pipeline Approach in XMPro</strong></em></figcaption></figure>
</div>
<style>
#text-3631565592 {
  text-align: center;
}
</style>
</div>
<div class="gap-element clearfix" id="gap-1988218177" style="display:block; height:auto;">
<style>
#gap-1988218177 {
  padding-top: 30px;
}
</style>
</div>
<p class="ember-view reader-text-block__paragraph" id="ember1530">The real power of using data pipelines in MAGS centers on their <strong>ability to effectively employ LLMs for complex reasoning and decision-making.</strong> Rather than just automating tasks, LLMs in these pipelines can observe data and patterns, reflect, learn, plan, act, and collaborate within a governance framework or <strong><em>“Rules of Engagement”</em></strong>.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1531">This capability significantly<strong> improves decision-making</strong> by allowing the integration of diverse data sources and tools to contextualize decision data. It facilitates the incorporation of physics-based, statistical, and traditional AI models, anchoring MAGS in practical and empirical reality. This approach ensures that decisions are data-driven and realistically applicable, grounded in physics and reality, greatly enhancing the system’s reliability and effectiveness.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1532">Furthermore, the <strong>use of visual, drag-and-drop interfaces</strong> in constructing data pipelines offers substantial advantages in terms of <strong>usability and explainability.</strong> These interfaces allow users to visually map out and modify data flows, <strong><em>making the system’s operations transparent and comprehensible even to those without deep technical expertise</em></strong>. This visual aspect not only simplifies the monitoring and debugging processes but also helps maintain organizational governance.</p>
<p class="ember-view reader-text-block__paragraph" id="ember1533">By implementing data pipelines, organizations can build MAGS that are not only more efficient and adaptive <strong><em>but also easier to manage and scale</em></strong>. The visual building tools and <strong><em>modular, composable design of data pipelines reduce development time and increase consistency across different applications. The ability to visually represent and explain the decision-making process further enhances the value of MAGS, providing clarity and insight into how decisions are derived, which is invaluable for continuous improvement and alignment with business objectives.</em></strong></p>
<p class="ember-view reader-text-block__paragraph" id="ember1534">While traditional GenAI agents are constrained by the limitations of procedural coding, data pipelines provide a robust framework for developing advanced MAGS. This framework <em>supports dynamic data integration, sophisticated reasoning capabilities, and a visual, modular approach to system design, making it ideally suited to the complexities and demands of industrial applications.</em></p>
<p class="ember-view reader-text-block__paragraph" id="ember1535">In part 4, “<a class="app-aware-link" data-test-app-aware-link="" href="https://xmpro.com/part-4-pioneering-progress-real-world-applications-of-multi-agent-generative-systems/" rel="noopener" target="_self"><strong>Pioneering Progress: Real-World Applications of Multi-Agent Generative Systems</strong></a>,”  I continue and show the anatomy of an XMPro MAGS agent team that is built and deployed on this data pipeline and use two examples to demonstrate the capabilities of these agent applications.</p>
<div class="img has-hover x md-x lg-x y md-y lg-y" id="image_410781593">
<div class="img-inner dark">
<img height="802" src="https://xmpro.com/wp-content/uploads/2024/07/1721196628356-1536x802.jpeg" width="1536"/>

</div>
<style>
#image_410781593 {
  width: 100%;
}
</style>
</div>
<div class="reader-image-block reader-image-block--full-width" style="text-align: center;">
<figure class="reader-image-block__figure"><figcaption class="reader-image-block__figure-image-caption display-block full-width text-body-small-open t-sans text-align-center t-black--light"><em><strong>Figure 5 – Example of an XMPro MAGS Agent that will be explored in Part 4</strong></em></figcaption></figure>
</div>
<p class="ember-view reader-text-block__paragraph" id="ember1539"><strong>If this excites you and you want to be part of the next evolution in industrial applications, please reach out to me or </strong><a class="ember-view" href="https://www.linkedin.com/in/greengavin/" id="ember1540">Gavin Green</a> <strong>, VP Strategic Solutions.</strong></p>
<p class="ember-view reader-text-block__paragraph" id="ember1541"><strong>We are opening limited pilot opportunities for innovative, agile leaders in the industry.</strong></p>
<div class="blog-share text-center"><div class="is-divider medium"></div><div class="social-icons share-icons share-row relative"><a aria-label="Share on WhatsApp" class="icon button circle is-outline tooltip whatsapp show-for-medium" data-action="share/whatsapp/share" href="whatsapp://send?text=Part%203%20%26%238211%3B%20AI%20at%20the%20Core%3A%20LLMs%20and%20Data%20Pipelines%20for%20Industrial%20Multi-Agent%20Generative%20Systems - https://xmpro.com/part-3-ai-at-the-core-llms-and-data-pipelines-for-industrial-multi-agent-generative-systems/" title="Share on WhatsApp"><i class="icon-whatsapp"></i></a><a aria-label="Share on Facebook" class="icon button circle is-outline tooltip facebook" data-label="Facebook" href="https://www.facebook.com/sharer.php?u=https://xmpro.com/part-3-ai-at-the-core-llms-and-data-pipelines-for-industrial-multi-agent-generative-systems/" onclick="window.open(this.href,this.title,'width=500,height=500,top=300px,left=300px'); return false;" rel="noopener nofollow" target="_blank" title="Share on Facebook"><i class="icon-facebook"></i></a><a aria-label="Share on Twitter" class="icon button circle is-outline tooltip twitter" href="https://twitter.com/share?url=https://xmpro.com/part-3-ai-at-the-core-llms-and-data-pipelines-for-industrial-multi-agent-generative-systems/" onclick="window.open(this.href,this.title,'width=500,height=500,top=300px,left=300px'); return false;" rel="noopener nofollow" target="_blank" title="Share on Twitter"><i class="icon-twitter"></i></a><a aria-label="Email to a Friend" class="icon button circle is-outline tooltip email" href="/cdn-cgi/l/email-protection#99a6eaecfbf3fcfaeda4c9f8ebedbcaba9aabcaba9bcabafbcabaaa1aba8a8bcaadbbcaba9d8d0bcaba9f8edbcaba9edf1fcbcaba9daf6ebfcbcaad8bcaba9d5d5d4eabcaba9f8f7fdbcaba9ddf8edf8bcaba9c9f0e9fcf5f0f7fceabcaba9fff6ebbcaba9d0f7fdeceaedebf0f8f5bcaba9d4ecf5edf0b4d8fefcf7edbcaba9defcf7fcebf8edf0effcbcaba9cae0eaedfcf4eabffbf6fde0a4daf1fcfaf2bcaba9edf1f0eabcaba9f6ecedbcaad8bcaba9f1edede9eabcaad8bcabdfbcabdfe1f4e9ebf6b7faf6f4bcabdfe9f8ebedb4aab4f8f0b4f8edb4edf1fcb4faf6ebfcb4f5f5f4eab4f8f7fdb4fdf8edf8b4e9f0e9fcf5f0f7fceab4fff6ebb4f0f7fdeceaedebf0f8f5b4f4ecf5edf0b4f8fefcf7edb4fefcf7fcebf8edf0effcb4eae0eaedfcf4eabcabdf" rel="nofollow" title="Email to a Friend"><i class="icon-envelop"></i></a><a aria-label="Pin on Pinterest" class="icon button circle is-outline tooltip pinterest" href="https://pinterest.com/pin/create/button?url=https://xmpro.com/part-3-ai-at-the-core-llms-and-data-pipelines-for-industrial-multi-agent-generative-systems/&amp;media=https://xmpro.com/wp-content/uploads/2024/07/1721190831981-1024x585.png&amp;description=Part%203%20%26%238211%3B%20AI%20at%20the%20Core%3A%20LLMs%20and%20Data%20Pipelines%20for%20Industrial%20Multi-Agent%20Generative%20Systems" onclick="window.open(this.href,this.title,'width=500,height=500,top=300px,left=300px'); return false;" rel="noopener nofollow" target="_blank" title="Pin on Pinterest"><i class="icon-pinterest"></i></a><a aria-label="Share on LinkedIn" class="icon button circle is-outline tooltip linkedin" href="https://www.linkedin.com/shareArticle?mini=true&amp;url=https://xmpro.com/part-3-ai-at-the-core-llms-and-data-pipelines-for-industrial-multi-agent-generative-systems/&amp;title=Part%203%20%26%238211%3B%20AI%20at%20the%20Core%3A%20LLMs%20and%20Data%20Pipelines%20for%20Industrial%20Multi-Agent%20Generative%20Systems" onclick="window.open(this.href,this.title,'width=500,height=500,top=300px,left=300px'); return false;" rel="noopener nofollow" target="_blank" title="Share on LinkedIn"><i class="icon-linkedin"></i></a></div></div></div>
<nav class="navigation-post" id="nav-below" role="navigation">
<div class="flex-row next-prev-nav bt bb">
<div class="flex-col flex-grow nav-prev text-left">

</div>

</div>
</nav>
</div>
</article>
<div class="comments-area" id="comments">
</div>
