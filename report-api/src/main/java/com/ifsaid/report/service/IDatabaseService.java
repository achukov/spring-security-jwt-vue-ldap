package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.entity.Database;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IDatabaseService extends IBaseService<Database, Integer> {

    List<Database> findAllByOwner(String region);

    Page<Database> findAll(MyPage page);


}
