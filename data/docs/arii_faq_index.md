<aside class="large-4 columns" markdown="1" style="position:fixed;font-size:80%;">

### Outline
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

**ARiiP** relies on distributed inputs to monitor custom content changes. When new changes are detected, **ARiiP** generates a new [Event][] and triggers the execution of any number of [outputs][] associated with the starting [input][] (through integrations).

<hr>

# What are inputs?

[Inputs][] are intelligent algorithms that monitor configured data sources, detecting changes to their content. [Inputs][] can run on **ARiiP**'s' server or locally, in a truly distributed environment.

<hr>

# What are outputs?

[Outputs][] are used to define what to do with the data gathered by [inputs][]. This can go from updating a file in your Dropbox account to sending custom emails.

<hr>

# What are integrations?

Putting it simply, [Integrations][] connect [inputs][] with [outputs][]. Hence, [integrations][] are the logical bridge between the distributed monitored [sources][] and the actions triggered by content changes.
<hr>

</div>

[input]:        /ariip/docs/#inputs
[inputs]:       /ariip/docs/#inputs
[event]:        /ariip/docs/#events
[outputs]:      /ariip/docs/#outputs
[output]:       /ariip/docs/#outputs
[integrations]: /ariip/docs/#integrations
[integration]:  /ariip/docs/#integrations
[sources]:      /ariip/docs/#sources