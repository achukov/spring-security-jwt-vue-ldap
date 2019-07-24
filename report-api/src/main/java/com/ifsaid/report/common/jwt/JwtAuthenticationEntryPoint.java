package com.ifsaid.report.common.jwt;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ifsaid.report.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint, Serializable {

    private final ObjectMapper mapper;

    public JwtAuthenticationEntryPoint(ObjectMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");
        Result result = null;
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
        /*Identity authentication failed*/
        // This is invoked when user tries to access a secured REST resource without supplying any credentials
        // We should just send a 401\403 Unauthorized response because there is no 'login page' to redirect to
        if (authException instanceof BadCredentialsException) {
            result = Result.error401("The username or password is incorrect.", authException.getMessage());
        } else {
            result = Result.error401("Invalid token.", authException.getMessage());
        }
        response.getWriter().write(mapper.writeValueAsString(result));
    }
}
