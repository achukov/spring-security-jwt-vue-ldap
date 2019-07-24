package com.ifsaid.report.common.activiti.listiner;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;

@SuppressWarnings("serial")
public class NormalTaskCreateListener implements TaskListener {

    @Override
    public void notify(DelegateTask delegateTask) {

        String nextUser = (String) delegateTask.getVariable("NEXTUSER");
        if (nextUser != null) {
            delegateTask.setAssignee(nextUser);
        }
        String taskName = (String) delegateTask.getVariable("TASKNAME");
        if (taskName != null) {
            delegateTask.setDescription(taskName + "-" + delegateTask.getName());
            // delegateTask.setName(taskName+"-"+delegateTask.getName());
        } else {
            delegateTask.setDescription(delegateTask.getName());
        }

//        // Get current logged in
//        UserModel userModel = GlobalUtil.getCurrentUser();
//        // Get the LineManagerId
//        Long superiorId = userModel.getSuperiorId();
//        if (!GlobalUtil.isEmpty(superiorId)) {
//            // From ApplicationContext Obtain UserMapper
//            UserMapper userMapper = GlobalUtil.getBean(UserMapper.class);
//            // Get the user according to the ID, that is, get the superior leader
//            UserModel superiorUser = userMapper.selectById(superiorId);
//            // Set the next person to handle
//            delegateTask.setAssignee(superiorUser.getUsername());
        }
    }
