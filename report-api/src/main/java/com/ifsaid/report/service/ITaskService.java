package com.ifsaid.report.service;

import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.dto.CommentDto;
import com.ifsaid.report.dto.TaskDto;
import com.ifsaid.report.entity.Ldp;
import com.ifsaid.report.vo.MyPage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface ITaskService extends IBaseService<Ldp, Long> {
    Map<String, Object> getTaskById(String taskId);
    List<CommentDto> getCommentsByTaskId(String taskId);
    void completeTask(Map<String, String> paramMap) throws Exception;
    public Long countTasksByUidAndCategoryId(String userId,String categoryId);
    Page<TaskDto> getTaskByName(Pageable page, String token);

}
