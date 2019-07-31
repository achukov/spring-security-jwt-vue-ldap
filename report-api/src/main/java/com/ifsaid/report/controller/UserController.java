package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.common.jwt.JwtUser;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.service.IUserService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;
import com.ifsaid.report.dto.UserDto;
import io.swagger.annotations.Api;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "User Management")
@RestController
@RequestMapping("/user")
public class UserController extends BaseController<User, String, IUserService> {

    @GetMapping("/info")
    public Result<UserDto> findUserInfo() {
        JwtUser userDetails = (JwtUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserDto userInfo = baseService.findUserInfo(userDetails.getUsername());
        return Result.success(userInfo);
    }


    @GetMapping("/page/info")
    public Result<Page<UserDto>> findAllInfo(MyPage page) {
        PageRequest pageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        return Result.success(baseService.findAllInfo(pageRequest));
    }
    
}
