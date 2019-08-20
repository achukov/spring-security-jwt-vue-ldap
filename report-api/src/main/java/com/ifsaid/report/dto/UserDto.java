package com.ifsaid.report.dto;

import com.ifsaid.report.entity.Dept;
import com.ifsaid.report.entity.Role;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.vo.ButtonVo;
import com.ifsaid.report.vo.MenuVo;
import lombok.Data;

import java.util.Date;
import java.util.List;
import java.util.Set;

@Data
public class UserDto {

    private String uid;
    private String avatar;
    private String account;
    private String mail;
    private String employeeId;
    private String type;
    private String phone;
    private String phoneother;
    private String office; 
    private String description; 
    private Integer state;
    private Integer dept;
    private Dept department;
    private Set<Role> roles;
    private Date createTime;
    private Date upTime;

    private Set<ButtonVo> buttons;
    private Set<MenuVo> menus;

     public User toUser() {
        User user = new User();
        user.setAvatar(this.avatar);
        user.setAccount(this.account);
        user.setType(this.type);
        user.setMail(this.mail);

        return user;
    }

//    public static UserDto fromUser(User user){
//         UserDto userDto = new UserDto();
//
//    }

    public UserDto(String mail) {
        this.mail = mail;
    }

    public UserDto(String uid, String employeeId, String avatar, String type, String account, String mail) {
        this.uid = uid;
        this.employeeId = employeeId;
        this.avatar = avatar;
        this.type = type;
        this.account = account;
        this.mail = mail;
    }

    public UserDto(String uid, String avatar, String type, String account, String mail, String employeeId, String phone, Integer state, Dept department, Set<Role> roles, Date createTime, Date upTime) {
        this.uid = uid;
        this.avatar = avatar;
        this.type = type;
        this.account = account;
        this.mail = mail;
        this.employeeId = employeeId;
        this.phone = phone;
        this.state = state;
        this.department = department;
        this.roles = roles;
        this.createTime = createTime;
        this.upTime = upTime;
    }


}
