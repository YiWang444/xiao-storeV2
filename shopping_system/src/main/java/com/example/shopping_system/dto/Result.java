package com.example.shopping_system.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result {
    private String code;//响应码
    private String msg;  //响应信息 描述字符串
    private Object data; //返回的数据

    //增删改 成功响应
    public static Result success(){
        return new Result("001","success",null);
    }
    //查询 成功响应
    public static Result success(Object data, String msg){
        return new Result("001", msg,data);
    }
    //失败响应
    public static Result error(String code, String msg){
        return new Result(code, msg,null);
    }
}
