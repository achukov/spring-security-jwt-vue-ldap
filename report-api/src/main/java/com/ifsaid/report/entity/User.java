package com.ifsaid.report.entity;

import com.ifsaid.report.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "tb_user")
@Data
@EqualsAndHashCode(callSuper = false)
@GenericGenerator(name = "jpa-uuid", strategy = "uuid")
public class User extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(generator = "jpa-uuid")
    @Column(name = "t_uid")
    private String uid;

    @Column(name = "t_avatar")
    private String avatar;

    @Column(name = "t_account")
    private String account;

    @Column(name = "t_mail")
    private String mail;

    @Column(name = "t_employee_id")
    private String employeeId;

    @Column(name = "t_type")
    private String type;


    @Column(name = "t_phone")
    private String phone;

    @Column(name = "t_phone_other")
    private String phoneother;

    @Column(name = "t_office")
    private String office;

    @Column(name = "t_description")
    private String description;

    @Column(name = "t_state")
    private Integer state;

    @Column(name = "t_dept")
    private Integer dept;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "tb_user_role",
            joinColumns = @JoinColumn(name = "t_user_id"),
            inverseJoinColumns = @JoinColumn(name = "t_role_id"))
    private List<Role> roles = new ArrayList<>();


}