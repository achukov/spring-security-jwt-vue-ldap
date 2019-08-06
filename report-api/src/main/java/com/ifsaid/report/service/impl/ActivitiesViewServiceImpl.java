package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.enums.LdpEnum;
import com.ifsaid.report.service.IActivitiesViewService;
import lombok.extern.slf4j.Slf4j;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.image.ProcessDiagramGenerator;
import org.activiti.spring.ProcessEngineFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
public class ActivitiesViewServiceImpl implements IActivitiesViewService {

    private final RepositoryService repositoryService;
    private final RuntimeService runtimeService;
    private final TaskService taskService;
    private final HistoryService historyService;
    private final ProcessEngineFactoryBean processEngine;

    @Autowired
    public ActivitiesViewServiceImpl(RepositoryService repositoryService, RuntimeService runtimeService,
                                     TaskService taskService, HistoryService historyService, ProcessEngineFactoryBean processEngine) {
        this.repositoryService = repositoryService;
        this.runtimeService = runtimeService;
        this.taskService = taskService;
        this.historyService = historyService;
        this.processEngine = processEngine;
    }

    @Override
    public InputStream checkNowProcessActivitiesById(String id) {
        String processInstanceBusinessKey = LdpEnum.PROCESS_DEFINE_KEY.getCode() + ":" + id;

        List<Task> task = taskService.createTaskQuery().processInstanceBusinessKey(processInstanceBusinessKey).list();
        Execution execution = runtimeService.createExecutionQuery().executionId(task.getExecutionId()).singleResult();
        String activityId = execution.getActivityId();
        String processDefinitionId = task.getProcessDefinitionId();
        ProcessEngine defaultProcessEngine = ProcessEngines.getDefaultProcessEngine();
        ProcessEngineConfigurationImpl processEngineConfiguration = (ProcessEngineConfigurationImpl) defaultProcessEngine
                .getProcessEngineConfiguration();
        ProcessDiagramGenerator processDiagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);

        List<String> hightLightElements = new ArrayList<>();

        hightLightElements.add(activityId);
        InputStream imageStream;
        imageStream = processDiagramGenerator.generateDiagram(bpmnModel, "PNG", hightLightElements,
                new ArrayList<>(), "Lucida", "Lucida", "Lucida", processEngineConfiguration.getClassLoader(), 1.0);

        return imageStream;

    }

}
