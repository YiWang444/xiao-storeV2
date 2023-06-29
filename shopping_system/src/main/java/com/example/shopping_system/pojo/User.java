package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class User {

    @TableId(type = IdType.AUTO)
    private Integer userId;

    private String userName;
    private String password;
    private String userImg;
    private String telephone;
    private Integer viper;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
