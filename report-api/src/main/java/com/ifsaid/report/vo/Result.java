package com.ifsaid.report.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Result<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer status;

    private String message;

    private T data;

    private String error;

    private Long timestamp;

    public static <T> Result result(Integer status, String msg, T data, String error) {
        Result r = new Result();
        r.setStatus(status);
        r.setMessage(msg);
        r.setData(data);
        r.setError(error);
        r.setTimestamp(System.currentTimeMillis());
        return r;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setData(T data) {
        this.data = data;
    }

    public void setError(String error) {
        this.error = error;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public static <T> Result success() {
        return success("success", null);
    }

    public static <T> Result success(String msg) {
        return success(msg, null);
    }

    public static <T> Result success(T data) {
        return success("success", data);
    }

    public static <T> Result success(String msg, T data) {
        return result(200, msg, data, null);
    }

    public static <T> Result error(int code, String msg, String error) {
        return result(code, msg, null, error);
    }

    public static <T> Result error401(String msg, String error) {
        return result(401, msg, null, error);
    }

    public static <T> Result error400(String msg, String error) {
        return result(400, msg, null, error);
    }

    public static <T> Result error404(String msg, String error) {
        return result(404, msg, null, error);
    }

    public static <T> Result error408(String msg, String error) {
        return result(408, msg, null, error);
    }

    public static <T> Result error415(String msg, String error) {
        return result(415, msg, null, error);
    }

    public static <T> Result error500(String msg, String error) {
        return result(500, msg, null, error);
    }

    public static <T> Result error502(String msg, String error) {
        return result(502, msg, null, error);
    }

}
