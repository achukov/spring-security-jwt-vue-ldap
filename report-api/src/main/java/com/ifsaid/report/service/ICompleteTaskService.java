package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.Comment;
import com.ifsaid.report.entity.Ldp;
import com.sun.javafx.collections.MappingChange;

import java.util.List;
import java.util.Map;

public interface ICompleteTaskService extends IBaseService<Ldp, String> {
    Map<String, Object> getItemById(String taskId);
    List<Comment> getCommentsByTaskId(String taskId);
    void completeTask(MappingChange.Map<String, String> paramMap) throws Exception;
}
