package com.ifsaid.report.controller;

import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Folder;
import com.ifsaid.report.service.IFolderService;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import com.ifsaid.report.vo.MyPage;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Api(tags = "Folder management")
@RestController
@RequestMapping("/folder")
public class FolderController extends BaseController<Folder, Integer, IFolderService> {

    @ApiOperation(value = "Query all", notes = "Return as a tree node")
    @GetMapping("/tree")
    public Result treeList() {
        return Result.success(baseService.findAllTree());
    }

    @GetMapping("/list")
    @Override
    public Result<Page<Folder>> findAll(MyPage page) {
        return Result.success(baseService.findAll(page));
    }
    
    // @ApiOperation(value = "Query all root folders", notes = "Query by ParentId")
    // @GetMapping("/parent/{id}")
    // public Result<String> folderInfo(@PathVariable Integer id) {
    //     Map<String, Object> map = new HashMap<>();
    //     Node node = new Node();
    //     node.setChildren(folderService.findByParentId(id));
    //     map.put("permission", Arrays.asList(node));
    //     return Result.success(map);
    // }

}
