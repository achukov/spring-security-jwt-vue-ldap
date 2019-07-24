package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.common.jwt.JwtUser;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.service.IUserService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;
import com.ifsaid.report.vo.UserVo;
import io.swagger.annotations.Api;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(tags = "User Management")
@RestController
@RequestMapping("/user")
public class UserController extends BaseController<User, String, IUserService> {

    @GetMapping("/info")
    public Result<UserVo> findUserInfo() {
        JwtUser userDetails = (JwtUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserVo userInfo = baseService.findUserInfo(userDetails.getUsername());
        return Result.success(userInfo);
    }


    @GetMapping("/page/info")
    public Result<Page<UserVo>> findAllInfo(MyPage page) {
        PageRequest rageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        return Result.success(baseService.findAllInfo(rageRequest));
    }
    
}
