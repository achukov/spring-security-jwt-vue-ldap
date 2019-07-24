package com.ifsaid.report;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordEncoderTest {

    private final static PasswordEncoder encoder = new BCryptPasswordEncoder();

    public static void main(String[] args) {
		String password = "password";
        String password2 = "password";
        String encodedPassword  = encoder.encode(password);
        String encodedPassword2  = encoder.encode(password2);
        System.out.println("The encoded password = " + encodedPassword);
        System.out.println("The encoded password2 = " + encodedPassword2);
        System.out.println(encoder.matches(password, encodedPassword));
    }

}
