package com.ifsaid.report.vo;

import lombok.Data;

@Data
public class Relation {

    private Integer pid;

    private Integer rid;

    private String uid;

    public Relation() {
    }

    public Relation(Integer pid, Integer rid) {
        this.pid = pid;
        this.rid = rid;
    }

    public Relation(Integer rid, String uid) {
        this.rid = rid;
        this.uid = uid;
    }

}
