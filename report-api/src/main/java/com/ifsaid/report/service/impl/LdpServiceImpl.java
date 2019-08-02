package com.ifsaid.report.service.impl;

import java.util.HashMap;
import java.util.Map;

import com.ifsaid.report.common.enums.LdpEnum;
import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.common.utils.SecurityUtils;
import com.ifsaid.report.entity.Ldp;
import com.ifsaid.report.repository.LdpRepository;
import com.ifsaid.report.service.ILdpService;
import com.ifsaid.report.vo.MyPage;

import org.activiti.engine.RuntimeService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LdpServiceImpl extends BaseServiceImpl<Ldp, Long, LdpRepository> implements ILdpService {

    private final RuntimeService runtimeService;

    public LdpServiceImpl(RuntimeService runtimeService) {
        this.runtimeService = runtimeService;
    }

    @Override
    public Ldp findById(Long aLong) {
        return super.findById(aLong);
    }

    @Override
    public Ldp save(Ldp entity) throws JpaCrudException {
        if (entity.getProcStarted().equals(0)) {
            entity.setCreatedBy(SecurityUtils.getCurrentMail());
            entity.setProcStarted(1);
            entity.setStatus(LdpEnum.EXAMINATION.getCode());
            super.save(entity);
            startProcessByKey(entity.getLid());
            return entity;
        } else {
            return super.save(entity);
        }
    }

    private void startProcessByKey(Long aLong) {
        String businessKey = LdpEnum.PROCESS_DEFINE_KEY.getCode() + ":" + aLong;
        // Process variable, the person in charge (first submission)
        Map<String, Object> variables = new HashMap<>();
        variables.put(LdpEnum.ASSIGNEE_USER.getCode(), SecurityUtils.getCurrentMail());
        // Startup process
        runtimeService.startProcessInstanceByKey(LdpEnum.PROCESS_DEFINE_KEY.getCode(), businessKey, variables);
    }
    @Override
    public Ldp update(Ldp entity) throws JpaCrudException {
//        entity.setUpdatedBy(SecurityUtils.getCurrentMail());



        return super.update(entity);
    }

    @Override
    public void deleteById(Long aLong) throws JpaCrudException {
        super.deleteById(aLong);
    }

    @Override
    public Page<Ldp> findAll(MyPage page) {
        PageRequest pageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        Page<Ldp> all = null;
        if (page.getCid() != null && page.getCid() > 0) {
            // all = baseRepository.findAllByCategoryId(pageRequest, page.getCid());
            all = null;
        } else if (page.getSearch() != null && StringUtils.isNotEmpty(page.getSearch())) {
            all = baseRepository.findAllBySearch(pageRequest, page.getSearch());
        } else {
            all = baseRepository.findAll(pageRequest);
        }
        return all;
    }
}
