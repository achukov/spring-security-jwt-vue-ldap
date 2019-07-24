package com.ifsaid.report.vo;

import lombok.Data;

@Data
public class ButtonVo {

    private Integer pid;

    private String resources;

    private String title;

    public ButtonVo() {
    }

    public ButtonVo(Integer pid, String resources, String title) {
        this.pid = pid;
        this.resources = resources;
        this.title = title;
    }
}
