package com.ifsaid.report.common.jwt;

import com.ifsaid.report.common.jwt.JwtUser;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface JwtUserDetailsService extends UserDetailsService {

    @Override
    JwtUser loadUserByUsername(String username);

    JwtUser loadUserByEmail(String email);
}
