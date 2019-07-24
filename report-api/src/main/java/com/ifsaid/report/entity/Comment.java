package com.ifsaid.report.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Comment {
    private String userId;
    private Date time;
    private String message;
}
