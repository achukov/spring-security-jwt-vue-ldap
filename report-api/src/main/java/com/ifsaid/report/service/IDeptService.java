package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Dept;

import java.util.Set;

public interface IDeptService extends IBaseService<Dept, Integer> {

    Set<Dept> findAllTree();

}
