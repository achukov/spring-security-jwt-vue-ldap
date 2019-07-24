package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Permission;

import java.util.Set;

public interface IPermissionService extends IBaseService<Permission, Integer> {

    Set<Permission> findAllByUserId(String uid);

    Set<Integer> findPermissionByRoleId(Integer rid);

    Set<Permission> findAllTree();
}
