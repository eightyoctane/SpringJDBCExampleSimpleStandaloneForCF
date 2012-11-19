SpringJDBCExampleSimpleStandaloneForCF
======================================

This app is intended to be a cloudfoundry standalone app based upon http://www.mkyong.com/spring/maven-spring-jdbc-example/ 
 
It currently runs successfully from STS as a simple java app, updating and reading a local mysql db.

I'm trying to use the cf documentation and push it successfully to cf, and use as a simple example,
in response to a customer problem involving running a spring batch app (with a hibernate db) standalone ( http://support.cloudfoundry.com/tickets/102770?col=26023382&page=1 ) 

Doc:
1. http://docs.cloudfoundry.com/frameworks/java/spring/spring.html (autoreconfig should work for a single db)
2. http://forum.springsource.org/showthread.php?50461-quot-org-apache-commons-dbcp-BasicDataSource-quot-not-found-error (can't find apache library)
3. http://docs.cloudfoundry.com/frameworks/java/spring/spring.html (javax.sql.datasource bean)
4. http://blog.cloudfoundry.com/2012/05/01/cloud-foundry-improves-support-for-background-processing/ (background processing and standalone apps)
5. http://mojo.codehaus.org/appassembler/appassembler-maven-plugin/usage-program.html (distribution zip)

	a. added the app assembler plugin to my pom
	b. insured that in STS maven install completed successfully
	c. from the command line  $ mvn package appassembler:assemble
	d. from the app assembler doc, I believe the startup command will be "$ sh target/appassembler/bin/app"
	e. I deploy using vmc (sts isn't recognizing that this is a standalone app)
		e1. I have already provisioned a mysql service, created the db, and the customer table
		e2. I attach the existing service to the app during the push

The error:
The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.)
	at com.mkyong.customer.dao.impl.JdbcCustomerDAO.insert(JdbcCustomerDAO.java:38)
	at com.mkyong.common.App.main(App.java:23)
Caused by: org.apache.commons.dbcp.SQLNestedException: Cannot create PoolableConnectionFactory (Communications link failure


Stack trace below:

Garys-MacBook-Pro:SpringJDBCExampleSimpleStandaloneForCF ggross$ vmc push
Would you like to deploy from the current directory? [Yn]: 
Application Name: SpringStandalone
Detected a Standalone Application, is this correct? [Yn]: y
1: java
2: java7
3: node
4: node06
5: node08
6: ruby18
7: ruby19
Select Runtime [java]: 1
Selected java
Start Command: sh target/appassembler/bin/app
Application Deployed URL [None]: 
Memory reservation (128M, 256M, 512M, 1G, 2G) [512M]: 
How many instances? [1]: 
Bind existing services to 'SpringStandalone'? [yN]: y
1: garyinsertpg
2: guestbookmongo
3: hellom
4: jdbcexample
5: mysql-45fd9ae
6: pgpets4u
7: postappv3
8: postgresql-fecd4
9: vcap-client-test
Which one?: 4
Bind another? [yN]: n
Create services to bind to 'SpringStandalone'? [yN]: 
Would you like to save this configuration? [yN]: 
Creating Application: OK
Binding Service [jdbcexample]: OK
Uploading Application:
  Checking for available resources: OK
  Processing resources: OK
  Packing application: OK
  Uploading (32K): OK   
Push Status: OK
Staging Application 'SpringStandalone': OK                                      
Starting Application 'SpringStandalone': .
Error: Application [SpringStandalone] failed to start, logs information below.

====> /logs/stderr.log <====

Nov 19, 2012 9:20:31 PM org.springframework.context.support.AbstractApplicationContext prepareRefresh
INFO: Refreshing org.springframework.context.support.ClassPathXmlApplicationContext@31d520c4: startup date [Mon Nov 19 21:20:31 UTC 2012]; root of context hierarchy
Nov 19, 2012 9:20:31 PM org.springframework.beans.factory.xml.XmlBeanDefinitionReader loadBeanDefinitions
INFO: Loading XML bean definitions from class path resource [Spring-Module.xml]
Nov 19, 2012 9:20:31 PM org.springframework.beans.factory.xml.XmlBeanDefinitionReader loadBeanDefinitions
INFO: Loading XML bean definitions from class path resource [database/Spring-Datasource.xml]
Nov 19, 2012 9:20:31 PM org.springframework.beans.factory.xml.XmlBeanDefinitionReader loadBeanDefinitions
INFO: Loading XML bean definitions from class path resource [customer/Spring-Customer.xml]
Nov 19, 2012 9:20:31 PM org.springframework.beans.factory.support.DefaultListableBeanFactory preInstantiateSingletons
INFO: Pre-instantiating singletons in org.springframework.beans.factory.support.DefaultListableBeanFactory@5117f31e: defining beans [dataSource,customerDAO]; root of factory hierarchy
Exception in thread "main" java.lang.RuntimeException: org.apache.commons.dbcp.SQLNestedException: Cannot create PoolableConnectionFactory (Communications link failure

The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.)
	at com.mkyong.customer.dao.impl.JdbcCustomerDAO.insert(JdbcCustomerDAO.java:38)
	at com.mkyong.common.App.main(App.java:23)
Caused by: org.apache.commons.dbcp.SQLNestedException: Cannot create PoolableConnectionFactory (Communications link failure

The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.)
	at org.apache.commons.dbcp.BasicDataSource.createPoolableConnectionFactory(BasicDataSource.java:1549)
	at org.apache.commons.dbcp.BasicDataSource.createDataSource(BasicDataSource.java:1388)
	at org.apache.commons.dbcp.BasicDataSource.getConnection(BasicDataSource.java:1044)
	at com.mkyong.customer.dao.impl.JdbcCustomerDAO.insert(JdbcCustomerDAO.java:29)
	... 1 more
Caused by: com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure

The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:39)
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:27)
	at java.lang.reflect.Constructor.newInstance(Constructor.java:513)
	at com.mysql.jdbc.Util.handleNewInstance(Util.java:406)
	at com.mysql.jdbc.SQLError.createCommunicationsException(SQLError.java:1074)
	at com.mysql.jdbc.ConnectionImpl.createNewIO(ConnectionImpl.java:2209)
	at com.mysql.jdbc.ConnectionImpl.<init>(ConnectionImpl.java:776)
	at com.mysql.jdbc.JDBC4Connection.<init>(JDBC4Connection.java:46)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:39)
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:27)
	at java.lang.reflect.Constructor.newInstance(Constructor.java:513)
	at com.mysql.jdbc.Util.handleNewInstance(Util.java:406)
	at com.mysql.jdbc.ConnectionImpl.getInstance(ConnectionImpl.java:352)
	at com.mysql.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:284)
	at org.apache.commons.dbcp.DriverConnectionFactory.createConnection(DriverConnectionFactory.java:38)
	at org.apache.commons.dbcp.PoolableConnectionFactory.makeObject(PoolableConnectionFactory.java:582)
	at org.apache.commons.dbcp.BasicDataSource.validateConnectionFactory(BasicDataSource.java:1556)
	at org.apache.commons.dbcp.BasicDataSource.createPoolableConnectionFactory(BasicDataSource.java:1545)
	... 4 more
