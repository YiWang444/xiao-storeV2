# 项目说明

### 续 小米商城V1，链接https://github.com/YiWang444/xiaomi-store

**一定要先看这个第一个版本，这个文档是对上一个版本的补充**

现在 **更名** 为 **基于Spring Boot+vue的助农电商网站的设计与实现**





### 版本有如下更新

- 数据库增加了一些表、修改了原有表的一些字段
- 引入Redsi数据库，解决购物网站高并发的问题
- 加入了 **CAS**（乐观锁）机制，和 **死锁** 机制
- 添加了一些第三方API，添加地址时（调用了**百度地图**的API）自动获取当前位置





##  自己替换代码

### 前端

````
在 /xiaomi-store-vue/src/views/PersonalSpace.vue 的第402行

// 阿里云OSS的相关配置
this.OSSClient = new OSS({
    region: '',
    accessKeyId: '',
    accessKeySecret: '',
    bucket: ''
});

````

````
在 /xiaomi-store-vue/src/main.js 的第38行

Vue.use(BaiduMap, {
  // ak 是在百度地图开发者平台申请的密钥 详见 http://lbsyun.baidu.com/apiconsole/key */
  ak: '你的密钥'
})
````



### 后端

````c++
在 xiaomi-store/src/main/java/com/example/shopping_system/service/UserService.java 的第 112行 和 115行

112: user.setUserImg("你的阿里云OSS前缀.aliyuncs.com/".concat(fileName));
115: return Result.success("你的阿里云OSS前缀.aliyuncs.com/".concat(fileName), "更新用户头像成功");
````

````yml
在 xiaomi-store/src/main/resources/application.yml 更改数据库用户和密码
server:
  port: 18888
spring:
  application:
    name: storeSystem
  datasource:
    driver-class-name: com.mysql.jdbc.Driver
    url: jdbc:mysql://localhost:3306/storeDB?characterEncoding=UTF8&useSSL=false
    username: '数据库用户名'
    password: '数据库密码'
  redis:
    host: localhost
    port: 6379
    # password:
    # 连接池配置
    lettuce:
      pool:
        max-active: 10
        max-idle: 10
        min-idle: 1
        time-between-eviction-runs: 10s
  jackson:
    default-property-inclusion: non_null # JSON处理忽略非空字符
  # 如果不成功打开下面的注释
  # rabbitmq:
    # host: localhost
    # port: 5672
    # username: guest
    # password: guest
    # virtual-host: /
#配置日志  log-impl:日志实现
mybatis-plus:
    configuration:
      log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
#mybatis:
#  configuration:
#    mapUnderscoreToCamelCase: true
#    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
logging:
  level:
    com.example.mapper: DEBUG #指定 mapper 包的日志级别为 debug
````





## 一、用户模块

### 1.7 保存收货地址

**这是之前有的，做了修改**

**请求URL：**

```
/users/addAddress
```

**请求方式：**

```
Post
```

**发送示例**

````
{
	"userId":1,
	"name":"zhangsan",
	"telephone":"15980770666",
	"province":"福建省",
	"city":"厦门市",
	"district":"思明区",
	"detail":"湖滨北路61号"
}
````

**参数说明：**

|   参数    | 是否必选 |  类型  |   说明   |
| :-------: | :------: | :----: | :------: |
|  userId   |    是    |  int   |  用户名  |
|   name    |    是    | string |  收货名  |
| telephone |    是    | string | 收货地址 |
| province  |    是    | string |    省    |
|   city    |    是    | string |    市    |
| district  |    是    | string |    区    |
|  detail   |    是    | string | 具体地址 |

**返回示例：**

```javascript
{
  code: "001"
  data: {
    "id":1,
    "userId":1,
    "name":"zhangsan",
    "telephone":"15980770666",
    "area":"福建省 厦门市 思明区",
    "detail":"湖滨北路61号"
  }
  msg: "添加成功"
}

{code: "002", msg: "添加地址失败"}
{code: "003", msg: "电话格式不对！"}
```





### 1.8 获得地址列表

**请求URL：**

```
/users/getAddress
```

**请求方式：**

```
Post
```

**发送示例**

````
{
    "userId": 1
}
````

**参数说明：**

|  参数  | 是否必选 | 类型 |  说明  |
| :----: | :------: | :--: | :----: |
| userId |    是    | int  | 用户名 |

**返回示例：**

```javascript
{
  code: "001"
  data: [
    0: {id: 13, userId: 1, detail: "湖滨北路61号", name: "zhangsan", telephone: "15980770666"}
		1: {id: 14, userId: 1, detail: "厦门市思明区厦门市人民政府", name: "zhangsan", telephone: "15980770666"}
  ]
  msg: "查询地址成功!"
}
```





## 五、 订单模块

### 5.1  添加订单

(products来着 2.1节 获取购物车信息的返回)
**请求URL：**

```
/order/addOrder/
```

**请求方式：**

```
Post
```

**发送示例**

