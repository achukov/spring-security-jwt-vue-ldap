package com.ifsaid.report.controller;

import com.ifsaid.report.common.jwt.JwtUser;
import com.ifsaid.report.service.IUserService;
import com.ifsaid.report.vo.LoginUser;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Slf4j
@Api(tags = "log in")
@RestController
public class AuthController {

    @Autowired
    private IUserService userService;

    @ApiOperation(value = "log in", notes = "Username, password login format {\"username\":\"admin\",\"password\":\"admin\"}")
    @PostMapping(value = "${jwt.route.login}")
    public Result<String> login(@RequestBody LoginUser user) {
        log.info("LoginUser : {}", user);
        return Result.success("login successful", userService.login(user.getUsername(), user.getPassword()));
    }

    @ApiOperation(value = "Refresh Token", notes = "You only need to attach the token to the request header, no parameters are required.")
    @PostMapping(value = "${jwt.route.refresh}")
    public Result<String> refresh(@RequestHeader(value = "${jwt.tokenHeader}") String token) {
        JwtUser principal = (JwtUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        log.info("Principal: {}", principal);
        return Result.success("Refresh token successfully", userService.refreshToken(token));
    }

}
