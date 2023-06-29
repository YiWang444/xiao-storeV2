package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ShoppingCart {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer productId;
    private Integer num;
    private int checked;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public ShoppingCart(Integer userId, Integer productId, Integer num) {
        this.userId = userId;
        this.productId = productId;
        this.num = num;
    }
}
