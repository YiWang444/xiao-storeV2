package com.example.shopping_system.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.pojo.Orders;
import com.example.shopping_system.pojo.Product;
import com.example.shopping_system.vo.OrderVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface OrdersMapper extends BaseMapper<Orders> {

    @Select("select order_id, user_id, p.product_id, orders.product_num, orders.create_time, orders.product_price, product_name, product_picture from orders\n" +
            "    join product p on p.product_id = orders.product_id\n" +
            "    where user_id = ${userID}")
    List<OrderVo> selectListJoinProduct(int userID);
}