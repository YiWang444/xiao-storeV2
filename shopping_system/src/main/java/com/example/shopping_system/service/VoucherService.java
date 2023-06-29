package com.example.shopping_system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.mapper.VoucherMapper;
import com.example.shopping_system.mapper.VoucherOrderMapper;
import com.example.shopping_system.pojo.Voucher;
import com.example.shopping_system.pojo.VoucherOrder;
import com.example.shopping_system.util.RedisIdWorker;
import org.springframework.aop.framework.AopContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Service
public class VoucherService {
    @Autowired
    private VoucherMapper voucherMapper;

    @Autowired
    private VoucherOrderMapper voucherOrderMapper;

    @Resource
    private RedisIdWorker redisIdWorker;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    public Result getVoucher(Integer userId, Long voucherId) {

        Voucher voucher = voucherMapper.selectById(voucherId);

        if (voucher.getBeginTime().isAfter(LocalDateTime.now())) {
            return Result.error("002", "秒杀尚未开始！");
        }

        if(voucher.getEndTime().isBefore(LocalDateTime.now())) {
            return Result.error("003", "秒杀已经结束！");
        }

        // 判断库存是否不足
        if(voucher.getStock() < 1) {
            return Result.error("004", "库存不足！");
        }

        // 同一个用户加锁
        synchronized (userId.toString().intern()) {
            /*
                不这样写事务会失效，this.createVoucherOrder() 拿到的是目标对象而不是代理对象
                应该先获取代理对象，再调用
                还需要配置两步：
                    1. 再pom.xml中
                        <dependency>
                            <groupId>org.aspectj</groupId>
                            <artifactId>aspectjweaver</artifactId>
                        </dependency>
                    2. 在 xxApplication.java中添加配置
                        @EnableAspectJAutoProxy(exposeProxy = true)
             */
            VoucherService proxy = (VoucherService)AopContext.currentProxy();
            return proxy.createVoucherOrder(userId, voucherId, voucher.getActualValue());
        }
    }

    @Transactional
    public Result createVoucherOrder(Integer userId, Long voucherId, Long discounts) {
        // 一人一单
        int count = voucherOrderMapper.selectCount(new QueryWrapper<VoucherOrder>()
                .eq("user_id", userId)
                .eq("voucher_id", voucherId));

        if(count > 0) {
            System.out.println(count);
            return Result.error("006", "你已经购买过一次了！");
        }

        // 扣减库存(CAS) -> (stock > getStock) -> (stock > 0)
        int effectRow = voucherMapper.update(null,
                new UpdateWrapper<Voucher>()
                        .setSql("stock = stock - 1")
                        .gt("stock", 0)
                        .eq("id", voucherId));

        if(effectRow == 0) {
            return Result.error("005", "扣减库存失败！");
        }

        // 创建订单
        VoucherOrder voucherOrder = new VoucherOrder();
        voucherOrder.setId(redisIdWorker.nextId("voucher:order"));
        voucherOrder.setUserId(userId);
        voucherOrder.setVoucherId(voucherId);
        voucherOrder.setDiscounts(discounts);

        voucherOrderMapper.insert(voucherOrder);

        // 返回订单ID
        return Result.success(voucherOrder.getId(), "抢夺优惠券成功");
    }

    public Result addVoucher(Voucher voucher) {

        voucherMapper.insert(voucher);

        return Result.success();
    }

    public Result getVoucherAll() {
        List<Voucher> voucherList = voucherMapper.selectList(new QueryWrapper<Voucher>()
                .eq("status", 1)
                .lt("begin_time", LocalDateTime.now())
                .gt("end_time", LocalDateTime.now()));

        return Result.success(voucherList, "查询成功");
    }

    public Result getVoucherByPrice(Integer userId, Double price) {

        return Result.success(voucherMapper.getVoucherByPrice(userId, price), "查询优惠券列表成功");
    }
}
