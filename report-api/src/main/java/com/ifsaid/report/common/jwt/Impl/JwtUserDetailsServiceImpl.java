package com.ifsaid.report.common.jwt.Impl;

import com.ifsaid.report.common.jwt.JwtUserDetailsService;
import com.ifsaid.report.common.jwt.JwtUser;
import com.ifsaid.report.common.jwt.JwtUserFactory;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class JwtUserDetailsServiceImpl implements JwtUserDetailsService {

    private final IUserService userService;

    @Autowired
    public JwtUserDetailsServiceImpl(@Lazy IUserService userService) {
        this.userService = userService;
    }

    @Override
    public JwtUser loadUserByUsername(String account) throws UsernameNotFoundException {
        User user = userService.findByAccount(account);

        if (user == null || StringUtils.isEmpty(user.getUid())) {
            throw new UsernameNotFoundException("User with username: " + account + " not found.");
        } else {
            JwtUser jwtUser = JwtUserFactory.create(user);
            log.info("IN findByAccount - user with account: {} successfully loaded", account);
            return jwtUser;
        }
    }

    @Override
    public JwtUser loadUserByEmail(String email) {
        User user = userService.findByMail(email);
        if (user == null) {
            throw new UsernameNotFoundException(String.format("No user found with email '%s'.", email));
        } else {
            JwtUser jwtUser = JwtUserFactory.create(user);
            log.info("IN findByAccount - user with account: {} successfully loaded", email);
            return jwtUser;
        }
    }


}
