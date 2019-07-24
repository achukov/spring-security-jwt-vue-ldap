package com.ifsaid.report.common.jwt;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ifsaid.report.entity.User;


import lombok.ToString;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.ldap.userdetails.LdapUserDetails;

import java.util.Collection;

@ToString
public class JwtUser implements UserDetails {

    private String uid;
    private String mail;
    private String username;
    private String password;
    private Integer state;
    private Collection<? extends GrantedAuthority> authorities;

    public JwtUser() {
    }

    public JwtUser(String uid, String mail, String username, String password,
                   Integer state, Collection<? extends GrantedAuthority> authorities) {
        this.uid = uid;
        this.mail = mail;
        this.username = username;
        this.password = password;
        this.state = state;
        this.authorities = authorities;
    }

    public String getUid() {
        return uid;
    }

    public String getMail() {
        return mail;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @JsonIgnore
    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @JsonIgnore
    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @JsonIgnore
    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @JsonIgnore
    @Override
    public boolean isEnabled() {
        return false;
    }

    @Override
    public String getPassword() {
        return password;
    }

    public Integer getState() {
        return state;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }


}
