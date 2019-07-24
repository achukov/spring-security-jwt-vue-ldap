package com.ifsaid.report.vo;

import lombok.Data;

import java.util.List;

@Data
public class MenuVo {

    private Integer pid;

    private Integer father;

    private String icon;

    private String resources;

    private String title;

    private List<MenuVo> children;

    public MenuVo() {
    }

    public MenuVo(Integer pid, Integer father, String icon, String resources, String title) {
        this.pid = pid;
        this.father = father;
        this.icon = icon;
        this.resources = resources;
        this.title = title;
    }

}
