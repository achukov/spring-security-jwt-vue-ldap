package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Ldp;
import com.ifsaid.report.service.ILdpService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;

import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Api(tags = "Ldp management")
@RestController
@RequestMapping("/ldp")
public class LdpController extends BaseController<Ldp, Long, ILdpService> {

    @GetMapping("/list")
    @Override
    public Result<Page<Ldp>> findAll(MyPage page) {

        return Result.success(baseService.findAll(page));
    }

}
