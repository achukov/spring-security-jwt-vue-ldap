package com.ifsaid.report.common.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

@MappedSuperclass
@Getter
@Setter
@ToString
public class BaseEntity implements Serializable {

    @Column(name = "t_create_time")
    private Date createTime;

    @Column(name = "t_up_time")
    private Date upTime;

//    @Enumerated(EnumType.STRING)
//    @Column(name = "t_status")
//    private Status status;


}
