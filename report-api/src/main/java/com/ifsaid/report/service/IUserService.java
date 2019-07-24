package com.ifsaid.report.service;

import java.util.List;

import com.ifsaid.report.common.exception.UserExistsException;
import com.ifsaid.report.common.service.IBaseService;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.vo.UserVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.AuthenticationException;

public interface IUserService extends IBaseService<User, String> {

    User findByAccount(String account);

    User findByMail(String mail);

    User findByEmployeeId(String employeeId);

    UserVo findUserInfo(String account);

    String login(String username, String password) throws AuthenticationException;

    User register(User user) throws UserExistsException;

    String refreshToken(String oldToken);

    int countByDept(Integer deptId);

    List<User> findByDept(Integer deptId);

    Page<UserVo> findAllInfo(Pageable page);


}
