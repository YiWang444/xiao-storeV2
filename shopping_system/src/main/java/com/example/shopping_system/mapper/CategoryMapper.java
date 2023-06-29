package com.example.shopping_system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.dto.CategoryDTO;
import com.example.shopping_system.pojo.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;


@Mapper
public interface CategoryMapper extends BaseMapper<Category> {
    @Select("select category_id, category_name from category;")
    public List<CategoryDTO> selectListByDTO();
}