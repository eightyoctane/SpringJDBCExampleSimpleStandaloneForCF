package com.mkyong.cloud.model;

import java.net.MalformedURLException;
import java.net.URL;

import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudApplication;
import org.cloudfoundry.client.lib.domain.CloudInfo;

public class Cloud {
	String email;
	String uname;
	String password;
	
	public Cloud(String email, String uname, String password) {
		this.email = email;
		this.uname = uname;
		this.password = password;
		
		CloudFoundryClient client;
		URL target;
		
		try {
			target = new URL("https://api.cloudfoundry.com");
			
			// Simple Client without any authentication	
			//client = new CloudFoundryClient(target);
			
			// Authenticated Client 
			//String email = "amoghadam@vmware.com";
			//String password = "golden123";
			
			client = new CloudFoundryClient(new CloudCredentials(email, password), target);
			client.login();
			
			if (client.getCloudInfo().getCloudControllerMajorVersion() == CloudInfo.CC_MAJOR_VERSION.V2) {
				System.out.println("Cloud Controller V2");
				System.out.println("Version: " + client.getCloudInfo().getVersion());
				
				for (CloudApplication app : client.getApplications()) {
					System.out.println("Application Name: " + app.getName());
					System.out.println("Application Memory: " + app.getMemory());
					System.out.println("Application State: " + app.getState());
				}
			} else {
				System.out.println("Cloud Controller V1");
				System.out.println("Version: " + client.getCloudInfo().getVersion());
				
				for (CloudApplication app : client.getApplications()) {
					System.out.println("Application Name: " + app.getName());
					System.out.println("Application Memory: " + app.getMemory());
					System.out.println("Application State: " + app.getState());
					
				}
			}
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		String env = java.lang.System.getenv("VCAP_SERVICES");
		System.out.println("Services:" + env );
			
	}
	
	@Override
	public String toString() {
		return "Cloud [email=" + email + ", uname=" + uname + ", password=" + password
				+ "]";
	}

	public String getemail() {
		return email;
	}

	public void setemail(String email) {
		this.email = email;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
