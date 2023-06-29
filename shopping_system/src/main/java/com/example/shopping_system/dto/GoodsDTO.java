package com.example.shopping_system.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GoodsDTO {
    private Integer id; // shoppingCart_id
    private Integer productId;
    private String productName;
    private String productImg;
    private Double price;
    private Integer num; // 当前选中多少件
    private Integer maxNum; // 库存
    private Boolean checked;
}
