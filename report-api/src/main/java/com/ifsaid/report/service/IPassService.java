package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Pass;
import com.ifsaid.report.vo.MyPage;
import org.springframework.data.domain.Page;

public interface IPassService extends IBaseService<Pass, Long> {

    Page<Pass> findAll(MyPage page);
    Page<Pass> findAllbyAuthor(MyPage page, String token);
}
