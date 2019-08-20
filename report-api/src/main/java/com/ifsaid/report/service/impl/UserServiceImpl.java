package com.ifsaid.report.service.impl;

import com.ifsaid.report.common.constant.PermissionType;
import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.exception.UserExistsException;
import com.ifsaid.report.common.jwt.JwtTokenProvider;
import com.ifsaid.report.common.jwt.JwtUser;
import com.ifsaid.report.common.jwt.JwtUserDetailsService;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.entity.Dept;
import com.ifsaid.report.entity.Permission;
import com.ifsaid.report.entity.Role;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.repository.UserRepository;
import com.ifsaid.report.service.*;
import com.ifsaid.report.vo.ButtonVo;
import com.ifsaid.report.vo.MenuVo;
import com.ifsaid.report.dto.UserDto;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class UserServiceImpl extends BaseServiceImpl<User, String, UserRepository> implements IUserService {


    private final AuthenticationManager authenticationManager;
    private final JwtUserDetailsService jwtUserDetailsService;
    private final JwtTokenProvider jwtTokenUtil;
    private final IPermissionService permissionService;
    private final IDeptService deptService;
    private final IRoleService roleService;

    @Autowired
    public UserServiceImpl(AuthenticationManager authenticationManager, JwtUserDetailsService jwtUserDetailsService,
                           JwtTokenProvider jwtTokenUtil, IPermissionService permissionService,
                           IDeptService deptService, IRoleService roleService) {
        this.authenticationManager = authenticationManager;
        this.jwtUserDetailsService = jwtUserDetailsService;
        this.jwtTokenUtil = jwtTokenUtil;
        this.permissionService = permissionService;
        this.deptService = deptService;
        this.roleService = roleService;
    }

    @Override
    public User findByAccount(String account) {
        return baseRepository.findByAccount(account);
    }

    @Override
    public User findByMail(String mail) {
        return baseRepository.findByMail(mail);
    }

    @Override
    public User findByEmployeeId(String employeeId) {
        return baseRepository.findByEmployeeId(employeeId);
    }

    @Override
    public UserDto findUserInfo(String account) {
        User user = findByAccount(account);
        UserDto result = new UserDto(user.getUid(), user.getEmployeeId(), user.getAvatar(), user.getType(), user.getAccount(), user.getMail());
        Set<Permission> permissions = permissionService.findAllByUserId(user.getUid());
        Set<ButtonVo> buttonVos = new HashSet<>();
        Set<MenuVo> menuVos = new HashSet<>();
        if (permissions != null && permissions.size() > 1) {
            permissions.forEach(permission -> {
                if (permission.getType().toLowerCase().equals(PermissionType.BUTTON)) {
                    buttonVos.add(new ButtonVo(permission.getPid(), permission.getResources(), permission.getTitle()));
                }
                if (permission.getType().toLowerCase().equals(PermissionType.MENU)) {
                    menuVos.add(new MenuVo(permission.getPid(), permission.getParentId(), permission.getIcon(), permission.getResources(), permission.getTitle()));
                }
            });
        }
        result.setButtons(buttonVos);
        result.setMenus(findRoots(menuVos));
        return result;
    }

    private Set<MenuVo> findRoots(Set<MenuVo> allNodes) {
        Set<MenuVo> root = new HashSet<>();
        allNodes.forEach(node -> {
            if (node.getFather() == 0) {
                root.add(node);
            }
        });
        root.forEach(node -> {
            findChildren(node, allNodes);
        });
        return root;
    }

    private MenuVo findChildren(MenuVo treeNode, Set<MenuVo> treeNodes) {
        for (MenuVo it : treeNodes) {
            if (treeNode.getPid().equals(it.getFather())) {
                if (treeNode.getChildren() == null) {
                    treeNode.setChildren(new ArrayList<MenuVo>());
                }
                treeNode.getChildren().add(findChildren(it, treeNodes));
            }
        }
        return treeNode;
    }


    @Override
    public String login(String username, String password) throws AuthenticationException {
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(username, password);
        Authentication authentication = authenticationManager.authenticate(usernamePasswordAuthenticationToken);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        JwtUser jwtUser = jwtUserDetailsService.loadUserByEmail(username);
        String token = jwtTokenUtil.generateToken(jwtUser, jwtUser.getUid(), jwtUser.getMail());
        return token;
    }

    @Override
    public User register(User user) throws UserExistsException {
        if (baseRepository.countByAccountOrMail(user.getAccount()) != null) {
            throw new UserExistsException(String.format("'%s' This user already exists", user.getAccount()));
        }
        // String rawPassword = user.getPassword();
        // user.setPassword(passwordEncoder.encode(rawPassword));
        user.setUpTime(new Date());
        user.setCreateTime(new Date());
        return baseRepository.save(user);
    }

    @Override
    public String refreshToken(String oldToken) {
        if (oldToken != null && StringUtils.isNotEmpty(oldToken)) {
            // The part after "Bearer "
            final String authToken = oldToken.substring(this.jwtTokenUtil.getTokenHead().length());
            return jwtTokenUtil.refreshToken(authToken);
        }
        return null;
    }

    @Override
    public int countByDept(Integer deptId) {
        return baseRepository.countByDept(deptId);
    }


    @Override
    public Page<UserDto> findAllInfo(Pageable page) {
        Page<User> all = findAll(page);
        List<UserDto> userVos = new ArrayList<>();
        all.forEach(user -> {
            Dept dept = deptService.findById(user.getDept());
            Set<Role> roles = roleService.findAllByUserId(user.getUid());
            UserDto userVo = new UserDto(user.getUid(),
                    user.getAvatar(), user.getType(),
                    user.getAccount(), user.getMail(), user.getEmployeeId(),
                    user.getDescription(), user.getState(), dept, roles,
                    user.getCreateTime(), user.getUpTime()
            );
            userVos.add(userVo);
        });
        return new PageImpl<>(userVos, page, all.getTotalElements());
    }

    @Override
    public User save(User entity) throws JpaCrudException {
        // String rawPassword = entity.getPassword();
        // entity.setPassword(passwordEncoder.encode(rawPassword));
        // entity.setOpenId(" ");
        return super.save(entity);
    }

    @Override
    public User update(User entity) throws JpaCrudException {
        User user = findById(entity.getUid());
        if (entity.getAccount() != null && entity.getAccount().trim() != "") {
            user.setAccount(entity.getAccount());
        }
        // if (entity.getPassword() != null && entity.getPassword().trim() != "") {
        //     String rawPassword = entity.getPassword();
        //     user.setPassword(passwordEncoder.encode(rawPassword));
        // }
        if (entity.getAvatar() != null && entity.getAvatar().trim() != "") {
            user.setAvatar(entity.getAvatar());
        }
        if (entity.getType() != null && entity.getType().trim() != "") {
            user.setType(entity.getType());
        }
        if (entity.getMail() != null && entity.getMail().trim() != "") {
            user.setMail(entity.getMail());
        }
        if (entity.getEmployeeId() != null && entity.getEmployeeId().trim() != "") {
            user.setEmployeeId(entity.getEmployeeId());
        }
        // if (entity.getBirthday() != null) {
        //     user.setBirthday(entity.getBirthday());
        // }
        if (entity.getDept() != null) {
            user.setDept(entity.getDept());
        }
        // if (entity.getGender() != null) {
        //     user.setGender(entity.getGender());
        // }
        if (entity.getState() != null) {
            user.setState(entity.getState());
        }
        return super.update(user);
    }

    @Override
    public List<User> findByDept(Integer deptId) {
        return baseRepository.findByDept(deptId);
    }


}
