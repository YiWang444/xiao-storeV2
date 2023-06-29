package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class VoucherOrder {
    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.INPUT)
    private Long id;

    private int userId; // 下单的用户id

    private Long voucherId; // 购买的代金券id

    private LocalDateTime createTime; // 下单时间

    private LocalDateTime updateTime; // 更新时间

    private LocalDateTime useTime; // 下单时间
    private Long orderId; // 订单编号
    private Long discounts; // 优惠金额
}

/*
    private Integer payType; // 支付方式 1：余额支付；2：支付宝；3：微信

    private Integer status; // 订单状态，1：未支付；2：已支付；3：已核销；4：已取消；5：退款中；6：已退款

    private LocalDateTime payTime; // 支付时间

    private LocalDateTime useTime; // 核销时间

    private LocalDateTime refundTime; // 退款时间
 */
