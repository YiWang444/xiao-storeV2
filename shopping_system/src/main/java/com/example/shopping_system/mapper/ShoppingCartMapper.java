package com.example.shopping_system.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.dto.GoodsDTO;
import com.example.shopping_system.pojo.ShoppingCart;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ShoppingCartMapper extends BaseMapper<ShoppingCart> {
    @Select("select id, p.product_id, product_name, product_picture 'product_img', product_selling_price 'price', num, product_num 'maxNum', checked from shopping_cart\n" +
            "    join product p on shopping_cart.product_id = p.product_id\n" +
            "    join user u on shopping_cart.user_id = u.user_id\n" +
            "    where u.user_id = ${id};")
    public List<GoodsDTO> getGoodsList(Integer id);

    @Select("select id, p.product_id, product_name, product_picture 'product_img', product_selling_price 'price', num, product_num 'maxNum', checked from shopping_cart\n" +
            "    join product p on shopping_cart.product_id = p.product_id\n" +
            "    join user u on shopping_cart.user_id = u.user_id\n" +
            "    where u.user_id = ${userId} and p.product_id = ${productId};")
    public GoodsDTO getGoodsOne(Integer userId, Integer productId);
}