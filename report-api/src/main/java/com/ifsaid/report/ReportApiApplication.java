package com.ifsaid.report;

import org.activiti.spring.boot.SecurityAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class ReportApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(ReportApiApplication.class, args);
	}


}
