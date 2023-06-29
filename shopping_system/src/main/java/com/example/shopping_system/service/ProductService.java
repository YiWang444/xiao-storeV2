package com.example.shopping_system.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.shopping_system.dto.PageDTO;
import com.example.shopping_system.dto.ProductDTO;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.mapper.CategoryMapper;
import com.example.shopping_system.mapper.ProductMapper;
import com.example.shopping_system.mapper.ProductPictureMapper;
import com.example.shopping_system.pojo.Product;
import com.example.shopping_system.pojo.ProductPicture;
import com.example.shopping_system.util.CacheClient;
import jodd.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class ProductService {

    private static final int PAGE_SIZE = 7; // 首页展示同一类别前7(1-7)个商品

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private ProductPictureMapper productPictureMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Resource
    private CacheClient cacheClient;

    public Result getPromoProduct(Integer categoryID) {

        return Result.success(productMapper.selectListOfDTO(categoryID, 0, PAGE_SIZE), "查询成功");
    }

    public Result getDetails(Integer productID) {
        // return Result.success(BeanUtil.copyProperties(productMapper.selectById(productID), ProductDTO.class), "查询成功");

        // 查询 Redis
        Product product = cacheClient
                .queryWithPassThrough("cache:product", productID, Product.class, pid -> productMapper.selectById(pid), 2L, TimeUnit.MINUTES);


        // 不存在
        if (product == null) {
            return Result.error("002", "商品不存在");
        }

        return Result.success(BeanUtil.copyProperties(product, ProductDTO.class), "查询商品成功");
    }


    public Result getDetailsPicture(Integer productID) {
        return Result.success(productPictureMapper.selectList(
                        new QueryWrapper<ProductPicture>().eq("product_id", productID)),
                "查询成功");
    }

    public Result getCategory() {

        return Result.success(categoryMapper.selectListByDTO(), "查询成功");
    }

    public Result getAllProduct(Integer categoryID, Integer pageSize, Integer currentPage) {

        Integer offset = (currentPage - 1) * pageSize;

        if (categoryID == null) {
            return Result.success(
                    new PageDTO(productMapper.selectAllListOfDTO(offset, pageSize)
                            , productMapper.selectAllTotalOfDTO())
                    , "查询成功");
        }else {
            return Result.success(
                    new PageDTO(productMapper.selectListOfDTO(categoryID, offset, pageSize)
                            , productMapper.selectCountOfDTO(categoryID))
                    , "查询成功");
        }
    }

    public Result getHotProduct(Integer categoryID) {

        return Result.success(productMapper.selectListByHotProduct(categoryID, 0, PAGE_SIZE), "查询成功");
    }

    public Result getProductBySearch(String keyWord, Integer pageSize, Integer currentPage) {
        Integer offset = (currentPage - 1) * pageSize;

        return Result.success(new PageDTO(
                productMapper.selectListProductBySearch(keyWord, offset, pageSize),
                productMapper.selectTotalProductBySearch(keyWord)
        ), "查询成功");
    }

    @Transactional
    public Result updateProduct(Product product) {
        if (product.getProductId() == null) {
            return Result.error("002", "商品ID不能为空");
        }

        // 更新数据库
        productMapper.updateById(product);

        // 删除缓存
        stringRedisTemplate.delete("cache:product" + product.getProductId());
        return null;
    }
}
