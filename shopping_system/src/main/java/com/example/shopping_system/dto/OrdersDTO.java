package com.example.shopping_system.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrdersDTO {
    private Long orderId;
    private Integer userId;
    private Double productId;
    private Integer productNum;
    private Double productPrice;
}
