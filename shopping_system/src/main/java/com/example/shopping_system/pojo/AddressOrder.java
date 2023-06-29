package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class AddressOrder {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Long orderId;
    private Integer addressId;

    public AddressOrder(Long orderId, Integer addressId) {
        this.orderId = orderId;
        this.addressId = addressId;
    }
}
