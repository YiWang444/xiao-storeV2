package com.example.shopping_system.controller;

import com.example.shopping_system.dto.ProductDTO;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.pojo.Product;
import com.example.shopping_system.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PutMapping
    public Result updateProduct(@RequestBody Product product) {
        return productService.updateProduct(product);
    }

    @PostMapping("/getPromoProduct")
    public Result getPromoProduct(@RequestBody Map<String, Object> requestMap) {
        return productService.getPromoProduct((int)requestMap.get("categoryId"));
    }

    @PostMapping("/getDetails")
    public Result getDetails(@RequestBody Map<String, Object> requestMap) {
        Object obj = requestMap.get("productId");

        return productService.getDetails(obj instanceof String ? Integer.parseInt((String) obj) : (Integer) obj);
    }

    @PostMapping("/getDetailsPicture")
    public Result getDetailsPicture(@RequestBody Map<String, Object> requestMap) {
        Object obj = requestMap.get("productId");

        return productService.getDetailsPicture(obj instanceof String ? Integer.parseInt((String) obj) : (Integer) obj);
    }

    @PostMapping("/getCategory")
    public Result getCategory() {
        return productService.getCategory();
    }

    @PostMapping("/getAllProduct")
    public Result getAllProduct(@RequestBody Map<String, Object> requestMap) {

        return productService.getAllProduct(
                null,
                (int) requestMap.get("pageSize"),
                (int) requestMap.get("currentPage"));
    }

    @PostMapping("/getProductByCategory")
    public Result getProductByCategory(@RequestBody Map<String, Object> requestMap) {

        return productService.getAllProduct(
                (int) requestMap.get("categoryId"),
                (int) requestMap.get("pageSize"),
                (int) requestMap.get("currentPage"));
    }

    @PostMapping("/getHotProduct")
    public Result getHotProduct(@RequestBody Map<String, Object> requestMap) {
        return productService.getHotProduct((int)requestMap.get("categoryId"));
    }

    @PostMapping("/getProductBySearch")
    public Result getProductBySearch(@RequestBody Map<String, Object> requestMap) {
        return productService.getProductBySearch(
                (String) requestMap.get("search"),
                (int) requestMap.get("pageSize"),
                (int) requestMap.get("currentPage"));
    }
}
