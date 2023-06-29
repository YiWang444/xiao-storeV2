package com.example.shopping_system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.dto.ProductDTO;
import com.example.shopping_system.pojo.Collect;
import com.example.shopping_system.pojo.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CollectMapper extends BaseMapper<Collect> {

    @Select("select p.product_id, product_name, product_title, product_intro, product_picture, product_price, product_selling_price, product_num, product_sales, category_id from collect\n" +
            "    join product p on p.product_id = collect.product_id\n" +
            "    where user_id = 1")
    List<ProductDTO> getCollect(int userId);
}