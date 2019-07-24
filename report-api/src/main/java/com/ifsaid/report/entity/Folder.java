package com.ifsaid.report.entity;

import com.ifsaid.report.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

@Entity
@Table(name = "tb_folder")
@Data
@EqualsAndHashCode(callSuper = false)
public class Folder extends BaseEntity implements Serializable, Comparable<Folder> {


    private static final long serialVersionUID = 552957933647337474L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "t_id")
    private Integer id;

    @Column(name = "t_parent_id")
    private Integer parentId;

    @Column(name = "t_level")
    private Integer level;

    // @Column(name = "t_rootId")
    // private Integer rootId;

    @Column(name = "t_title")
    private String title;

    @Column(name = "t_owner")
    private String owner;

    @Column(name = "t_ownersubs")
    private String ownersubs;

    @Column(name = "t_inherit")
    private Integer inherit;

    @Column(name = "t_fullpath")
    private String fullpath;

    @Transient
    private Set<Folder> children;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getOwnersubs() {
        return ownersubs;
    }

    public void setOwnersubs(String ownersubs) {
        this.ownersubs = ownersubs;
    }

    public Integer getInherit() {
        return inherit;
    }

    public void setInherit(Integer inherit) {
        this.inherit = inherit;
    }

    public String getFullpath() {
        return fullpath;
    }

    public void setFullpath(String fullpath) {
        this.fullpath = fullpath;
    }

    public Set<Folder> getChildren() {
        return children;
    }

    public void setChildren(Set<Folder> children) {
        this.children = children;
    }

    @Override
    public int compareTo(Folder o) {
        return this.getTitle().compareTo(o.getTitle());
    }
}