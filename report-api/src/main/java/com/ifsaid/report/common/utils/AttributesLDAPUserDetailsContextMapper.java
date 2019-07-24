package com.ifsaid.report.common.utils;

import com.ifsaid.report.common.jwt.JwtUserFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.ldap.userdetails.InetOrgPerson;
import org.springframework.security.ldap.userdetails.InetOrgPersonContextMapper;
import org.springframework.security.ldap.userdetails.LdapUserDetails;
import org.springframework.security.ldap.userdetails.LdapUserDetailsImpl;
import org.springframework.security.ldap.userdetails.LdapUserDetailsMapper;
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper;
import org.apache.commons.lang3.StringUtils;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import com.ifsaid.report.common.jwt.JwtUser;
import com.ifsaid.report.entity.Role;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.repository.RoleRepository;
import com.ifsaid.report.service.IRoleService;
import com.ifsaid.report.service.IUserService;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class AttributesLDAPUserDetailsContextMapper implements UserDetailsContextMapper {

    @Autowired
    private IUserService userService;

	@Autowired
    private IRoleService roleService;

    private static final int DEFAULT_ROLE = 6;
    
    private InetOrgPersonContextMapper adUserDetailsMapper  = new InetOrgPersonContextMapper();

    @Override
    public UserDetails mapUserFromContext(DirContextOperations ctx, String mail, Collection<? extends GrantedAuthority> collection) {
        Set<Integer> role = new LinkedHashSet<Integer>();
        role.add(DEFAULT_ROLE);

        InetOrgPerson userLdap = (InetOrgPerson) adUserDetailsMapper.mapUserFromContext(ctx, mail, collection);

        User user = userService.findByMail(userLdap.getMail().trim());
        if (user == null) {
            user = new User();
            user.setAccount(StringUtils.defaultString(userLdap.getDisplayName()).trim());
            user.setMail(StringUtils.defaultString(userLdap.getMail()).trim());
            user.setDept(1);
            if (ctx.getAttributes().get("sAMAccountName") != null) {
            user.setEmployeeId(StringUtils.defaultString(ctx.getStringAttribute("sAMAccountName").trim()));
            }
            if (ctx.getAttributes().get("extensionAttribute2") != null) {
              user.setType(StringUtils.defaultString(ctx.getStringAttribute("extensionAttribute2").trim()));
            }
            if (ctx.getAttributes().get("telephoneNumber") != null) {
              user.setPhone(StringUtils.defaultString(ctx.getStringAttribute("telephoneNumber").trim()));
            }
            if (ctx.getAttributes().get("otherTelephone") != null) {
              user.setPhoneother(StringUtils.defaultString(ctx.getStringAttribute("otherTelephone").trim()));
            }
            if (ctx.getAttributes().get("physicalDeliveryOfficeName") != null) {
               user.setOffice(StringUtils.defaultString(ctx.getStringAttribute("physicalDeliveryOfficeName").trim()));
            }
            user.setDescription(StringUtils.defaultString(userLdap.getDescription()).trim());
            
            userService.save(user);

            roleService.updateUserRole(user.getUid(), role);
        }
        JwtUser jwtUser = JwtUserFactory.create(user);
        log.info("IN mapUserFromContext - user with account: {} successfully loaded", user);
        return jwtUser;
    }

    @Override
    public void mapUserToContext(UserDetails userDetails, DirContextAdapter dirContextAdapter) {
        adUserDetailsMapper.mapUserToContext(userDetails, dirContextAdapter);
    }
}

