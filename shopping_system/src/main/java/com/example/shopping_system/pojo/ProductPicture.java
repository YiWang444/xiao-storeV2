package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class ProductPicture {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer productId;
    private String productPicture;
    private String intro;
}
