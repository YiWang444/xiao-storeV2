package com.example.shopping_system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.pojo.Voucher;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface VoucherMapper extends BaseMapper<Voucher> {
    @Select("select voucher_order.id 'id', title, actual_value from voucher_order\n" +
            "    join voucher v on v.id = voucher_order.voucher_id\n" +
            "    where user_id = ${userId} and pay_value <= ${price}")
    List<Voucher> getVoucherByPrice(int userId, double price);
}
