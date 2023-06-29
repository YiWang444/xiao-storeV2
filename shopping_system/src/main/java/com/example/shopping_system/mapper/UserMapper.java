package com.example.shopping_system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}
