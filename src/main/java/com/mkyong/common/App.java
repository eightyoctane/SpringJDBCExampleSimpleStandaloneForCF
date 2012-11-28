package com.mkyong.common;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.mkyong.customer.dao.CustomerDAO;
import com.mkyong.customer.model.Customer;

import org.cloudfoundry.runtime.env.CloudEnvironment;

public class App 
{
    public static void main( String[] args )
    {
		if(new CloudEnvironment().isCloudFoundry()) {
			  //activate cloud profile
			  System.setProperty("spring.profiles.active","cloud");
		}
		// Note: App.class defines the base path which is used to locate Spring-Module.xml
		// Note also: if building in STS configure the build config output path to send Spring-Module.xml to that location!
    	ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml", App.class);    	
    	 
        CustomerDAO customerDAO = (CustomerDAO) context.getBean("customerDAO");
        
        Customer customer = new Customer(4, "mkyong", 28);
        customerDAO.insert(customer);
    	
        Customer customer1 = customerDAO.findByCustomerId(4);
        System.out.println(customer1);
        
    }
}
