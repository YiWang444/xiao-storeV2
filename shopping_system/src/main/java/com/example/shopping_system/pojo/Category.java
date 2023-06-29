package com.example.shopping_system.pojo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Category {
    private Integer categoryId;
    private String categoryName;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
