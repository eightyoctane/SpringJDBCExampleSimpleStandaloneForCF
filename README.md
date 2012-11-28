SpringJDBCExampleSimpleStandaloneForCF
======================================

This app is intended to be a cloudfoundry standalone app based upon http://www.mkyong.com/spring/maven-spring-jdbc-example/ 
 
1. It currently runs successfully from STS as a simple java app, updating and reading a local mysql db.
2. It currently deploys successfully (from the command line using vmc) to cloudfoundry with the same functionality, but in this case,
it creates the database as well.

On Cloud Foundry, the app runs "standalone", which means that there are no web components. The app is deployed as a "jar", rather than a "war".
Logging is used to monitor app results rather than using a web interface. The app is invoked from a shell script that is built from a shell script 
assembler. Currently on Cloud Foundry, manual Service configuration must be used, so the xml file must differentiate between "local" deployment 
versus cloud deployment.

This standalone app relies on appassembler for invocation (see doc below). 
From the app assembler doc, The startup command will be "$ sh target/appassembler/bin/app"

As is always the case, a great deal of care must be taken to insure that three items are perfect:
1. the bean xml definition files
2. the pom xml file
3. instantiation of Application Context in main, as well as any bean references

Here is the doc which was used to create the application:
1. http://docs.cloudfoundry.com/frameworks/java/spring/spring.html (indicates that autoreconfig should work for a single db - but it's not
clear about a standalone app. standalone does not support autoreconfig)
2. http://docs.cloudfoundry.com/frameworks/java/spring/spring.html#explicitly-configuring-your-application-to-use-cloud-foundry-services
3. http://docs.cloudfoundry.com/frameworks/java/spring/spring.html (javax.sql.datasource bean)
4. http://blog.cloudfoundry.com/2012/05/01/cloud-foundry-improves-support-for-background-processing/ (background processing and standalone apps)
5. http://mojo.codehaus.org/appassembler/appassembler-maven-plugin/usage-program.html (distribution zip)
6. https://github.com/cloudfoundry-samples/spring-batch-tweet-workers
