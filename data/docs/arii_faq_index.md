<aside class="large-4 columns" markdown="1" style="position:fixed;font-size:80%;">

##### Outline
{:.no_toc}

* TOC
{:toc}

</aside>

<!-- [TOC] for Python markdown parser -->

 <div class="large-8 columns" role="content"  markdown="1">

# What is ARiiP?

**ARiiP** is a data integration framework, targeting the automated real-time integration of data from heterogeneous resources to multiple destinations. **ARiiP** provides pure Integration-as-a-Service, acting as an _intelligent ETL proxy_ between distinct services.

<hr>

# How does ARiiP work?

**ARiiP** relies on distributed agents to monitor custom content changes. When new changes are detected, **ARiiP** generates a new [Event][] and triggers the execution of any number of [endpoints][] associated with the starting [agent][] (through integrations).

<hr>

# What are agents?

[Agents][] are intelligent algorithms that monitor configured data sources, detecting changes to their content. [Agents][] can run on **ARiiP**'s' server or locally, in a truly distributed environment.

<hr>

# What are endpoints?

[Endpoints][] are used to define what to do with the data gathered by [agents][]. This can go from updating a file in your Dropbox account to sending custom emails.

<hr>

# What are integrations?

Putting it simply, [Integrations][] connect [agents][] with [endpoints][]. Hence, [integrations][] are the logical bridge between the distributed monitored [sources][] and the actions triggered by content changes.
<hr>

</div>

[agent]:        /ariip/docs/#agents
[agents]:       /ariip/docs/#agents
[event]:        /ariip/docs/#events
[endpoints]:    /ariip/docs/#endpoints
[endpoint]:     /ariip/docs/#endpoints
[integrations]: /ariip/docs/#integrations
[integration]:  /ariip/docs/#integrations
[sources]:      /ariip/docs/#sources