package com.ifsaid.report.common.jwt;

import com.ifsaid.report.common.jwt.Impl.JwtUserDetailsServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@Component
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {

    private final  JwtUserDetailsService jwtUserDetailsService;
    private final JwtTokenProvider jwtTokenProvider;

    @Autowired
    public JwtAuthenticationTokenFilter(JwtUserDetailsService jwtUserDetailsService, JwtTokenProvider jwtTokenProvider) {
        this.jwtUserDetailsService = jwtUserDetailsService;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        String authHeader = request.getHeader(this.jwtTokenProvider.getTokenHeader());
        if (authHeader != null && authHeader.startsWith(this.jwtTokenProvider.getTokenHead())) {
            final String authToken = authHeader.substring(this.jwtTokenProvider.getTokenHead().length());
            String username = jwtTokenProvider.getUsernameFromToken(authToken);

            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                log.info(String.format("Checking authentication for user %s ", username));
//
                try {
                    JwtUser jwtUser = this.jwtUserDetailsService.loadUserByUsername(username);
                    if (jwtTokenProvider.validateToken(authToken, jwtUser)) {
                        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(jwtUser, null, jwtUser.getAuthorities());
                        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                        log.info(String.format("Authenticated user %s, setting security context", username));
                        log.info(String.format("%s has authorities: %s", username, jwtUser.getAuthorities()));
                        SecurityContextHolder.getContext().setAuthentication(authentication);
                    }
                } catch (UsernameNotFoundException e) {
                        log.info(String.format("User %s not found.", username));
                    }
            }
        }
        chain.doFilter(request, response);
    }
}
