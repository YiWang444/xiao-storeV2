package com.example.shopping_system.controller;

import com.example.shopping_system.dto.Result;
import com.example.shopping_system.pojo.User;
import com.example.shopping_system.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/resources")
public class CarouselController {

    @Autowired
    private CarouselService carouselService;

    @PostMapping("/carousel")
    public Result getCarousel() {
        return carouselService.getCarousel();
    }
}