````js
{
    "userId": 1,
    "addressId": 14,
    "applyMethod": 1,
    "voucherOrderIds": []
    "products": [
        {
            "productId": 3, 
            "price": 100, 
            "num": 2
        },
        {
            "productId": 2, 
            "price": 200, 
            "num": 3
        }
    ]
}
````

**参数说明：**

|      参数       | 是否必选 |  类型  |                    说明                    |
| :-------------: | :------: | :----: | :----------------------------------------: |
|     userId      |    是    |  int   |                   用户ID                   |
|    addressId    |    是    |  int   |                选择地址的ID                |
|   applyMethod   |    是    |  int   | 选择的支付方式（0:微信, 1:支付宝, 2:银联） |
| voucherOrderIds |    是    | [...]  |             优惠券订单ID的列表             |
|    products     |    是    | Object |               结算的全部商品               |

```js
products结构
{
  productId: "", // 商品id
  price: "", // 商品价格
  num: "", // 商品数量
}
```




**返回示例：**

```javascript
{'code': '001', 'msg': '购买成功'}
{'code': '002', 'msg': '购买失败'}
```



## 八、优惠券模块



### 8.1 添加优惠券

**正常来说是后台写的，前台有这个接口主要是Mock数据，不操作数据库**

**请求URL：**

```
/voucher/addVoucher
```

**请求方式：**

```
Post
```

**发送示例**

````
{
    "title": "优惠券1",
    "subTitle": "优惠券",
    "rules": "规则",
    "payValue": 99,
    "actualValue": 10,
    "stock": 100,
    "beginTime": "2023-06-25T14:22:39",
    "endTime": "2023-06-30T14:22:39"
}
````

**参数说明：**

|    参数     | 是否必选 |  类型  |     说明     |
| :---------: | :------: | :----: | :----------: |
|    title    |    是    | string |  优惠券标题  |
|  subTitle   |    是    | string | 优惠券子标题 |
|    rules    |    是    | string |  优惠券规则  |
|  payValue   |    是    | double |   支付金额   |
| actualValue |    是    | double |   抵扣金额   |
|    stock    |    是    |  int   |     库存     |
|  beginTime  |    是    |  date  |   生效时间   |
|   endTime   |    是    |  date  |   失效时间   |

**返回示例：**

```javascript
{
    "code": "001",
    "msg": "success"
}
```





### 8.2 获取优惠券

**后端为了处理并发，加了死锁 + 乐观锁**

**请求URL：**

```
/voucher/getVoucher
```

**请求方式：**

```
Post
```

**发送示例**

````
{
    "userId": 1,
    "voucherId": 1
}
````

**参数说明：**

|   参数    | 是否必选 | 类型 |   说明   |
| :-------: | :------: | :--: | :------: |
|  userId   |    是    | int  |  用户名  |
| voucherId |    是    | int  | 优惠券ID |

**返回示例：**

```javascript
{
    "code": "001",
    "msg": "抢夺优惠券成功",
    "data": 1720843071651850 // 返回voucher_order的ID
}

{'code': '001', 'msg': '购买成功'}
{'code': '002', 'msg': '秒杀尚未开始！'}
{'code': '003', 'msg': '秒杀已经结束！'}
{'code': '004', 'msg': '库存不足！'}
{'code': '005', 'msg': '扣减库存失败！'}
{'code': '006', 'msg': '你已经购买过一次了！'}
```





### 8.3 查询所有的优惠券

**请求URL：**

```
/voucher/getVoucherAll
```

**请求方式：**

```
Post
```

**发送示例**

````
{}
// 无数据
````

**参数说明：**

| 参数 | 是否必选 | 类型 | 说明 |
| :--: | :------: | :--: | :--: |
|  无  |    无    |  无  |  无  |

**返回示例：**

```javascript
{
    "code": "001",
    "msg": "查询成功",
    "data": [
        {
            "id": 1,
            "title": "优惠券1",
            "subTitle": "优惠券",
            "rules": "规则",
            "payValue": 99,
            "actualValue": 10,
            "status": 1,
            "stock": 99,
            "beginTime": "2023-06-25T14:22:39",
            "endTime": "2023-06-30T14:22:39",
            "createTime": "2023-06-29T16:40:16",
            "updateTime": "2023-06-29T17:46:20"
        }
    ]
}
```





### 8.4 查询大于支付金额的优惠券列表

**请求URL：**

```
/voucher/getVoucherByPrice
```

**请求方式：**

```
Post
```

**发送示例**

````
{
    "userId": 1,
    "price": 214.02
}
````

**参数说明：**

|  参数  | 是否必选 |  类型  |           说明           |
| :----: | :------: | :----: | :----------------------: |
| userId |    是    |  int   |          用户名          |
| price  |    是    | double | 价格（满足价格才能满减） |

**返回示例：**

```javascript
{
  code: "001"
  data: [
    0: {id: 13, userId: 1, detail: "湖滨北路61号", name: "zhangsan", telephone: "15980770666"}
		1: {id: 14, userId: 1, detail: "厦门市思明区厦门市人民政府", name: "zhangsan", telephone: "15980770666"}
  ]
  msg: "查询地址成功!"
}
```
