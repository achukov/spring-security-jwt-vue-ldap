package com.ifsaid.report.entity;

import lombok.Data;

import java.util.Date;

@Data
public class CompleteTask {
    private String id;
    private String assignee;
    private String name;
    private Date createTime;
}
