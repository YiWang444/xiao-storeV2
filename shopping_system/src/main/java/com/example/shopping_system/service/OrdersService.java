package com.example.shopping_system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.mapper.*;
import com.example.shopping_system.pojo.*;
import com.example.shopping_system.util.RedisIdWorker;
import com.example.shopping_system.util.SnowFlake;
import com.example.shopping_system.vo.OrderVo;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class OrdersService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private AddressOrderMapper addressOrderMapper;

    @Autowired
    private VoucherOrderMapper voucherOrderMapper;

    @Resource
    private RedisIdWorker redisIdWorker;

    @Transactional
    public boolean addOperator(int userID, List<Map<String, Object>> productsMapList, int applyMethod, int addressId, List<Long> voucherOrderIdList) {
        try {
//            long orderID = SnowFlake.nextId();
            long orderID = redisIdWorker.nextId("order:order");
            // TODO: 减库存，保存订单,清理购物车, 优惠券表添加
            for(Map<String, Object> productsMap : productsMapList) {
                // 保存订单
                int productID = (int)productsMap.get("productId");
                double price = (double)productsMap.get("price");
                int num = (int)productsMap.get("num");

                ordersMapper.insert(new Orders(orderID, userID, productID, num, price, applyMethod));

                // 清理购物车
                shoppingCartMapper.delete(new QueryWrapper<ShoppingCart>()
                        .eq("user_id", userID)
                        .eq("product_id", productID)
                );

                // 减库存, 加销量(Redis优化)判断是否还有库存
                productMapper.updateProduct(productID);
            }

            // TODO Voucher
            if(voucherOrderIdList != null) {
                voucherOrderIdList.forEach(id -> {
                    VoucherOrder voucherOrder = new VoucherOrder();
                    voucherOrder.setId(id);
                    voucherOrder.setOrderId(orderID);
                    voucherOrder.setUseTime(LocalDateTime.now());

                    voucherOrderMapper.updateById(voucherOrder);
                });
            }

            // TODO Address
            addressOrderMapper.insert(new AddressOrder(orderID, addressId));
            return true;
        } catch (Exception e) {
            System.out.println(e);
            // TODO: 记录日志、发送告警、进行回滚等
            return false;
        }
    }

    public Result addOrder(int userID, List<Map<String, Object>> productsMapList, int applyMethod, int addressId, List<Long> voucherOrderIdList) {

        return addOperator(userID, productsMapList, applyMethod, addressId, voucherOrderIdList) == true ?
                Result.success(null, "购买成功") :
                Result.error("002", "购买失败");
    }


    public Result getOrder(int userID) {
        ArrayList<List<OrderVo>> res = new ArrayList<>();
        List<OrderVo> orderList = ordersMapper.selectListJoinProduct(userID);

        if (orderList == null) {
            return Result.error("002", "该用户没有订单信息");
        }

        // 将同一个订单放在一组
        Map<Long, List<OrderVo>> collect = new HashMap<>();
        Map<Long, Long> orderIdToDiscounts = new HashMap<>();

        //  Map<String, List<OrderVo>> collect = orderList.stream().collect(Collectors.groupingBy(o -> o.getOrderId()));
        for(OrderVo order : orderList) {
            Long orderId = order.getOrderId();
            if (!collect.containsKey(orderId)) {
                collect.put(orderId, new ArrayList<>());
                VoucherOrder voucherOrder = voucherOrderMapper.selectOne(new QueryWrapper<VoucherOrder>().eq("order_id", orderId));
                if(voucherOrder == null) {
                    orderIdToDiscounts.put(orderId, 0L);
                }else {
                    orderIdToDiscounts.put(orderId, voucherOrder.getDiscounts());
                }

            }
            order.setDiscounts(orderIdToDiscounts.get(orderId));
            collect.get(orderId).add(order);
        }

        Collection<List<OrderVo>> mapValues = collect.values();
        res.addAll(mapValues);

        return Result.success(res, "查询订单成功");
    }

    public Result checkBuy(int userId, int productId) {
        Integer count = ordersMapper.selectCount(new QueryWrapper<Orders>()
                .eq("user_id", userId)
                .eq("product_id", productId));

        return count > 0 ? Result.success() : Result.error("002", "请购买后再评论!");
    }
}

/*
public Result getOrder(int userID) {
        ArrayList<List<OrderVo>> res = new ArrayList<>();
        List<OrderVo> orderList = ordersMapper.selectListJoinProduct(userID);

        if (orderList == null) {
            return Result.error("002", "该用户没有订单信息");
        }

        // 将同一个订单放在一组
        Map<String, List<OrderVo>> collect = orderList.stream().collect(Collectors.groupingBy(o -> o.getOrderId()));
        Collection<List<OrderVo>> mapValues = collect.values();


        res.addAll(mapValues);

        return Result.success(res, "查询订单成功");
    }
 */
