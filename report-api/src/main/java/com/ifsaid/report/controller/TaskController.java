package com.ifsaid.report.controller;

import com.ifsaid.report.dto.CommentDto;
import com.ifsaid.report.dto.TaskDto;
import com.ifsaid.report.service.ILdpService;
import com.ifsaid.report.service.ITaskService;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@Api(tags = "All Activities")
@RestController
@RequestMapping(value = "/task")
public class TaskController {

   private final ITaskService taskService;
   private final ILdpService ldpService;

    @Autowired
    public TaskController(ITaskService taskService, ILdpService ldpService) {
        this.taskService = taskService;
        this.ldpService = ldpService;
    }
    @GetMapping("/getTaskByName")
    public Result<Page<TaskDto>> todo(MyPage page, @RequestHeader(value = "${jwt.tokenHeader}") String token) {
        PageRequest pageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        return Result.success(taskService.getTaskByName(pageRequest, token));
    }

    @GetMapping(value = "/getTaskById/{id}")
    public Result getTaskById(@PathVariable String id) {
        Map<String, Object> map = taskService.getTaskById(id);
        return Result.success(map);
    }

    @GetMapping(value = "/getCommentsByTaskId")
    public List<CommentDto> getCommentsByTaskId(@RequestParam(name = "taskId") String taskId) {
        List<CommentDto> list = taskService.getCommentsByTaskId(taskId);
        return list;
    }

    @PostMapping("/start/{id}")
    public Result<String> start(@PathVariable Long id) {
        log.info("Start by Id : {}", id);
        try {
            taskService.start(id);
            return Result.success("Successful task");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success("TaskDto failure");
        }
    }

    @PostMapping("/complete")
    public Result completeTask(@RequestBody Map<String, String> map) {
        try {
            taskService.completeTask(map);
            return Result.success("Successful task");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success("TaskDto failure");
        }
    }
}
