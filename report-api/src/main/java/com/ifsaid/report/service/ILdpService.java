
package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Ldp;
import com.ifsaid.report.vo.MyPage;
import org.springframework.data.domain.Page;

import java.util.Set;

public interface ILdpService extends IBaseService<Ldp, Long> {

    Page<Ldp> findAll(MyPage page);
    Ldp start(Long id);

}
