package com.example.shopping_system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.example.shopping_system.dto.GoodsDTO;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.mapper.ProductMapper;
import com.example.shopping_system.mapper.ShoppingCartMapper;
import com.example.shopping_system.pojo.Product;
import com.example.shopping_system.pojo.ShoppingCart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShoppingCartService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Autowired
    private ProductMapper productMapper;

    public Result getShoppingCart(Integer userId) {
        List<GoodsDTO> goodsList = shoppingCartMapper.getGoodsList(userId);

        return goodsList.size() == 0 ?
                Result.success(goodsList, "购物车为空") :
                Result.success(goodsList, "购物车不为空");
    }

    public Result addShoppingCart(Integer userId, Integer productId) {
        GoodsDTO goods = shoppingCartMapper.getGoodsOne(userId, productId);

        if(goods == null) {
            ShoppingCart shoppingCart = new ShoppingCart(userId, productId, 1);
            shoppingCartMapper.insert(shoppingCart);

            Product product = productMapper.selectOne(new QueryWrapper<Product>().eq("product_id", productId));
            goods = new GoodsDTO(shoppingCart.getId(), productId, product.getProductName(), product.getProductPicture(), product.getProductSellingPrice(), 1, product.getProductNum(), false);

            return Result.success(goods, "添加购物车成功!");
        }

        if(goods.getNum() + 1 > goods.getMaxNum()) {
            return Result.error("003", "商品已达到购物限额");
        }else{
            ShoppingCart shoppingCart = new ShoppingCart(userId, productId, goods.getNum() + 1);
            shoppingCartMapper.update(shoppingCart, new UpdateWrapper<ShoppingCart>().eq("user_id", userId).eq("product_id", productId));

            return Result.error("002", "商品已在购物车,数量+1");
        }
    }

    public Result deleteShoppingCart(int userId, int productId) {
        GoodsDTO goods = shoppingCartMapper.getGoodsOne(userId, productId);

        if (goods == null) {
            return Result.error("002", "该商品不在购物车");
        }

        shoppingCartMapper.delete(new QueryWrapper<ShoppingCart>().eq("user_id", userId).eq("product_id", productId));
        return Result.success(null, "删除购物车成功");
    }

    public Result updateShoppingCart(int userId, int productId, int num) {
        GoodsDTO goods = shoppingCartMapper.getGoodsOne(userId, productId);

        if (goods == null) {
            return Result.error("002", "该商品不在购物车");
        }

        if(num > goods.getMaxNum()) {
            return Result.error("004", "商品已达到购物限额");
        }else if(num == goods.getNum()){
            return Result.error("003", "数量没有发生变化");
        }else {
            ShoppingCart shoppingCart = new ShoppingCart(userId, productId, num);
            shoppingCartMapper.update(shoppingCart, new UpdateWrapper<ShoppingCart>().eq("user_id", userId).eq("product_id", productId));
            return Result.success(null, "修改购物车数量成功");
        }
    }
}
