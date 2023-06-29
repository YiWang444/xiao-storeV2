package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {

    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private String province;
    private String city;
    private String district;
    private String detail;
    private String telephone;
    private String name;
}
