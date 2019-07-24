package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Pass;
import com.ifsaid.report.entity.Category;

import java.util.List;

public interface ICategoryService extends IBaseService<Category, Integer> {

    List<Category> findAllByRegion(String region);

}
