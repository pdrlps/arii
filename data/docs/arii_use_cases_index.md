<aside class="large-3 columns" markdown="1" style="position:fixed;font-size:80%;">

##### Outline
{:.no_toc}

* TOC
{:toc}

</aside>

<!-- [TOC] for Python markdown parser -->

 <div class="large-9 columns" role="content"  markdown="1">

# User tracking

Sometimes your users just spend a few days without visiting your app and then they comeback... However, in some situations they just forget about your system completely. How about sending them a gentle email reminder when they haven't logged in for a month? _"We miss you!"_

ARiiP makes this easy! Just set up an agent to query your database for the users that haven't signed in in the last 30 days. Next, setup and endpoint to send your custom "come back" email. Create the integration connecting the agent and the endpoint. And that's it!

Every time a new user appears on the 30 day list, ARiiP kicks-off the integration and sends him an email. Simple.

# Enhanced database triggers

We all love database triggers. Chaining actions on our database to distribute data to multiple tables or to do more complex calculations. What if there was a simple engine to enhance these database triggers to perform actions outside your database?

With ARiiP just deploy as many agents and endpoints as you want, connecting data in your database with any external service. Send SMS messages when there's new content on a table, POST to a service your clients' updated data. Or do it the other way around: update your registry database when one of your developers creates a new issue on GitHub. The combinations are endless.

</div>


[agent]:              #agents
[agents]:             #agents
[client]:             #client
[Endpoint]:           #endpoints
[Endpoints]:          #endpoints
[gem]:                #gem
[Integration]:        #integrations
[Integrations]:       #integrations
[integration fields]: #integration-fields
[delivery]:           #deliveries
[deliveryendpoint]:   #endpoints
[deliveryendpoints]:  #endpoints
[delivery endpoint]:  #endpoints
[delivery endpoints]: #endpoints
[Detector]:           #detector
[Detectors]:          #detector
[event]:              #events
[events]:             #events
[Field Types]:        #field-types
[helpers]:            #helper-functions
[polling]:            #polling
[Postman]:            #postman
[postman]:            #postman
[push]:               #push
[source]:             #sources
[sources]:            #sources
[variables]:          #variables
