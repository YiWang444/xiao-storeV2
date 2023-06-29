package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Product {
    @TableId(type = IdType.AUTO)
    private Integer productId;
    private String productName;
    private String productTitle;
    private String productIntro;
    private Double productPrice;
    private Double productSellingPrice;
    private Integer productNum;
    private Integer productSales;
    private String productPicture;
    private String productPictureDesc;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private Integer categoryId;
}
