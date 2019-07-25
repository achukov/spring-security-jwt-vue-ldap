package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.CommentModel;
import com.ifsaid.report.entity.Ldp;
import com.sun.javafx.collections.MappingChange;
import org.activiti.engine.task.Comment;

import java.util.List;
import java.util.Map;

public interface ICompleteTaskService extends IBaseService<Ldp, Long> {
    Map<String, Object> getItemById(String taskId);
    List<CommentModel> getCommentsByTaskId(String taskId);
    void completeTask(Map<String, String> paramMap) throws Exception;
}
