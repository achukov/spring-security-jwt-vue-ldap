package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Database;
import com.ifsaid.report.repository.DatabaseRepository;
import com.ifsaid.report.service.IDatabaseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.ifsaid.report.vo.MyPage;
import org.springframework.data.domain.Sort;
import org.apache.commons.lang3.StringUtils;

import java.util.List;

@Slf4j
@Service
public class DatabseServiceImpl extends BaseServiceImpl<Database, Integer, DatabaseRepository> implements IDatabaseService {
    
    @Override
    public List<Database> findAllByOwner(String owner) {
        return baseRepository.findAllByOwner(owner);
    }

    @Override
    public Page<Database> findAll(MyPage page) {
        PageRequest pageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        Page<Database> all = null;
         if (page.getSearch() != null && StringUtils.isNotEmpty(page.getSearch())) {
            all = baseRepository.findAllBySearch(pageRequest, page.getSearch());
        } else {
            all = baseRepository.findAll(pageRequest);
        }
        return all;
    }
}
