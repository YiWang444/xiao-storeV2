package com.example.shopping_system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.shopping_system.dto.ProductDTO;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.mapper.CollectMapper;
import com.example.shopping_system.pojo.Collect;
import com.example.shopping_system.pojo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CollectService {

    @Autowired
    private CollectMapper collectMapper;

    public Result getCollect(int userID) {
        List<ProductDTO> productList = collectMapper.getCollect(userID);

        return productList.size() != 0 ?
                Result.success(productList, "查询收藏成功") :
                Result.error("002", "该用户没有收藏的商品");
    }

    public Result addCollect(int userID, int productID) {
        Collect collect = collectMapper.selectOne(new QueryWrapper<Collect>()
                .eq("user_id", userID)
                .eq("product_id", productID));

        if (collect != null) {
            return Result.error("003", "该商品已经添加收藏，请到我的收藏查看");
        }

        collectMapper.insert(new Collect(userID, productID));
        return Result.success(null, "添加收藏成功");
    }

    public Result deleteCollect(int userID, int productID) {
        Collect collect = collectMapper.selectOne(new QueryWrapper<Collect>()
                .eq("user_id", userID)
                .eq("product_id", productID));

        if (collect == null) {
            return Result.error("002", "该商品不在收藏列表");
        }

        collectMapper.delete(new QueryWrapper<>(new Collect(userID,productID)));
        return Result.success(null, "删除收藏成功");
    }
}
