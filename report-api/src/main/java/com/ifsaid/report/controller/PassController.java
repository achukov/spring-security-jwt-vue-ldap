package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Pass;
import com.ifsaid.report.service.IPassService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;

import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;

import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Api(tags = "PassApproval management")
@RestController
@RequestMapping("/pass")
public class PassController extends BaseController<Pass, Long, IPassService> {

    @GetMapping("/list")
    @Override
    public Result<Page<Pass>> findAll(MyPage page) {
        return Result.success(baseService.findAll(page));
    }

    @GetMapping("/my")
    public Result<Page<Pass>> findAllbyAuthor(MyPage page, @RequestHeader(value = "${jwt.tokenHeader}") String token) {
        return Result.success(baseService.findAllbyAuthor(page, token));
    }
    
}
