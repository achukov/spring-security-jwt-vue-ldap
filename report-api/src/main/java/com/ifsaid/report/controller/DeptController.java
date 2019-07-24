package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Dept;
import com.ifsaid.report.service.IDeptService;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "Department management")
@RestController
@RequestMapping("/dept")
public class DeptController extends BaseController<Dept, Integer, IDeptService> {

    @ApiOperation(value = "Query all", notes = "Return as a tree node")
    @GetMapping("/tree")
    public Result treeList() {
        return Result.success(baseService.findAllTree());
    }

}
