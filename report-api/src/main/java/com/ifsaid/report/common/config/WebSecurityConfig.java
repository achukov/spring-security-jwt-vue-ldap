package com.ifsaid.report.common.config;

import com.ifsaid.report.common.jwt.JwtAuthenticationEntryPoint;
import com.ifsaid.report.common.jwt.JwtAuthenticationTokenFilter;
import com.ifsaid.report.common.jwt.JwtTokenProvider;
import com.ifsaid.report.common.jwt.JwtUserDetailsService;
import com.ifsaid.report.common.utils.AttributesLDAPUserDetailsContextMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.ldap.authentication.ad.ActiveDirectoryLdapAuthenticationProvider;
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled=true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

  @Value("${ldap.host}")
  private String ldapHost;

  @Value("${ldap.root}")
  private String root;

  @Value("${ldap.domain}")
  private String domain;

    private final JwtAuthenticationEntryPoint unauthorizedHandler;
    private final JwtUserDetailsService jwtUserDetailsService;
    private final JwtTokenProvider jwtTokenProvider;

    @Autowired
    public WebSecurityConfig(JwtAuthenticationEntryPoint unauthorizedHandler, JwtUserDetailsService jwtUserDetailsService, JwtTokenProvider jwtTokenProvider) {
        this.unauthorizedHandler = unauthorizedHandler;
        this.jwtUserDetailsService = jwtUserDetailsService;
        this.jwtTokenProvider = jwtTokenProvider;
    }


    @Bean(name = BeanIds.AUTHENTICATION_MANAGER)
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
    /*
     * Configure Active Directory as authentication provider.
     */
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {
        authenticationManagerBuilder
                .authenticationProvider(activeDirectoryLdapAuthenticationProvider());
    }

    @Bean
    public JwtAuthenticationTokenFilter authenticationTokenFilterBean() throws Exception {
        return new JwtAuthenticationTokenFilter(jwtUserDetailsService, jwtTokenProvider);
    }

    @Bean
    public ActiveDirectoryLdapAuthenticationProvider activeDirectoryLdapAuthenticationProvider() {
        ActiveDirectoryLdapAuthenticationProvider provider = new ActiveDirectoryLdapAuthenticationProvider(null, ldapHost, root);
        provider.setConvertSubErrorCodesToExceptions(true);
        provider.setUseAuthenticationRequestCredentials(true);
        provider.setUserDetailsContextMapper(userDetailsContextMapper());
        return provider;
    }

    @Bean
    public UserDetailsContextMapper userDetailsContextMapper() {
        return new AttributesLDAPUserDetailsContextMapper();
    }

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.cors().and().csrf().disable()
        .exceptionHandling().authenticationEntryPoint(unauthorizedHandler).and()
        .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        .and().authorizeRequests()
        // Expose interfaces that do not require authentication. Log in, refresh the token,
        .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
        .antMatchers("/auth/**", "/actuator/**", "/activitiesView/info/**").permitAll()
        .antMatchers("/v2/api-docs", "/doc.html", "/configuration/ui",
        "/swagger-resources", "/configuration/security", "/swagger-ui.html",
        "/webjars/**", "/swagger-resources/configuration/ui", "/swagge‌​r-ui.html")
        .permitAll().anyRequest().authenticated();
        httpSecurity
            .addFilterBefore(authenticationTokenFilterBean(), UsernamePasswordAuthenticationFilter.class);
        httpSecurity.headers().cacheControl();
    }

}