Caused by: com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure

The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:39)
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:27)
	at java.lang.reflect.Constructor.newInstance(Constructor.java:513)
	at com.mysql.jdbc.Util.handleNewInstance(Util.java:406)
	at com.mysql.jdbc.SQLError.createCommunicationsException(SQLError.java:1074)
	at com.mysql.jdbc.MysqlIO.<init>(MysqlIO.java:343)
	at com.mysql.jdbc.ConnectionImpl.createNewIO(ConnectionImpl.java:2132)
	... 17 more
Caused by: java.net.ConnectException: Connection refused
	at java.net.PlainSocketImpl.socketConnect(Native Method)
	at java.net.PlainSocketImpl.doConnect(PlainSocketImpl.java:351)
	at java.net.PlainSocketImpl.connectToAddress(PlainSocketImpl.java:213)
	at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:200)
	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:366)
	at java.net.Socket.connect(Socket.java:529)
	at java.net.Socket.connect(Socket.java:478)
	at java.net.Socket.<init>(Socket.java:375)
	at java.net.Socket.<init>(Socket.java:218)
	at com.mysql.jdbc.StandardSocketFactory.connect(StandardSocketFactory.java:253)
	at com.mysql.jdbc.MysqlIO.<init>(MysqlIO.java:292)
	... 18 more


Delete the application? [Yn]: 

