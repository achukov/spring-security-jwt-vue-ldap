package com.ifsaid.report.common.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Slf4j
@Configuration
@AutoConfigureBefore(WebSecurityConfig.class)
public class SpringMvcConfigurer implements WebMvcConfigurer {

    /**
     * @Description: Cross configuration
     */
    public void addCorsMappings(CorsRegistry registry) {
        log.info("Cross-Domain set");
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("*")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }

}
