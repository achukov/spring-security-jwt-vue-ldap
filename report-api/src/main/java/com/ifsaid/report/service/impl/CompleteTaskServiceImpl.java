package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Comment;
import com.ifsaid.report.entity.Ldp;
import com.ifsaid.report.repository.LdpRepository;
import com.ifsaid.report.service.ICompleteTaskService;
import com.ifsaid.report.service.ILdpService;
import com.sun.javafx.collections.MappingChange;
import org.activiti.bpmn.model.FlowElement;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import java.util.*;

public class CompleteTaskServiceImpl extends BaseServiceImpl<Ldp, String, LdpRepository> implements ICompleteTaskService {

    private final ILdpService ldpService;
    private final RepositoryService repositoryService;
    private final RuntimeService runtimeService;
    private final TaskService taskService;

    public CompleteTaskServiceImpl(ILdpService ldpService, RepositoryService repositoryService, RuntimeService runtimeService, TaskService taskService) {
        this.ldpService = ldpService;
        this.repositoryService = repositoryService;
        this.runtimeService = runtimeService;
        this.taskService = taskService;
    }

    @Override
    public Map<String, Object> getItemById(String taskId) { //findById
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        String processInstanceId = task.getProcessInstanceId();
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        String businessKey = processInstance.getBusinessKey();
        String LdpId = businessKey.split(":")[1];

        Ldp LdpEntity = ldpService.findById(new Long(LdpId));
        List<String> sequenceFlowInfo = getSequenceFlowInfo(taskId);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("dataInfo", LdpEntity);
        resultMap.put("btnInfo", sequenceFlowInfo);

        return resultMap;
    }

    private List<String> getSequenceFlowInfo(String taskId) {
        List<String> resultList = new ArrayList<>();
        // 1. Query the task according to the task ID
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        // 2. get the process definition ID
        String processDefinitionId = task.getProcessDefinitionId();
        // 3. get all the connection collection
        Collection<FlowElement> flowElements = repositoryService.getBpmnModel(processDefinitionId).getMainProcess()
                .getFlowElements();
        // 4. get the execution instance ID
        String executionId = task.getExecutionId();
        // 5. get the execution instance
        Execution execution = runtimeService.createExecutionQuery().executionId(executionId).singleResult();
        // 6. get ActId
        String activityId = execution.getActivityId();
        // 7. get nodes for looping
        flowElements.forEach(item -> {
            if (item instanceof SequenceFlow) {
                SequenceFlow flow = (SequenceFlow) item;
                if (flow.getSourceRef().equals(activityId))
                    resultList.add(item.getName());
            }
        });
        return resultList;
    }

    @Override
    public List<Comment> getCommentsByTaskId(String taskId) {
        return null;
    }

    @Override
    public void completeTask(MappingChange.Map<String, String> paramMap) throws Exception {

    }
}
