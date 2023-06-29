package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Voucher {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id; // 主键

    private String title; // 代金券标题

    private String subTitle; // 副标题

    private String rules; // 使用规则

    private Long payValue; // 支付金额

    private Long actualValue; // 抵扣金额

    private Integer status; // 优惠券类型

    private Integer stock; // 库存

    private LocalDateTime beginTime; // 生效时间

    private LocalDateTime endTime; // 失效时间

    private LocalDateTime createTime; // 创建时间

    private LocalDateTime updateTime; // 更新时间
}
