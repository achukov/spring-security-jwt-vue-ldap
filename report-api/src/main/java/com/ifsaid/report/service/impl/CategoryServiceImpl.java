package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Category;
import com.ifsaid.report.repository.CategoryRepository;
import com.ifsaid.report.service.ICategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@CacheConfig(cacheNames = "categorys")
public class CategoryServiceImpl extends BaseServiceImpl<Category, Integer, CategoryRepository> implements ICategoryService {

    @Override
    @Cacheable(key = "#p0")
    public List<Category> findAllByRegion(String region) {
        return baseRepository.findAllByRegion(region);
    }

    @Override
    @CacheEvict(key = "#p0", allEntries = true)
    public void deleteById(Integer integer) throws JpaCrudException {
        super.deleteById(integer);
    }

}
