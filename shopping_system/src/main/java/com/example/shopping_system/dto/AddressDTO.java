package com.example.shopping_system.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AddressDTO {
    private Integer id;
    private Integer userId;

    private String area;
    private String detail;

    private String name;
    private String telephone;
}
