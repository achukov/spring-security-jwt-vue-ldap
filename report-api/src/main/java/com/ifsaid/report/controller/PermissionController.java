package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Permission;
import com.ifsaid.report.service.IPermissionService;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Set;

@Api(tags = "Authority management")
@RestController
@RequestMapping("/permission")
public class PermissionController extends BaseController<Permission, Integer, IPermissionService> {

    @ApiOperation(value = "Query all permissions", notes = "Return result to tree format")
    @GetMapping("/tree")
    public Result<Set<Permission>> get() {
        return Result.success(baseService.findAllTree());
    }

}
