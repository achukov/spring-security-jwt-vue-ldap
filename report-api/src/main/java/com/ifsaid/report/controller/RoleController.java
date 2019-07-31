package com.ifsaid.report.controller;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ifsaid.report.common.controller.BaseController;
import com.ifsaid.report.entity.Permission;
import com.ifsaid.report.entity.Role;
import com.ifsaid.report.service.IPermissionService;
import com.ifsaid.report.service.IRoleService;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.Reader;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Api(tags = "Role management")
@RestController
@RequestMapping("/role")
public class RoleController extends BaseController<Role, Integer, IRoleService> {

    @Autowired
    private ObjectMapper mapper;

    @Autowired
    private IPermissionService permissionService;

    @ApiOperation(value = "Query role details, including permission lists", notes = "Query by id")
    @GetMapping("/info/{rid}")
    public Result<String> roleInfo(@PathVariable Integer rid) {
        Map<String, Object> map = new HashMap<>();
        map.put("current", permissionService.findPermissionByRoleId(rid));
        Permission permission = new Permission();
        permission.setTitle("Permission list");
        permission.setPid(0);
        permission.setChildren(permissionService.findAllTree());
        map.put("all", Arrays.asList(permission));
        return Result.success(map);
    }

    @ApiOperation(value = "Modify user permissions", notes = "Parameter format: {'uid':'1','rids':'[1,2,3]'}")
    @PostMapping("/update/user")
    public Result updateUserRole(@RequestBody Map<String, Object> map) {
        String uid = (String) map.get("uid");
        List<Integer> rids = (List<Integer>) map.get("rids");
        Set<Integer> collect = rids.stream().filter(r -> r != 0).collect(Collectors.toSet());

        log.info("updateUserRole collect : {}", collect);
        if (uid == null || StringUtils.isEmpty(uid)) {
            return Result.error500("User_Id cannot be empty", null);
        }
        if (collect == null || collect.size() < 1) {
            return Result.error500("Role_Id cannot be empty", null);
        }
        return Result.success("success", baseService.updateUserRole(uid, collect));
    }

    @ApiOperation(value = "Modify role permissions", notes = "Parameter format: {'rid':'1','pids':'[1,2,3]'}")
    @PostMapping("/update/permission")
    public Result<String> roleInfo(@RequestBody Map<String, Object> map) {
        Integer rid = (Integer) map.get("rid");
        List<Integer> pids = (List<Integer>) map.get("pids");
        log.info("updatePermission rid : {}  {}", rid, pids);
        Set<Integer> collect = pids.stream().filter(p -> p != 0).collect(Collectors.toSet());
        log.info("updatePermission collect : {}", collect);
        if (rid == null || rid < 1)
            return Result.error500("Role_Id cannot be empty", null);
        if (pids.size() < 1)
            return Result.error500("Permission cannot be empty", null);
        return Result.success("Success", baseService.updateRolePermission(rid, collect));
    }

}
