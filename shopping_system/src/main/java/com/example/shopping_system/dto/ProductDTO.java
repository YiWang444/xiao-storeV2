package com.example.shopping_system.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO {
    private Integer productId;
    private String productName;
    private String productTitle;
    private String productIntro;
    private Double productPrice;
    private Double productSellingPrice;
    private Integer productNum;
    private Integer productSales;
    private String productPicture;

    private Integer categoryId;

    public ProductDTO(Integer productId, Double productPrice, Integer productNum) {
        this.productId = productId;
        this.productPrice = productPrice;
        this.productNum = productNum;
    }
}
