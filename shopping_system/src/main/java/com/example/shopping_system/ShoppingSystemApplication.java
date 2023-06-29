package com.example.shopping_system;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@EnableAspectJAutoProxy(exposeProxy = true)
@SpringBootApplication
public class ShoppingSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(ShoppingSystemApplication.class, args);
    }

}
