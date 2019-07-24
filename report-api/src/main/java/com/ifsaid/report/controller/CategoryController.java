package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Category;
import com.ifsaid.report.service.ICategoryService;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "Category management")
@RestController
@RequestMapping("/category")
public class CategoryController extends BaseController<Category, Integer, ICategoryService> {

    @ApiOperation(value = "Query all", notes = "Query all categories abbreviation")
    @GetMapping("/all/{simple}")
    public Result<List<Category>> findAll(@PathVariable("simple") String simple) {
        return Result.success(baseService.findAllByRegion(simple));
    }


}
