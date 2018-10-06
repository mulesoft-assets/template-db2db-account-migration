
# Anypoint Template: Database to Database Account Migration

# License Agreement
This template is subject to the conditions of the 
<a href="https://s3.amazonaws.com/templates-examples/AnypointTemplateLicense.pdf">MuleSoft License Agreement</a>.
Review the terms of the license before downloading and using this template. You can use this template for free 
with the Mule Enterprise Edition, CloudHub, or as a trial in Anypoint Studio.

# Use Case
I want to migrate a large set of accounts from one database to another.

This Template should serve as a foundation for the process of migrating accounts from Database A to Database B, it also provides the ability to specify the desired behavior with a filtering criteria when an account already exists in the Database B.

This Template leverages the [Batch Module](http://www.mulesoft.org/documentation/display/current/Batch+Processing).
The batch job is divided in *Process* and *On Complete* stages.
Migration process starts from fetching all the existing Accounts that match the filter criteria from Database A.
On *Process* stage will create / update the accounts in Database B. In addition, it performs a lookup and assigns Account Representatives using the zip code of the source Account.
Finally during the *On Complete* stage the Template will show statistics of the data transfer in the studio console and send out a notification email with the results of the batch execution.

# Considerations

**Note:** This particular Anypoint Template illustrates the migration use case between two Databases, thus it requires a Database instances to work.
The Anypoint Template comes packaged with a SQL script to create the DB table that it uses. 
It is the user responsibility to use the scripts to create the tables in an available schema and change the configuration accordingly.
The SQL script files can be found in [src/main/resources/](../master/src/main/resources/)

This template is customized for MySQL. To use it with different SQL implementation, some changes are necessary:

* update SQL script dialect to desired one
* replace MySQL driver library (or add another) dependency to desired one in [POM](pom.xml)
* update Database Config to suitable connection instead of `db:my-sql-connection` in global elements (config.xml)
* update connection configurations in `mule.*.properties` file

## DB Considerations

To get this template to work:

This template may use date time or timestamp fields from the database to do comparisons and take further actions.
While the template handles the time zone by sending all such fields in a neutral time zone, it cannot handle time offsets.
We define time offsets as the time difference that may surface between date time and timestamp fields from different systems due to a differences in the system's internal clock.
Take this in consideration and take the actions needed to avoid the time offset.

### As a Data Source

There are no considerations with using a database as a data origin.
### As a Data Destination

There are no considerations with using a database as a data destination.











# Run it!
Simple steps to get Database to Database Account Migration running.


## Running On Premises
In this section we help you run your template on your computer.


### Where to Download Anypoint Studio and the Mule Runtime
If you are a newcomer to Mule, here is where to get the tools.

+ [Download Anypoint Studio](https://www.mulesoft.com/platform/studio)
+ [Download Mule runtime](https://www.mulesoft.com/lp/dl/mule-esb-enterprise)


### Importing a Template into Studio
In Studio, click the Exchange X icon in the upper left of the taskbar, log in with your
Anypoint Platform credentials, search for the template, and click **Open**.


### Running on Studio
After you import your template into Anypoint Studio, follow these steps to run it:

+ Locate the properties file `mule.dev.properties`, in src/main/resources.
+ Complete all the properties required as per the examples in the "Properties to Configure" section.
+ Right click the template project folder.
+ Hover your mouse over `Run as`
+ Click `Mule Application (configure)`
+ Inside the dialog, select Environment and set the variable `mule.env` to the value `dev`
+ Click `Run`


### Running on Mule Standalone
Complete all properties in one of the property files, for example in mule.prod.properties and run your app with the corresponding environment variable. To follow the example, this is `mule.env=prod`. 
After this, to trigger the use case you just need to hit the local HTTP Listener Connector on the port you configured in your file. If this is for instance, `9090` then you should hit: `http://localhost:9090/migrateaccounts` and this will run the migration process and send the batch process statistics to the email addresses configured.

## Running on CloudHub
While creating your application on CloudHub (or you can do it later as a next step), go to Runtime Manager > Manage Application > Properties to set the environment variables listed in "Properties to Configure" as well as the **mule.env**.
Once your app is all set and started, supposing you choose `db2dbaccountmigration` as domain name to trigger the use case, you just need to hit `http://db2dbaccountmigration.cloudhub.io/migrateaccounts` and report will be sent to the emails configured.

### Deploying your Anypoint Template on CloudHub
Studio provides an easy way to deploy your template directly to CloudHub, for the specific steps to do so check this


## Properties to Configure
To use this template, configure properties (credentials, configurations, etc.) in the properties file or in CloudHub from Runtime Manager > Manage Application > Properties. The sections that follow list example values.
### Application Configuration
**HTTP Connector configuration**
+ http.port `9090`

**Batch Aggregator configuration**
+ page.size `1000`

**Database Connector configuration**
+ db.a.host `localhost`
+ db.a.port `3306`
+ db.a.user `user-nameA`
+ db.a.password `user-passwordA`
+ db.a.databasename `dbnameA`

**Database Connector configuration**
+ db.b.host `localhost`
+ db.b.port `3306`
+ db.b.user `user-nameB`
+ db.b.password `user-passwordB`
+ db.b.databasename `dbnameB`

**SMTP Services configuration**
+ smtp.host `smtp.gmail.com`
+ smtp.port `587`
+ smtp.user `email%40example.com`
+ smtp.password `password`

**E-mail Details**
+ mail.from `batch.migrateaccounts.migration%40mulesoft.com`
+ mail.to `your.email@gmail.com`
+ mail.subject `Batch Job Finished Report`

# API Calls
This section is not relevant for this use case.


# Customize It!
This brief guide intends to give a high level idea of how this template is built and how you can change it according to your needs.
As Mule applications are based on XML files, this page describes the XML files used with this template.

More files are available such as test classes and Mule application files, but to keep it simple, we focus on these XML files:

* config.xml
* businessLogic.xml
* endpoints.xml
* errorHandling.xml


## config.xml
Configuration for connectors and configuration properties are set in this file. Even change the configuration here, all parameters that can be modified are in properties file, which is the recommended place to make your changes. However if you want to do core changes to the logic, you need to modify this file.

In the Studio visual editor, the properties are on the *Global Element* tab.


## businessLogic.xml
Functional aspect of the Template is implemented in this XML, directed by one flow responsible of excecuting the logic.
This file contains a [Batch Job](http://www.mulesoft.org/documentation/display/current/Batch+Processing) which handles all the migration logic.



## endpoints.xml
This is the file where you can find the inbound and outbound sides of your integration app.
This Template has only an [HTTP Listener Connector](http://www.mulesoft.org/documentation/display/current/HTTP+Listener+Connector) as the way to trigger the use case.

### Inbound Flow
**HTTP Listener Connector** - Start Report Generation

+ `${http.port}` is set as a property to be defined either in a property file or in CloudHub environment variables.
+ The path configured by default is `migrateaccounts` and you are free to change it for the one you prefer.
+ The host name for all endpoints in your CloudHub configuration should be defined as `localhost`. CloudHub will then route requests from your application domain URL to the endpoint.

Flow *triggerFlow* executes a [Batch Job](http://www.mulesoft.org/documentation/display/current/Batch+Processing) defined in *businessLogic.xml*, which handles all the migration logic.
This flow has Exception Strategy that basically consists of invoking the *defaultChoiseExceptionStrategy* defined in *errorHandling.xml* file.



## errorHandling.xml
This is the right place to handle how your integration reacts depending on the different exceptions. 
This file provides error handling that is referenced by the main flow in the business logic.




