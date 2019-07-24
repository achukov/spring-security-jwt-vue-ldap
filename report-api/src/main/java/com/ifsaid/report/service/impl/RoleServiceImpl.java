package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Role;
import com.ifsaid.report.repository.RoleRepository;
import com.ifsaid.report.service.IRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

@Slf4j
@Service
public class RoleServiceImpl extends BaseServiceImpl<Role, Integer, RoleRepository> implements IRoleService {

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public Integer updateUserRole(String uid, Set<Integer> roleIds) {
        Integer deleteInteger = baseRepository.deleteUserRoleAll(uid);
        log.info("User id {} deleted {} characters.......", uid, deleteInteger);
        roleIds.forEach(roleId -> baseRepository.addUserRole(uid, roleId));
        return 1;
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public Integer updateRolePermission(Integer rid, Set<Integer> permissionIds) {
        Integer deleteInteger = baseRepository.deleteRolePermissionAll(rid);
        log.info("Role ID {} removed {} permissions.......", rid, deleteInteger);
        permissionIds.forEach(pid -> baseRepository.addRolePermission(rid, pid));
        return 1;
    }

    @Override
    public Set<Role> findAllByUserId(String uid) {
        return baseRepository.findAllByUserId(uid);
    }

}
