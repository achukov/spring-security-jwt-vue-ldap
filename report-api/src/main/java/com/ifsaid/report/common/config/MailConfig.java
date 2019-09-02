package com.ifsaid.report.common.config;

import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.ui.freemarker.FreeMarkerConfigurationFactoryBean;

@Configuration
@PropertySource("classpath:mail/javamail.properties")
public class MailConfig {

    @Value("${mail.host}")
    private String host;
    @Value("${mail.port}")
    private String port;
    @Value("${mail.transport.protocol}")
    private String mailTransportProtocol;
    @Value("${mail.smtp.auth}")
    private String mailSmtpAuth;
    @Value("${mail.smtp.starttls.enable}")
    private String mailSmtpStartTlsEnable;
    @Value("${mail.debug}")
    private String mailDebug;

    // email configuration
    @Bean
    public JavaMailSender mailSender() throws IOException{

        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        mailSender.setDefaultEncoding("UTF-8");
        mailSender.setHost(host);
        mailSender.setPort(Integer.valueOf(port));

        final Properties properties = new Properties();
        properties.put("mail.transport.protocol", mailTransportProtocol);
        properties.put("mail.smtp.auth", mailSmtpAuth);
        properties.put("mail.smtp.starttls.enable", mailSmtpStartTlsEnable);
        properties.put("mail.debug", mailDebug);
        mailSender.setJavaMailProperties(properties);

        return mailSender;
    }

    // Freemarker configuration
    @Bean
    public FreeMarkerConfigurationFactoryBean getFreeMarkerConfiguration() {
        FreeMarkerConfigurationFactoryBean freeMarkerConfigurationFactoryBean = new FreeMarkerConfigurationFactoryBean();
        freeMarkerConfigurationFactoryBean.setTemplateLoaderPath("/mail/");
        return freeMarkerConfigurationFactoryBean;
    }
//
//    @Bean
//    public ExecutorService executorService() {
//        return Executors.newCachedThreadPool();
//    }

}
