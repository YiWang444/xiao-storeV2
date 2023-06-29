package com.example.shopping_system.controller;

import cn.hutool.core.bean.BeanUtil;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.pojo.User;
import com.example.shopping_system.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/shoppingCart")
public class ShoppingCartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    @PostMapping("/getShoppingCart")
    public Result getShoppingCart(@RequestBody User user) {
        return shoppingCartService.getShoppingCart(user.getUserId());
    }

    @PostMapping("/addShoppingCart")
    public Result addShoppingCart(@RequestBody Map<String, Object> requestMap) {

        return shoppingCartService.addShoppingCart((int) requestMap.get("userId"), (int) requestMap.get("productId"));
    }

    @PostMapping("/deleteShoppingCart")
    public Result deleteShoppingCart(@RequestBody Map<String, Object> request) {

        return shoppingCartService.deleteShoppingCart((int) request.get("userId"), (int) request.get("productId"));
    }

    @PostMapping("/updateShoppingCart")
    public Result updateShoppingCart(@RequestBody Map<String, Object> request) {

        return shoppingCartService.updateShoppingCart((int) request.get("userId"), (int) request.get("productId"), (int) request.get("num"));
    }
}
