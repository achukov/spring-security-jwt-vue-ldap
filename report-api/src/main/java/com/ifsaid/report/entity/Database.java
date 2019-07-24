package com.ifsaid.report.entity;

import com.ifsaid.report.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "tb_database")
@Data
@EqualsAndHashCode(callSuper = false)
public class Database extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "t_did")
    private Integer did;

    @Column(name = "t_title")
    private String title;

    @Column(name = "t_path")
    private String path;

    @Column(name = "t_describe")
    private String describe;

    @Column(name = "t_owner")
    private String owner;

    @Column(name = "t_ownersubs")
    private String ownersubs;
}