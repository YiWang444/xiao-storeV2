package com.example.shopping_system.dto;

import lombok.Data;

@Data
public class LoginFormDTO {
    private String phone;
    private String code;
    private String password;
}
