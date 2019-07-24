package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Role;

import java.util.Set;

public interface IRoleService extends IBaseService<Role, Integer> {

    Integer updateUserRole(String uid, Set<Integer> roleIds);

    Integer updateRolePermission(Integer rid, Set<Integer> permissionIds);

    Set<Role> findAllByUserId(String uid);

}
