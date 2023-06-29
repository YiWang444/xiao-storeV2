package com.example.shopping_system.controller;

import com.example.shopping_system.dto.Result;
import com.example.shopping_system.service.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/order")
public class OrdersController {

    @Autowired
    private OrdersService orderService;

    @PostMapping("/addOrder")
    public Result addOrder(@RequestBody Map<String, Object> requestMap) {

        return orderService.addOrder(
                (int)requestMap.get("userId"),
                (List<Map<String, Object>>)requestMap.get("products"),
                (int)requestMap.get("applyMethod"),
                (int)requestMap.get("addressId"),
                (List<Long>)requestMap.get("voucherOrderIds")
        );
    }

    @PostMapping("/getOrder")
    public Result getOrder(@RequestBody Map<String, Object> requestMap) {
        return orderService.getOrder((int)requestMap.get("userId"));
    }

    @PostMapping("/checkBuy")
    public Result checkBuy(@RequestBody Map<String, Object> requestMap) {
        Object obj = requestMap.get("productId");

        return orderService.checkBuy(
                (int)requestMap.get("userId"),
                obj instanceof String ? Integer.parseInt((String) obj) : (Integer) obj
        );
    }
}
