package com.example.shopping_system.controller;

import com.example.shopping_system.dto.Result;
import com.example.shopping_system.pojo.Address;
import com.example.shopping_system.pojo.User;
import com.example.shopping_system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result login(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {

        return userService.login(user);
    }

    @PostMapping("/findUserName")
    public Result findUserName(@RequestBody User user) {
        return userService.findUserName(user.getUserName());
    }

    @PostMapping("register")
    public Result register(@RequestBody User user) {
        return userService.register(user);
    }

    @PostMapping("/getUserInfo")
    public Result getUserInfo(@RequestBody Map<String, Object> requestMap) {
        return userService.getUserInfo((int) requestMap.get("userId"));
    }

    @PostMapping("/checkField")
    public Result checkField(@RequestBody Map<String, Object> requestMap) {
        return userService.checkField(
                (int) requestMap.get("userId"),
                (String) requestMap.get("field"),
                (String) requestMap.get("value"));
    }

    @PostMapping("/updateField")
    public Result updateField(@RequestBody Map<String, Object> requestMap) {
        return userService.updateField(
                (int) requestMap.get("userId"),
                (String) requestMap.get("field"),
                (String) requestMap.get("value"));
    }

    @PostMapping("/saveUserImg")
    public Result saveUserImg(@RequestBody Map<String, Object> requestMap) {
        return userService.saveUserImg(
                (int) requestMap.get("userId"),
                (String) requestMap.get("fileName"));
    }

    @PostMapping("/addAddress")
    public Result addAddress(@RequestBody Address address) {
        return userService.addAddress(address);
    }

    @PostMapping("/getAddress")
    public Result addAddress(@RequestBody Map<String, Object> requestMap) {
        return userService.getAddress((int) requestMap.get("userId"));
    }
}