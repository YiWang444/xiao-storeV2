package com.example.shopping_system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.dto.CarouselDTO;
import com.example.shopping_system.pojo.Carousel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;


@Mapper
public interface CarouselMapper extends BaseMapper<Carousel> {
    @Select("select carousel_id, img_path, describes from carousel")
    public List<CarouselDTO> selectListOfDTO();
}