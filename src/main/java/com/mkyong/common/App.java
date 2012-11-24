package com.mkyong.common;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.mkyong.customer.dao.CustomerDAO;
import com.mkyong.customer.model.Customer;

import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudApplication;
import org.cloudfoundry.client.lib.domain.CloudEntity;
import org.cloudfoundry.client.lib.domain.CloudInfo;
import org.cloudfoundry.runtime.env.CloudEnvironment;

public class App 
{
    public static void main( String[] args )
    {
		if(new CloudEnvironment().isCloudFoundry()) {
			  //activate cloud profile
			  System.setProperty("spring.profiles.active","cloud");
		}
    	ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml", App.class);
    	//ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

    	 
        CustomerDAO customerDAO = (CustomerDAO) context.getBean("customerDAO");
        
        Customer customer = new Customer(4, "mkyong",28);
        customerDAO.insert(customer);
    	
        Customer customer1 = customerDAO.findByCustomerId(1);
        System.out.println(customer1);
        
    }
}
