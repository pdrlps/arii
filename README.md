# ARiiP

**[ARiiP](http://ariip.com/): integrate everything**

**ARiiP** is a barebones framework for deploying custom automated, real-time, data integration & interoperability platforms.

## Setup

**Note**: The full **ARiiP** experience requires two additional components. [Redis](http://redis.io) and [Sentry](http://getsentry.com). Redis is used to improve the content change detection cache performance, and Sentry is used to capture miscellaneous events during execution.  Both of these tools can be freely downloaded and deployed.

1. Clone or download **ARiiP** code from GitHub

2. Configure your database, services, mail, Redis and Sentry settings

        config/database.yml
        config/application.yml # copy from config/application.sample.yml

3. Run Rails *bundler* (watch out for *gem* install errors)

        bundle install

4. Create and load database

        rake db:create
        rake db:migrate

5. Run on *rails*

        rails s

6. Initiate the tasks (on a distinct shell, check *delayed_job* documentation)

        rake jobs:work

        # daemon solution
        RAILS_ENV=production ruby bin/delayed_job start -n 3



## Changelog

2015-01-14
* Reload as ARiiP