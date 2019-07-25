package com.ifsaid.report.dto;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

@Data
public class AuthenticationRequestDto {

    @NotNull(message = "Username can not be empty")
    @Length(min = 4, message = "Username cannot be less than four digits in length")
    private String username;

    @NotNull(message = "Password can not be blank")
    @Length(min = 4, message = "Password cannot be less than four digits in length")
    private String password;

}
