package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Orders {

    @TableId(type = IdType.INPUT)
    private Long id;

    private Long orderId;

    private Integer userId;
    private Integer productId;
    private Integer productNum; // 买个几个
    private Double productPrice;
    private Integer applyMethod;

    private int deleted;
    private int version;
    private LocalDateTime createTime; // 下单时间
    private LocalDateTime updateTime;

    public Orders(Long orderId, Integer userId, Integer productId, Integer productNum, Double productPrice, Integer applyMethod) {
        this.orderId = orderId;
        this.userId = userId;
        this.productId = productId;
        this.productNum = productNum;
        this.productPrice = productPrice;
        this.applyMethod = applyMethod;
    }
}
