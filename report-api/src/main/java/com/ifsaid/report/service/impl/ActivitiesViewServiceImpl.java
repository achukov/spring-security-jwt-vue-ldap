package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.enums.LdpEnum;
import com.ifsaid.report.service.IActivitiesViewService;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.*;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.task.Task;
import org.activiti.image.ProcessDiagramGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class ActivitiesViewServiceImpl implements IActivitiesViewService {

    private final RepositoryService repositoryService;
    private final RuntimeService runtimeService;
    private final TaskService taskService;

    @Autowired
    public ActivitiesViewServiceImpl(RepositoryService repositoryService, RuntimeService runtimeService,
                                     TaskService taskService) {
        this.repositoryService = repositoryService;
        this.runtimeService = runtimeService;
        this.taskService = taskService;
    }

    /**
     * View flow chart based on Document ID
     *
     * We use the image generator (which comes with Activiti) to generate images.
     * Need to get the process engine, then configure and get from the process engine
     *
     * @param Id Doc ID
     * @return Picture stream
     */
    @Override
    public InputStream checkNowProcessActivitiesById(String Id) {
        // Assembled into BusinessKey
        String processInstanceBusinessKey = LdpEnum.PROCESS_DEFINE_KEY.getCode() + ":" + Id;
        // Query task objects based on BusinessKey
        Task task = taskService.createTaskQuery().processInstanceBusinessKey(processInstanceBusinessKey).singleResult();
        // Get execution instance
        Execution execution = runtimeService.createExecutionQuery().executionId(task.getExecutionId()).singleResult();
        // Get activityId
        String activityId = execution.getActivityId();
        // Get process definition ID
        String processDefinitionId = task.getProcessDefinitionId();
        // Get process engine
        ProcessEngine defaultProcessEngine = ProcessEngines.getDefaultProcessEngine();
        // Get engine configuration
        ProcessEngineConfigurationImpl processEngineConfiguration = (ProcessEngineConfigurationImpl) defaultProcessEngine
                .getProcessEngineConfiguration();

        // Get the default image generator
        ProcessDiagramGenerator processDiagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();
        // Get the bpmnModel of the flowchart to be generated
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
        // Set the nodes that need to be highlighted
        List<String> hightLightElements = new ArrayList<>();
        hightLightElements.add(activityId);
        // Return to the image stream, if the font is not set, Chinese will be garbled
        InputStream imageStream;
        imageStream = processDiagramGenerator.generateDiagram(bpmnModel, "PNG", hightLightElements,
                new ArrayList<>(), "Lucida", "Lucida", "Lucida", processEngineConfiguration.getClassLoader(), 1.0);

        return imageStream;
    }

}
