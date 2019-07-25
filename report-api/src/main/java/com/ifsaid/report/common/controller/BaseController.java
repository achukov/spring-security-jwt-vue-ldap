package com.ifsaid.report.common.controller;

import com.ifsaid.report.common.entity.BaseEntity;
import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@SuppressWarnings("unchecked")
public class BaseController<T extends BaseEntity, ID, S extends IBaseService<T, ID>> {

    @Autowired
    protected S baseService;

    @ApiOperation(value = "Single query", notes = "Query by id")
    @GetMapping("/{id}")
    public Result<T> findById(@PathVariable("id") ID id) {
        log.info("get ID : {}", id);
        return Result.success(baseService.findById(id));
    }

    @ApiOperation(value = "Query all", notes = "Query all")
    @GetMapping("/all")
    public Result<List<T>> findAll() {
        return Result.success(baseService.findAll());
    }

    @ApiOperation(value = "Pagination", notes = "Paging all")
    @GetMapping("/page")
    public Result<Page<T>> findAll(MyPage page) {
        log.info("page :  {} size : {}", page.getPage(), page.getSize());
        PageRequest rageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        return Result.success(baseService.findAll(rageRequest));
    }

    @ApiOperation(value = "New", notes = "Without Id")
    @PostMapping("/")
    public Result<T> save(@RequestBody T entity) {
        log.info("save :  {}", entity);
        return Result.success(baseService.save(entity));
    }

    @ApiOperation(value = "Modify", notes = "Modify by id")
    @PutMapping("/")
    public Result<T> update(@RequestBody T entity) {
        log.info("update:  {}", entity);
        return Result.success(baseService.update(entity));
    }

    @ApiOperation(value = "Delete", notes = "Delete by id")
    @DeleteMapping("/{id}")
    public Result<String> delete(@PathVariable("id") ID id) {
        log.info("delete:  {}", id);
        baseService.deleteById(id);
        return Result.success();
    }
}
