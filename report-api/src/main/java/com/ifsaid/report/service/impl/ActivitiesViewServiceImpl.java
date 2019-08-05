package com.ifsaid.report.service.impl;

import com.ifsaid.report.service.IActivitiesViewService;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.context.Context;
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
//        String processInstanceBusinessKey = LdpEnum.PROCESS_DEFINE_KEY.getCode() + ":" + Id;
//        Task task = taskService.createTaskQuery().processInstanceBusinessKey(processInstanceBusinessKey).singleResult();
//        Execution execution = runtimeService.createExecutionQuery().executionId(task.getExecutionId()).singleResult();
//        String activityId = execution.getActivityId();
//        String processDefinitionId = task.getProcessDefinitionId();
//        ProcessEngine defaultProcessEngine = ProcessEngines.getDefaultProcessEngine();
//        ProcessEngineConfigurationImpl processEngineConfiguration = (ProcessEngineConfigurationImpl) defaultProcessEngine
//                .getProcessEngineConfiguration();
//        ProcessDiagramGenerator processDiagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();
//        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
//        List<String> hightLightElements = new ArrayList<>();
//        hightLightElements.add(activityId);
//        InputStream imageStream;
//        imageStream = processDiagramGenerator.generateDiagram(bpmnModel, "PNG", hightLightElements,
//                new ArrayList<>(), "Lucida", "Lucida", "Lucida", processEngineConfiguration.getClassLoader(), 1.0);
//
//        return imageStream;
        Task task = taskService.createTaskQuery()
                .taskId(id)
                .singleResult();

        String processInstanceId = task.getProcessInstanceId();
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();

        HistoricProcessInstance historicProcessInstance =
                historyService.createHistoricProcessInstanceQuery()
                        .processInstanceId(processInstanceId).singleResult();
        String processDefinitionId = null;
        List<String> executedActivityIdList = new ArrayList<>();
        if (processInstance != null) {
            processDefinitionId = processInstance.getProcessDefinitionId();
            executedActivityIdList = this.runtimeService.getActiveActivityIds(processInstance.getId());
        } else if (historicProcessInstance != null) {
            processDefinitionId = historicProcessInstance.getProcessDefinitionId();
            executedActivityIdList = historyService.createHistoricActivityInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .orderByHistoricActivityInstanceId().asc().list()
                    .stream().map(HistoricActivityInstance::getActivityId)
                    .collect(Collectors.toList());
        }

        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
        ProcessEngineConfiguration processEngineConfiguration = processEngine.getProcessEngineConfiguration();
        Context.setProcessEngineConfiguration((ProcessEngineConfigurationImpl) processEngineConfiguration);
        ProcessDiagramGenerator diagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();

        return diagramGenerator.generateDiagram(
                bpmnModel, "png",
                executedActivityIdList, Collections.emptyList(),
                "宋体",
                "宋体",
                "宋体",
                null, 1.0);
    }

}
