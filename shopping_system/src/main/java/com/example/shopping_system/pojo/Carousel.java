package com.example.shopping_system.pojo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Carousel {
    private Integer carouselId;
    private String imgPath;
    private String describes;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
