package com.example.shopping_system.service;

import cn.hutool.core.bean.BeanUtil;
import com.example.shopping_system.dto.CarouselDTO;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.mapper.CarouselMapper;
import com.example.shopping_system.pojo.Carousel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CarouselService {

    @Autowired
    private CarouselMapper carouselMapper;

    public Result getCarousel() {

        return Result.success(carouselMapper.selectListOfDTO(), "查询轮播图成功");
    }
}
