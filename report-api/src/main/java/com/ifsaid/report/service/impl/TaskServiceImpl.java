package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.enums.LdpEnum;
import com.ifsaid.report.common.jwt.JwtTokenProvider;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.common.utils.SecurityUtils;
import com.ifsaid.report.dto.CommentDto;
import com.ifsaid.report.dto.TaskDto;
import com.ifsaid.report.vo.MyPage;
import com.ifsaid.report.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.HistoryService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.task.Comment;
import com.ifsaid.report.entity.Ldp;
import org.activiti.engine.task.TaskQuery;
import org.activiti.spring.ProcessEngineFactoryBean;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import com.ifsaid.report.repository.LdpRepository;
import com.ifsaid.report.service.ITaskService;
import com.ifsaid.report.service.ILdpService;
import org.activiti.bpmn.model.FlowElement;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class TaskServiceImpl extends BaseServiceImpl<Ldp, Long, LdpRepository> implements ITaskService {

    private final ILdpService ldpService;
    private final TaskService taskService;
    private final RuntimeService runtimeService;
    private final RepositoryService repositoryService;
    private final HistoryService historyService;
    private final ProcessEngineFactoryBean processEngine;
    private final JwtTokenProvider jwtTokenUtil;

    public TaskServiceImpl(ILdpService ldpService, RepositoryService repositoryService, RuntimeService runtimeService, TaskService taskService, HistoryService historyService, ProcessEngineFactoryBean processEngine, JwtTokenProvider jwtTokenUtil) {
        this.ldpService = ldpService;
        this.repositoryService = repositoryService;
        this.runtimeService = runtimeService;
        this.taskService = taskService;
        this.historyService = historyService;
        this.processEngine = processEngine;
        this.jwtTokenUtil = jwtTokenUtil;
    }

    @Override
    public Map<String, Object> getTaskById(String taskId) {
        Task task = taskService.createTaskQuery()
                .taskId(taskId).singleResult();
        ProcessInstance pi = runtimeService.createProcessInstanceQuery()
                .processInstanceId(task.getProcessInstanceId()).singleResult();

        String businessKey = pi.getBusinessKey();
        if (StringUtils.isNotBlank(businessKey)) {
            businessKey = businessKey.split(":")[1];
        }

        Ldp LdpEntity = ldpService.findById(Integer.valueOf(businessKey).longValue());
        List<String> sequenceFlowInfo = getSequenceFlowInfo(taskId);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("dataInfo", LdpEntity);
        resultMap.put("btnInfo", sequenceFlowInfo);

        return resultMap;
    }

    @Override
    public Page<TaskDto> getTaskByName(Pageable page, String token) {
        final String authToken = token.substring(this.jwtTokenUtil.getTokenHead().length());
        String username = jwtTokenUtil.getMailFromToken(authToken);
        TaskQuery taskQuery  = taskService.createTaskQuery().taskCandidateOrAssigned(username);

        List<TaskDto> taskDTOList = taskQuery.orderByTaskCreateTime().desc().list()
                .stream().map(task -> {
                    TaskDto dto = new TaskDto();
                    dto.setTaskId(task.getId());
                    dto.setTaskName(task.getName());
                    dto.setProcessInstanceId(task.getProcessInstanceId());
                    dto.setNodeKey(task.getTaskDefinitionKey());
                    dto.setCategory(task.getCategory());
                    dto.setTime(task.getCreateTime());
                    return dto;
                }).collect(Collectors.toList());
        return new PageImpl<>(taskDTOList, page, taskDTOList.size());

    }

    private List<String> getSequenceFlowInfo(String taskId) {
        List<String> resultList = new ArrayList<>();
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        String processDefinitionId = task.getProcessDefinitionId();
        Collection<FlowElement> flowElements = repositoryService.getBpmnModel(processDefinitionId).getMainProcess()
                .getFlowElements();
        String executionId = task.getExecutionId();
        Execution execution = runtimeService.createExecutionQuery().executionId(executionId).singleResult();
        String activityId = execution.getActivityId();
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
    public List<CommentDto> getCommentsByTaskId(String taskId) {
        Task task = taskService.createTaskQuery()
                .taskId(taskId)
                .singleResult();

        String processInstanceId = task.getProcessInstanceId();
        List<Comment> taskComments = taskService.getProcessInstanceComments(processInstanceId);
        ArrayList<CommentDto> commentModels = new ArrayList<>();

        taskComments.forEach(item -> {
            CommentDto commentModel = new CommentDto();
            BeanUtils.copyProperties(item, commentModel);
            commentModels.add(commentModel);
        });

        return commentModels;
    }

    @Override
    public void completeTask(Map<String, String> map) throws Exception {
        String comment = map.get("comment");
        String outcome = map.get("outcome");
        String taskId = map.get("taskId");
        String LdpId = map.get("LdpId");

        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        String processInstanceId = task.getProcessInstanceId();

        insertComment(taskId, processInstanceId, outcome, comment);
        completeTask(taskId, outcome);
//        updateStatus(processInstanceId, LdpId, outcome);

    }

    @Override
    public Long countTasksByUidAndCategoryId(String userId,String categoryId) {

        Long count = taskService.createTaskQuery()
                .taskCandidateOrAssigned(userId)
                .taskCategory(categoryId)
                .count();
        return count;
    }

    @Override
    public Ldp start(Long id) {
        Ldp ldapEntity = findById(id);
        ldapEntity.setStatus(LdpEnum.EXAMINATION.getCode());
        startProcessByKey(ldapEntity.getLid());
        return super.update(ldapEntity);
    }

    private void startProcessByKey(Long aLong) {
        String businessKey = LdpEnum.PROCESS_DEFINE_KEY.getCode() + ":" + aLong;
        // Process variable, the person in charge (first submission)
        Map<String, Object> variables = new HashMap<>();
        variables.put(LdpEnum.ASSIGNEE_USER.getCode(), SecurityUtils.getCurrentMail());
        // Startup process
        runtimeService.startProcessInstanceByKey(LdpEnum.PROCESS_DEFINE_KEY.getCode(), businessKey, variables);
    }

    private void insertComment(String taskId, String processInstanceId, String outcome, String comment) {
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
