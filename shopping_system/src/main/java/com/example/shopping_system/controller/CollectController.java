package com.example.shopping_system.controller;

import com.example.shopping_system.dto.Result;
import com.example.shopping_system.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/collect")
public class CollectController {

    @Autowired
    private CollectService collectService;

    @PostMapping("/getCollect")
    public Result getCollect(@RequestBody Map<String, Object> requestMap) {
        return collectService.getCollect(
                (int)requestMap.get("userId")
        );
    }

    @PostMapping("/addCollect")
    public Result addCollect(@RequestBody Map<String, Object> requestMap) {
        return collectService.addCollect(
                (int)requestMap.get("userId"),
                (int)requestMap.get("productId")
        );
    }

    @PostMapping("/deleteCollect")
    public Result deleteCollect(@RequestBody Map<String, Object> requestMap) {
        return collectService.deleteCollect(
                (int)requestMap.get("userId"),
                (int)requestMap.get("productId")
        );
    }
}
