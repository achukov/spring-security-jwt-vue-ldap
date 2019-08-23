package com.ifsaid.report.entity;

import com.ifsaid.report.common.entity.BaseEntity;
import com.sun.org.apache.xpath.internal.operations.Bool;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "tb_pass")
@Data
@EqualsAndHashCode(callSuper = false)
public class Pass extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "t_psid")
    private long psid;

    @Column(name = "t_type")
    private String type;

    @Column(name = "t_startdate")
    private Date startdate;

    @Column(name = "t_enddate")
    private Date enddate;

    @Column(name = "t_visitors")
    private String visitors;

    @Column(name = "t_contactperson")
    private String contactperson;

    @Column(name = "t_phonenumber")
    private String phonenumber;

    @Column(name = "t_carnumber")
    private String carnumber;

    @Column(name = "t_cartype")
    private String cartype;

    @Column(name = "t_parklevel")
    private String parklevel;

    @Column(name = "t_parktype")
    private String parktype;

    @Column(name = "t_buildingaccess")
    private Integer buildingaccess;

    @Column(name = "t_comments")
    private String comments;

    @Column(name = "t_category_id")
    private Integer categoryId;

    @Column(name = "t_state")
    private Integer state;

    @Column(name = "t_nonwork")
    private Integer nonwork;

    @Column(name = "t_escort")
    private Integer escort;

    @Column(name = "t_created_by")
    private String createdBy;

    @Column(name = "t_updated_by")
    private String updatedBy;
    
    @Column(name = "t_history_log")
    private String historyLog;

}