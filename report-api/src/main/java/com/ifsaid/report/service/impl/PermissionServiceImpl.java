package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Permission;
import com.ifsaid.report.repository.PermissionRepository;
import com.ifsaid.report.service.IPermissionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
public class PermissionServiceImpl extends BaseServiceImpl<Permission, Integer, PermissionRepository> implements IPermissionService {

    @Override
    public Set<Permission> findAllByUserId(String uid) {
        return baseRepository.findAllByUserId(uid);
    }

    @Override
    public Set<Integer> findPermissionByRoleId(Integer rid) {
        return baseRepository.findPermissionByRoleId(rid);
    }

    @Override
    public Set<Permission> findAllTree() {
        return findRoots(findAll());
    }

    private Set<Permission> findRoots(List<Permission> allNodes) {
        Set<Permission> root = new HashSet<>();
        allNodes.forEach(node -> {
            if (node.getParentId() == 0) {
                root.add(node);
            }
        });
        root.forEach(node -> {
            findChildren(node, allNodes);
        });
        return root;
    }

    private Permission findChildren(Permission treeNode, List<Permission> treeNodes) {
        for (Permission it : treeNodes) {
            if (treeNode.getPid().equals(it.getParentId())) {
                if (treeNode.getChildren() == null) {
                    treeNode.setChildren(new HashSet<>());
                }
                treeNode.getChildren().add(findChildren(it, treeNodes));
            }
        }
        return treeNode;
    }
}
