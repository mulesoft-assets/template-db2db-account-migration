
# Anypoint Template: Database to Database Account Migration

+ [License Agreement](#licenseagreement)
+ [Use Case](#usecase)
+ [Considerations](#considerations)
	* [DB Considerations](#dbconsiderations)
+ [Run it!](#runit)
	* [Running on premise](#runonopremise)
	* [Running on Studio](#runonstudio)
	* [Running on Mule ESB stand alone](#runonmuleesbstandalone)
	* [Running on CloudHub](#runoncloudhub)
	* [Deploying your Anypoint Template on CloudHub](#deployingyouranypointtemplateoncloudhub)
	* [Properties to be configured (With examples)](#propertiestobeconfigured)
+ [API Calls](#apicalls)
+ [Customize It!](#customizeit)
	* [config.xml](#configxml)
	* [businessLogic.xml](#businesslogicxml)
	* [endpoints.xml](#endpointsxml)
	* [errorHandling.xml](#errorhandlingxml)


# License Agreement <a name="licenseagreement"/>
Note that using this template is subject to the conditions of this [License Agreement](AnypointTemplateLicense.pdf).
Please review the terms of the license before downloading and using this template. In short, you are allowed to use the template for free with Mule ESB Enterprise Edition, CloudHub, or as a trial in Anypoint Studio.

# Use Case <a name="usecase"/>
I want to migrate a large set of accounts from one database to another.

This Template should serve as a foundation for the process of migrating accounts from Database A to Database B, it also provides the ability to specify the desired behavior with a filtering criteria when an account already exists in the Database B.

This Template leverages the [Batch Module](http://www.mulesoft.org/documentation/display/current/Batch+Processing).
The batch job is divided in *Process* and *On Complete* stages.
Migration process starts from fetching all the existing Accounts that match the filter criteria from Database A.
On *Process* stage will create / update the accounts in Database B. In addition, it performs a lookup and assigns Account Representatives using the zip code of the source Account.
Finally during the *On Complete* stage the Template will show statistics of the data transfer in the studio console and send out a notification email with the results of the batch execution.

# Considerations <a name="considerations"/>

**Note:** This particular Anypoint Template illustrates the migration use case between two Databases, thus it requires a Database instances to work.
The Anypoint Template comes packaged with a SQL script to create the DB table that it uses. 
It is the user responsibility to use the scripts to create the tables in an available schema and change the configuration accordingly.
The SQL script files can be found in [src/main/resources/](../master/src/main/resources/)

This template is customized for MySQL. To use it with different SQL implementation, some changes are necessary:

* update SQL script dialect to desired one
* replace MySQL driver library (or add another) dependency to desired one in [POM](pom.xml)
* update Database Config to suitable connection instead of `db:my-sql-connection` in global elements (config.xml)
* update connection configurations in `mule.*.properties` file

## DB Considerations <a name="dbconsiderations"/>

There may be a few things that you need to know regarding DB, in order for this template to work.

This Anypoint Template may be using date time/timestamp fields from the DB in order to do comparisons and take further actions.
While the template handles the time zone by sending all such fields in a neutral time zone, it can not handle **time offsets**.
We define as **time offsets** the time difference that may surface between date time/timestamp fields from different systems due to a differences in the system's internal clock.
The user of this template should take this in consideration and take the actions needed to avoid the time offset.

### As source of data

There are no particular considerations for this Anypoint Template regarding DB as data origin.
### DB as destination of data

There are no particular considerations for this Anypoint Template regarding DB as data destination.











# Run it! <a name="runit"/>
Simple steps to get Database to Database Account Migration running.


## Running on premise <a name="runonopremise"/>
In this section we detail the way you should run your Anypoint Template on your computer.


### Where to Download Mule Studio and Mule ESB
First thing to know if you are a newcomer to Mule is where to get the tools.

+ You can download Mule Studio from this [Location](http://www.mulesoft.com/platform/mule-studio)
+ You can download Mule ESB from this [Location](http://www.mulesoft.com/platform/soa/mule-esb-open-source-esb)


### Importing an Anypoint Template into Studio
Mule Studio offers several ways to import a project into the workspace, for instance: 

+ Anypoint Studio Project from File System
+ Packaged mule application (.jar)

You can find a detailed description on how to do so in this [Documentation Page](http://www.mulesoft.org/documentation/display/current/Importing+and+Exporting+in+Studio).


### Running on Studio <a name="runonstudio"/>
Once you have imported you Anypoint Template into Anypoint Studio you need to follow these steps to run it:

+ Locate the properties file `mule.dev.properties`, in src/main/resources
+ Complete all the properties required as per the examples in the section [Properties to be configured](#propertiestobeconfigured)
+ Once that is done, right click on you Anypoint Template project folder 
+ Hover you mouse over `"Run as"`
+ Click on  `"Mule Application"`


### Running on Mule ESB stand alone <a name="runonmuleesbstandalone"/>
Complete all properties in one of the property files, for example in [mule.prod.properties] (../master/src/main/resources/mule.prod.properties) and run your app with the corresponding environment variable to use it. To follow the example, this will be `mule.env=prod`. 
After this, to trigger the use case you just need to hit the local HTTP Listener Connector on the port you configured in your file. If this is for instance, `9090` then you should hit: `http://localhost:9090/migrateaccounts` and this will run the migration process and send the batch process statistics to the email addresses configured.

## Running on CloudHub <a name="runoncloudhub"/>
While [creating your application on CloudHub](http://www.mulesoft.org/documentation/display/current/Hello+World+on+CloudHub) (Or you can do it later as a next step), you need to go to Deployment > Advanced to set all environment variables detailed in **Properties to be configured** as well as the **mule.env**.
Once your app is all set and started, supposing you choose `db2dbaccountmigration` as domain name to trigger the use case, you just need to hit `http://db2dbaccountmigration.cloudhub.io/migrateaccounts` and report will be sent to the emails configured.

### Deploying your Anypoint Template on CloudHub <a name="deployingyouranypointtemplateoncloudhub"/>
Mule Studio provides you with really easy way to deploy your Template directly to CloudHub, for the specific steps to do so please check this [link](http://www.mulesoft.org/documentation/display/current/Deploying+Mule+Applications#DeployingMuleApplications-DeploytoCloudHub)


## Properties to be configured (With examples) <a name="propertiestobeconfigured"/>
In order to use this Mule Anypoint Template you need to configure properties (Credentials, configurations, etc.) either in properties file or in CloudHub as Environment Variables. Detail list with examples:
### Application configuration
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

# API Calls <a name="apicalls"/>
This section is not relevant for this use case.


# Customize It!<a name="customizeit"/>
This brief guide intends to give a high level idea of how this Anypoint Template is built and how you can change it according to your needs.
As mule applications are based on XML files, this page will be organized by describing all the XML that conform the Anypoint Template.
Of course more files will be found such as Test Classes and [Mule Application Files](http://www.mulesoft.org/documentation/display/current/Application+Format), but to keep it simple we will focus on the XMLs.

Here is a list of the main XML files you'll find in this application:

* [config.xml](#configxml)
* [endpoints.xml](#endpointsxml)
* [businessLogic.xml](#businesslogicxml)
* [errorHandling.xml](#errorhandlingxml)


## config.xml<a name="configxml"/>
Configuration for Connectors and [Configuration Properties](http://www.mulesoft.org/documentation/display/current/Configuring+Properties) are set in this file. **Even you can change the configuration here, all parameters that can be modified here are in properties file, and this is the recommended place to do it so.** Of course if you want to do core changes to the logic you will probably need to modify this file.

In the visual editor they can be found on the *Global Element* tab.


## businessLogic.xml<a name="businesslogicxml"/>
Functional aspect of the Template is implemented in this XML, directed by one flow responsible of excecuting the logic.
This file contains a [Batch Job](http://www.mulesoft.org/documentation/display/current/Batch+Processing) which handles all the migration logic.



## endpoints.xml<a name="endpointsxml"/>
This is the file where you can find the inbound and outbound sides of your integration app.
This Template has only an [HTTP Listener Connector](http://www.mulesoft.org/documentation/display/current/HTTP+Listener+Connector) as the way to trigger the use case.

### Inbound Flow
**HTTP Listener Connector** - Start Report Generation

+ `${http.port}` is set as a property to be defined either in a property file or in CloudHub environment variables.
+ The path configured by default is `migrateaccounts` and you are free to change it for the one you prefer.
+ The host name for all endpoints in your CloudHub configuration should be defined as `localhost`. CloudHub will then route requests from your application domain URL to the endpoint.

Flow *triggerFlow* executes a [Batch Job](http://www.mulesoft.org/documentation/display/current/Batch+Processing) defined in *businessLogic.xml*, which handles all the migration logic.
This flow has Exception Strategy that basically consists of invoking the *defaultChoiseExceptionStrategy* defined in *errorHandling.xml* file.



## errorHandling.xml<a name="errorhandlingxml"/>
This is the right place to handle how your integration will react depending on the different exceptions. 
This file holds a [Error Handling](http://www.mulesoft.org/documentation/display/current/Error+Handling) that is referenced by the main flow in the business logic.



