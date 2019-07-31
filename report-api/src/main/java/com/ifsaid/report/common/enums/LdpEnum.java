package com.ifsaid.report.common.enums;

public enum LdpEnum {

    GIVE_UP("give up", "-1"),
    TURN_DOWN("turn down", "0"),
    EXAMINATION("Approval", "1"),
    COMPLETE("Approval completed", "2"),
    ASSIGNEE_USER("Personnel variable key", "ASSIGNEE_USER"),
    OUTCOME("Connected variable key", "OUTCOME"),
    PROCESS_DEFINE_KEY("Process defined key", "LdpProcess");

    private String code;

    LdpEnum(String description, String code) {
        this.code = code;
    }

    public String getCode() {
        return this.code;
    }
}
