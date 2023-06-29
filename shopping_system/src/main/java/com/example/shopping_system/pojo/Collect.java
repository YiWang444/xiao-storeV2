package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Collect {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer userId;
    private Integer productId;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime; // 收藏时间

    public Collect(Integer userId, Integer productId) {
        this.userId = userId;
        this.productId = productId;
    }
}
