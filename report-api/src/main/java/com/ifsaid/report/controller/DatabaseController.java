package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Database;
import com.ifsaid.report.service.IDatabaseService;
import com.ifsaid.report.vo.Result;
import com.ifsaid.report.vo.MyPage;
import org.springframework.data.domain.Page;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "Database management")
@RestController
@RequestMapping("/database")
public class DatabaseController extends BaseController<Database, Integer, IDatabaseService> {

    @GetMapping("/list")
    @Override
    public Result<Page<Database>> findAll(MyPage page) {
        return Result.success(baseService.findAll(page));
    }
}
