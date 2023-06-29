package com.example.shopping_system.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderVo {
    private Long orderId;

    private Integer userId;
    private Integer productId;
    private Integer productNum; // 买个几个
    private Double productPrice;
    private LocalDateTime createTime; // 下单时间
    private Long discounts; // 优惠价

    private String productName;
    private String productPicture;
}
