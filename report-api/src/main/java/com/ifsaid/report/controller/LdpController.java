package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Ldp;
import com.ifsaid.report.service.ILdpService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;

import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Api(tags = "Ldp management")
@RestController
@RequestMapping("/ldp")
public class LdpController extends BaseController<Ldp, Long, ILdpService> {

    private final ILdpService ldpService;

    public LdpController(ILdpService ldpService) {
        this.ldpService = ldpService;
    }

    @GetMapping("/list")
    @Override
    public Result<Page<Ldp>> findAll(MyPage page) {
        return Result.success(baseService.findAll(page));
    }


   @PostMapping("/start/{id}")
   public Result<String> start(@PathVariable Long id) {
       log.info("Start by Id : {}", id);
       try {
           ldpService.start(id);
           return Result.success("Successful task");
       } catch (Exception e) {
           e.printStackTrace();
           return Result.success("TaskDto failure");
       }
   }
}
