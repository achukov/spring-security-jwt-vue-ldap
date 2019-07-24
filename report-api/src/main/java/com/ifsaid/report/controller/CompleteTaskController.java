package com.ifsaid.report.controller;

import com.ifsaid.report.service.ICompleteTaskService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "All Activities")
@RestController
@RequestMapping(value = "/completeTask")
public class CompleteTaskController {

   private final ICompleteTaskService completeTaskService;

    @Autowired
    public CompleteTaskController(ICompleteTaskService completeTaskService) {
        this.completeTaskService = completeTaskService;
    }

    @GetMapping(value = "/getItemById")
    public ResponseJsonResult getItemById(@RequestParam(name = "taskId") String taskId) {
        Map<String, Object> map = completeTaskService.getItemById(taskId);
        return ResponseJsonResult.successResult(map);
    }
}
