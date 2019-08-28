package com.ifsaid.report.common.utils;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;


import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.mail.javamail.MimeMessageHelper;
//import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
//import java.util.concurrent.ExecutorService;

@Slf4j
@Component
public class EmailSender extends SpringBeanAutowiringSupport {

    private final String emailTemplate = "/mail";

    private final String logoPath = "/images/logo.png";

//    @Autowired
//    private ExecutorService emailExecutor;
//
//    @Autowired
//    private JavaMailSender emailSender;

    @Autowired
    private Environment env;

    public EmailSender() {
    }

    public void htmlEmailManyTo(final ServletContext servletContext, final String user, final String[] to, final String subject, final String msg) {
        new Thread(() -> {
            try {
                HtmlEmail htmlEmail = new HtmlEmail();

                htmlEmail.setHostName(env.getProperty("mail.host"));
                htmlEmail.setSmtpPort(25);

                htmlEmail.setFrom(env.getProperty("mail.sender"));
                htmlEmail.addTo(to);
                htmlEmail.setSubject(subject);

                String logo = servletContext.getRealPath(logoPath);
                File logoFile = new File(logo);
                String logoBat = htmlEmail.embed(logoFile);

                Map model = new HashMap();
                model.put("user", user);
                model.put("subject", subject);
                model.put("message", msg);
                model.put("logoBat", logoBat);
                Configuration freemarkerConfiguration = new Configuration(Configuration.VERSION_2_3_22);
                freemarkerConfiguration.setServletContextForTemplateLoading(servletContext, emailTemplate);
                String msgContent = FreeMarkerTemplateUtils.processTemplateIntoString(freemarkerConfiguration.getTemplate("template.html"), model);
                htmlEmail.setHtmlMsg(msgContent);
                String send = htmlEmail.send();
                log.info("EMAIL SENDER: " + send);
            } catch (EmailException e) {
                log.error(e.getMessage());
            } catch (IOException e) {
                log.error(e.getMessage());
            } catch (TemplateException e) {
                log.error(e.getMessage());
            }
        }).start();
    }

//    public void mimeEmail(final ServletContext servletContext, final User user, final String to[], final String subject, final String msg) throws EmailException {
//        try {
//            System.out.println("\n\n" + "This is the system base directory" + "\n" + servletContext.getRealPath(File.separator)+"\n\n");
//            emailExecutor.execute(() -> {
//                MimeMessagePreparator messagePreparator = mimeMessage -> {
//                    MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage);
//                    messageHelper.setFrom(env.getProperty("mail.sender"));
//                    messageHelper.setTo(to);
//                    messageHelper.setSubject(subject);
//
//                    Map model = new HashMap();
//                    model.put("user", "alexey_chukov@gmail.com");
//                    model.put("subject", subject);
//                    model.put("message", msg);
//                    Configuration freemarkerConfiguration = new Configuration(Configuration.VERSION_2_3_22);
//                    freemarkerConfiguration.setServletContextForTemplateLoading(servletContext, emailTemplate);
//                    String text = FreeMarkerTemplateUtils.processTemplateIntoString(freemarkerConfiguration.getTemplate("template.html"), model);
//                    messageHelper.setText(text, true);
//                };
//                emailSender.send(messagePreparator);
//            });
//        } finally {
//            emailExecutor.shutdown();
//        }
//    }

}
