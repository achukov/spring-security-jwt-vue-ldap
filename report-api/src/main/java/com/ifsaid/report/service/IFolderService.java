package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Folder;
import com.ifsaid.report.vo.MyPage;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Set;

public interface IFolderService extends IBaseService<Folder, Integer> {

    List<Folder> findAllTree();
    // Set<Node> findByParentId(Integer id);
    Page<Folder> findAll(MyPage page);

}
