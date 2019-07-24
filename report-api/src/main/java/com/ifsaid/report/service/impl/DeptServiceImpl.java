package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Dept;
import com.ifsaid.report.repository.DeptRepository;
import com.ifsaid.report.service.IDeptService;
import com.ifsaid.report.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
public class DeptServiceImpl extends BaseServiceImpl<Dept, Integer, DeptRepository> implements IDeptService {


    private final IUserService userService;

    public DeptServiceImpl(@Lazy IUserService userService) {
        this.userService = userService;
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void deleteById(Integer integer) throws JpaCrudException {
        if (baseRepository.countByParentId(integer) > 0) {
            throw new JpaCrudException("There are sub-departments under this department and cannot be deleted!");
        }
        if (userService.countByDept(integer) > 0) {
            throw new JpaCrudException("There are users under this department and cannot be deleted!");
        }
        baseRepository.deleteById(integer);
    }


    private Set<Dept> findRoots(List<Dept> allNodes) {
        Set<Dept> root = new HashSet<>();
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

    private Dept findChildren(Dept treeNode, List<Dept> treeNodes) {
        for (Dept it : treeNodes) {
            if (treeNode.getId().equals(it.getParentId())) {
                if (treeNode.getChildren() == null) {
                    treeNode.setChildren(new HashSet<>());
                }
                treeNode.getChildren().add(findChildren(it, treeNodes));
            }
        }
        return treeNode;
    }


    @Override
    public Set<Dept> findAllTree() {
        List<Dept> deptList = baseRepository.findAll(Sort.by(Sort.Direction.DESC, "upTime"));
        return findRoots(deptList);
    }

}
