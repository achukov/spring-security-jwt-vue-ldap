package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Folder;
import com.ifsaid.report.repository.FolderRepository;
import com.ifsaid.report.service.IFolderService;
import com.ifsaid.report.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import com.ifsaid.report.vo.MyPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Slf4j
@Service
public class FolderServiceImpl extends BaseServiceImpl<Folder, Integer, FolderRepository> implements IFolderService {

    private static final Integer ROOT = 0;

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void deleteById(Integer integer) throws JpaCrudException {
        if (baseRepository.countByParentId(integer) > 0) {
            throw new JpaCrudException("There are sub-folders under this folder and cannot be deleted!");
        }
        baseRepository.deleteById(integer);
    }


    private List<Folder> findRoots(List<Folder> allNodes) {
        List<Folder> root = new ArrayList<>();
        allNodes.forEach(node -> {
            if (node.getParentId() == ROOT) {
                root.add(node);
            }
        });

        root.forEach(node -> {
            findChildren(node, allNodes);
        });
        Collections.sort(root);
        return root;
    }

    private Folder findChildren(Folder treeNode, List<Folder> treeNodes) {

        for (Folder it : treeNodes) {
            if (treeNode.getId().equals(it.getParentId())) {
                if (treeNode.getChildren() == null) {
                    treeNode.setChildren(new TreeSet<>());
                }
                treeNode.getChildren().add(findChildren(it, treeNodes));
            }
        }
        return treeNode;
    }

    @Override
    public List<Folder> findAllTree() {
        List<Folder> folderList = baseRepository.findAll(Sort.by(Sort.Direction.ASC, "title"));
        return findRoots(folderList);
    }

    @Override
    public Page<Folder> findAll(MyPage page) {
        PageRequest pageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        Page<Folder> all = null;
         if (page.getSearch() != null && StringUtils.isNotEmpty(page.getSearch())) {
            all = baseRepository.findAllBySearch(pageRequest, page.getSearch());
        } else {
            all = baseRepository.findAll(pageRequest);
        }
        return all;
    }

}
