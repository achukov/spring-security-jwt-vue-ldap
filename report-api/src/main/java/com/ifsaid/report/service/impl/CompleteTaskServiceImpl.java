package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.enums.LdpEnum;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.common.utils.SecurityUtils;
import com.ifsaid.report.entity.CommentModel;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.task.Comment;
import com.ifsaid.report.entity.Ldp;
import org.springframework.beans.BeanUtils;
import com.ifsaid.report.repository.LdpRepository;
import com.ifsaid.report.service.ICompleteTaskService;
import com.ifsaid.report.service.ILdpService;
import org.activiti.bpmn.model.FlowElement;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class CompleteTaskServiceImpl extends BaseServiceImpl<Ldp, Long, LdpRepository> implements ICompleteTaskService {

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

        Ldp LdpEntity = ldpService.findById(Long.parseLong(LdpId));
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
    public List<CommentModel> getCommentsByTaskId(String taskId) {
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        String processInstanceId = task.getProcessInstanceId();
        List<Comment> taskComments = taskService.getProcessInstanceComments(processInstanceId);
        ArrayList<CommentModel> commentModels = new ArrayList<>();

        taskComments.forEach(item -> {
            CommentModel commentModel = new CommentModel();
            BeanUtils.copyProperties(item, commentModel);
            commentModels.add(commentModel);
        });

        return commentModels;
    }

    @Override
    public void completeTask(Map<String, String> paramMap) throws Exception {
        String comment = paramMap.get("comment");
        String outcome = paramMap.get("outcome");
        String taskId = paramMap.get("taskId");
        String LdpId = paramMap.get("LdpId");

        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        String processInstanceId = task.getProcessInstanceId();

        insertComment(taskId, processInstanceId, outcome, comment);
        completeTask(taskId, outcome);
//        updateStatus(processInstanceId, LdpId, outcome);

    }

    private void insertComment(String taskId, String processInstanceId, String outcome, String comment) {
        /**
         * Set up annotator
         * When setting annotation information in Activiti, he will automatically get the user in the current thread.
         * So we need to set the user variables in the current thread here.
         *
         * The specific location is: org.activiti.engine.impl.cmd.AddCommentCmd 95~96 lines of code
         *
         * String userId = Authentication.getAuthenticatedUserId();
         *	CommentEntity comment = commandContext.getCommentEntityManager().create();
         */
        String username = SecurityUtils.getCurrentMail();
        Authentication.setAuthenticatedUserId(username);

        // Add annotation information
        taskService.addComment(taskId, processInstanceId, "[" + outcome + "]" + comment);
    }

    private void completeTask(String taskId, String outcome) {
        Map<String, Object> variables = new HashMap<>();
        variables.put(LdpEnum.OUTCOME.getCode(), outcome);

        taskService.complete(taskId, variables);
    }

    private void updateStatus(String processInstanceId, String LdpId, String outcome) {
        // First judge whether the process is over
//        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
//                .processInstanceId(processInstanceId).singleResult();
//
//
//        if (GlobalUtil.isEmpty(processInstance)) {
//            // There are two situations in the process of modifying the object information process:
//            // the approval is all passed, and the end is abandoned....
//            if (outcome.equals("give up")) {
//                // Modify the status
//                ldpService.set(LdpEnum.GIVE_UP.getCode());
//            } else {
//                leaveBillModel.setStatus(LdpEnum.COMPLETE.getCode());
//            }
//            leaveBillMapper.updateById(leaveBillModel);
//        } else {
//            if (outcome.equals("turn down")) {
//
//                leaveBillModel.setStatus(LeaveBillEnum.TURN_DOWN.getCode());
//                leaveBillMapper.updateById(leaveBillModel);
//            }
//        }
    }

}
