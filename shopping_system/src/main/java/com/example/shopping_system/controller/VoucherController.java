package com.example.shopping_system.controller;

import com.example.shopping_system.dto.Result;
import com.example.shopping_system.pojo.Voucher;
import com.example.shopping_system.service.VoucherService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/voucher")
public class VoucherController {

    @Autowired
    VoucherService voucherService;

    @PostMapping("/getVoucherAll")
    public Result getVoucherAll() {
        return voucherService.getVoucherAll();
    }

    @PostMapping("/getVoucherByPrice")
    public Result getVoucherByPrice(@RequestBody Map<String, Object> requestMap) {
        return voucherService.getVoucherByPrice(
                (Integer)requestMap.get("userId"),
                Double.valueOf(requestMap.get("price").toString())
        );
    }

    @PostMapping("/getVoucher")
    public Result getVoucher(@RequestBody Map<String, Object> requestMap) {
        return voucherService.getVoucher(
                (Integer)requestMap.get("userId"),
                Long.valueOf(requestMap.get("voucherId").toString())
        );
    }

    @PostMapping("/addVoucher")
    public Result addVoucher(@RequestBody Voucher voucher) {
        return voucherService.addVoucher(voucher);
    }
}
