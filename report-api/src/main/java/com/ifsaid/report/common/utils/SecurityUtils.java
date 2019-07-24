package com.ifsaid.report.common.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import com.ifsaid.report.common.jwt.JwtUser;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Collection;

@Slf4j
public class SecurityUtils {

    private SecurityUtils() {
    }

    /**
     * Get the login of the current user.
     *
     * @return the login of the current user
     */
    public static String getCurrentUserLogin() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        String userName = null;
        if (authentication != null) {
            if (authentication.getPrincipal() instanceof UserDetails) {
                UserDetails springSecurityUser = (UserDetails) authentication.getPrincipal();
                userName = springSecurityUser.getUsername();
            } else if (authentication.getPrincipal() instanceof String) {
                userName = (String) authentication.getPrincipal();
            }
        }
        return userName;
    }

    /**
     * If the current user has a specific authority (security role).
     *
     * <p>The name of this method comes from the isUserInRole() method in the Servlet API</p>
     *
     * @param authority the authority to check
     * @return true if the current user has the authority, false otherwise
     */
    public static boolean isCurrentUserInRole(String authority) {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        if (authentication != null) {
            if (authentication.getPrincipal() instanceof UserDetails) {
                UserDetails springSecurityUser = (UserDetails) authentication.getPrincipal();
                return springSecurityUser.getAuthorities().contains(new SimpleGrantedAuthority(authority));
            }
        }
        return false;
    }

  /*  public static String getCurrentUserTenant() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        String tenantCode = "admin";
        if (authentication != null) {
            if (authentication.getPrincipal() instanceof UserTenant) {
                UserTenant springSecurityUser = (UserTenant) authentication.getPrincipal();
                tenantCode = springSecurityUser.getTenantCode();
            } else if (authentication.getPrincipal() instanceof String) {
                tenantCode = (String) authentication.getPrincipal();
            }
        }
        return tenantCode;
    }*/

    public static String getCurrentUserAuthority() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        String str = null;
        if (authentication != null) {
            if (authentication.getPrincipal() instanceof UserDetails) {
                UserDetails springSecurityUser = (UserDetails) authentication.getPrincipal();
                Object[] obj = springSecurityUser.getAuthorities().toArray();
                for(Object item : obj){
                    if(item  instanceof  GrantedAuthority){
                        GrantedAuthority grantedAuthority=(GrantedAuthority)item;
                        if(str!=null){
                            str+=",";
                        }
                        str += grantedAuthority.getAuthority();
                    }
                }
            }
        }
        return str;
    }

    public static Authentication getCurrentAuthenticateObject()  {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    public static UserDetails getCurrentUserDetails()  {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return (UserDetails)principal;
        }
        return null;
    }

    public static String getCurrentMail()  {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof JwtUser) {
            username = ((JwtUser)principal).getMail();
        } else if(principal instanceof String) {
            username = principal.toString();
        } else
            throw new UsernameNotFoundException("user does not exist.");
        return username;

    }
}