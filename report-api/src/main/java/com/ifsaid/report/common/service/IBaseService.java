package com.ifsaid.report.common.service;

import com.ifsaid.report.common.exception.JpaCrudException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.io.Serializable;
import java.util.List;

public interface IBaseService<T, ID> {

    List<T> findAll();

    List<T> findAll(Sort sort);

    Page<T> findAll(Pageable page);

    T findById(ID id);

    T save(T entity) throws JpaCrudException;

    T update(T entity) throws JpaCrudException;

    void deleteById(ID id) throws JpaCrudException;

    boolean existsById(ID var1);

    // void deleteByIds(List<ID> idList);

}
