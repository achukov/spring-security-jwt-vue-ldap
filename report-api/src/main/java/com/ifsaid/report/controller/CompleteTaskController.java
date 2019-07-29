package com.ifsaid.report.controller;

import com.ifsaid.report.entity.CommentModel;
import com.ifsaid.report.service.ICompleteTaskService;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Api(tags = "All Activities")
@RestController
@RequestMapping(value = "/completeTask")
public class CompleteTaskController {

   private final ICompleteTaskService completeTaskService;

    @Autowired
    public CompleteTaskController(ICompleteTaskService completeTaskService) {
        this.completeTaskService = completeTaskService;
    }

    @GetMapping(value = "/getTaskById")
    public Result getTaskById(@RequestParam(name = "taskId") String taskId) {
        Map<String, Object> map = completeTaskService.getTaskById(taskId);
        return Result.success(map);
    }

    @GetMapping(value = "/getCommentsByTaskId")
    public List<CommentModel> getCommentsByTaskId(@RequestParam(name = "taskId") String taskId) {
        List<CommentModel> list = completeTaskService.getCommentsByTaskId(taskId);
        return list;
    }

    @PostMapping
    public Result completeTask(@RequestBody Map<String, String> paramMap) {
        try {
            completeTaskService.completeTask(paramMap);
            return Result.success("Successful task");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success("Task failure");
        }
    }
}
