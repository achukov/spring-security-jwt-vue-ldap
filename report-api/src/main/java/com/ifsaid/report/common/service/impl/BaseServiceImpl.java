package com.ifsaid.report.common.service.impl;

import com.ifsaid.report.common.entity.BaseEntity;
import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.service.IBaseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;


import java.util.Date;
import java.util.List;
import java.util.Optional;

@Slf4j
public class BaseServiceImpl<T extends BaseEntity, ID, R extends JpaRepository> implements IBaseService<T, ID> {

    @Autowired
    protected R baseRepository;

    @Transactional(readOnly = true, rollbackFor = RuntimeException.class)
    @Override
    public List<T> findAll() {
        return baseRepository.findAll();
    }

    @Transactional(readOnly = true, rollbackFor = RuntimeException.class)
    @Override
    public List<T> findAll(Sort sort) {
        return baseRepository.findAll(sort);
    }

    @Transactional(readOnly = true, rollbackFor = RuntimeException.class)
    @Override
    public Page<T> findAll(Pageable page) {
        log.info("findAll PageNumber: {} => PageSize: {}", page.getPageNumber(), page.getPageSize());
        return baseRepository.findAll(page);
    }

    @Override
    public T findById(ID id) {
        log.info("findById: {}", id);
        Optional byId = baseRepository.findById(id);
        return (T) byId.get();
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public T save(T entity) throws JpaCrudException {
        if (entity == null) {
            throw new JpaCrudException("You cannot save an empty entity class.");
        }
        entity.setCreateTime(new Date());
        entity.setUpTime(new Date());
        log.info("save: {}", entity);
        return (T) baseRepository.saveAndFlush(entity);
    }
    
    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public T update(T entity) throws JpaCrudException {
        if (entity == null) {
            throw new JpaCrudException("You cannot update an empty entity class.");
        }
        entity.setUpTime(new Date());
        log.info("update: {}", entity);
        return (T) baseRepository.saveAndFlush(entity);
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void deleteById(ID id) throws JpaCrudException {
        if (id == null || !baseRepository.existsById(id)) {
            throw new JpaCrudException("Unable to delete data, but Id does not exist.");
        }
        log.info("deleteById: {}", id);
        baseRepository.deleteById(id);
    }

    @Override
    public boolean existsById(ID var1) {
        log.info("existsById: {}", var1);
        return baseRepository.existsById(var1);
    }

    // @Transactional(rollbackFor = RuntimeException.class)
    // @Override
    // public void deleteByIds(List<ID> idList) {
    //     return baseRepository.deleteByIds(idList);
    // }

}
