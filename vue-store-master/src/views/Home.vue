<!--
 * @Description: 首页组件
 * @Author: hai-27
 * @Date: 2020-02-07 16:23:00
 * @LastEditors: hai-27
 * @LastEditTime: 2020-02-27 13:36:12
 -->
<template>
  <div class="home" id="home" name="home">
    <!-- 轮播图 -->
    <div class="block">
      <el-carousel height="460px">
        <el-carousel-item v-for="item in carousel" :key="item.carouselId">
          <img style="height:460px;" :src="item.imgPath" :alt="item.describes" />
        </el-carousel-item>
      </el-carousel>
    </div>
    <!-- 轮播图END -->
    <div class="main-box">
      <div class="main">
        <!-- 食用菌商品展示区域 -->
        <div class="phone">
          <div class="box-hd">
            <div class="title">食用菌</div>
          </div>
          <div class="box-bd">
            <div class="promo-list">
              <router-link to>
                <li>
                  <img src="https://web-framework023.oss-cn-beijing.aliyuncs.com/store_system/carousel/p1.jpg" />
                </li>
                <li>
                  <img src="https://web-framework023.oss-cn-beijing.aliyuncs.com/store_system/carousel/p2.jpg" />
                </li>
              </router-link>
            </div>
            <div class="list">
              <MyList :list="mushroomList" :isMore="true"></MyList>
            </div>
          </div>
        </div>
        <!-- 食用菌商品展示区域END -->

        <!-- 蔬菜商品展示区域 -->
        <div class="appliance" id="promo-menu">
          <div class="box-hd">
            <div class="title">蔬菜</div>
            <div class="more" id="more">
              <MyMenu :val="2" @fromChild="getChildMsg">
                <span slot="1">热门</span>
                <span slot="2">顺序</span>
              </MyMenu>
            </div>
          </div>
          <div class="box-bd">
            <div class="promo-list">
              <ul>
                <li>
                  <img src="https://web-framework023.oss-cn-beijing.aliyuncs.com/store_system/carousel/p3.jpg" />
                </li>
                <li>
                  <img src="https://web-framework023.oss-cn-beijing.aliyuncs.com/store_system/carousel/p4.jpg" />
                </li>
              </ul>
            </div>
            <div class="list">
              <MyList :list="vList" :isMore="true"></MyList>
            </div>
          </div>
        </div>
        <!-- 家电商品展示区域END -->

        <!-- 水果商品展示区域 -->
        <div class="accessory" id="promo-menu">
          <div class="box-hd">
            <div class="title">水果</div>
            <div class="more" id="more">
              <MyMenu :val="3" @fromChild="getChildMsg2">
                <span slot="1">热门</span>
                <span slot="2">顺序</span>
              </MyMenu>
            </div>
          </div>
          <div class="box-bd">
            <div class="promo-list">
              <ul>
                <li>
                  <img src="https://web-framework023.oss-cn-beijing.aliyuncs.com/store_system/carousel/p5.jpeg" alt />
                </li>
                <li>
                  <img src="https://web-framework023.oss-cn-beijing.aliyuncs.com/store_system/carousel/p6.jpeg" alt />
                </li>
              </ul>
            </div>
            <div class="list">
              <MyList :list="fList" :isMore="true"></MyList>
            </div>
          </div>
        </div>
        <!-- 配件商品展示区域END -->
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      carousel: "", // 轮播图数据
      mushroomList: "", // 手机商品列表

      vegetableList: "", // 小米电视商品列表
      vegetableHotList: "",
      vList: "",

      fruitList: "", // 保护套商品列表
      fruitHotList: "",
      fList: "",

      vegetableActive: 1, // 家电当前选中的商品分类
      fruitActive: 1 // 配件当前选中的商品分类
    };
  },
  watch: {
    // 家电当前选中的商品分类，响应不同的商品数据
    vegetableActive: function(val) {
      // 页面初始化的时候把vegetableHotList(热门家电商品列表)直接赋值给vegetableList(家电商品列表)
      // 所以在切换商品列表时判断vegetableHotList是否为空,为空则是第一次切换,把vegetableList赋值给vegetableHotList
      if (this.vegetableHotList == "") {
        this.vList = this.vegetableList;
      }
      if (val == 1) {
        // 1为热门商品
        this.vList = this.vegetableHotList;
        return;
      }
      if (val == 2) {
        // 2为电视商品
        this.vList = this.vegetableList;
        return;
      }
    },
    fruitActive: function(val) {
      // 页面初始化的时候把fruitHotList(热门配件商品列表)直接赋值给fruitList(配件商品列表)
      // 所以在切换商品列表时判断fruitHotList是否为空,为空则是第一次切换,把fruitList赋值给fruitHotList
      if (this.fruitHotList == "") {
        this.fList = this.fruitList;
      }
      if (val == 1) {
        // 1为热门商品
        this.fList = this.fruitHotList;
        return;
      }
      if (val == 2) {
        // 2为保护套商品
        this.fList = this.fruitList;
        return;
      }
    }
  },
  created() {
    // 获取轮播图数据
    this.$axios
      .post("/api/resources/carousel", {})
      .then(res => {
        this.carousel = res.data.data;
      })
      .catch(err => {
        return Promise.reject(err);
      });
    // 获取各类商品数据
    this.getPromo(1, "mushroomList"); // 手机类别
    this.getPromo(2, "vegetableList"); // 手机类别
    this.getPromo(3, "fruitList"); // 手机类别

    this.getPromo(2, "vegetableHotList", "/api/product/getHotProduct"); // 手机类别
    this.getPromo(3, "fruitHotList", "/api/product/getHotProduct"); // 手机类别
  }, 
  methods: {
    // 获取家电模块子组件传过来的数据
    getChildMsg(val) {
      this.vegetableActive = (val === 1) ? 2 : 1;
    },
    // 获取配件模块子组件传过来的数据
    getChildMsg2(val) {
      this.fruitActive = (val === 1) ? 2 : 1;
    },
    // 获取各类商品数据方法封装
    getPromo(categoryId, val, api) {
      api = api != undefined ? api : "/api/product/getPromoProduct";
      this.$axios
        .post(api, {
          "categoryId": categoryId
        })
        .then(res => {
          this[val] = res.data.data;
          if(val == "vegetableHotList") this.vList = res.data.data;
          if(val == "fruitHotList") this.fList = res.data.data;
        })
        .catch(err => {
          return Promise.reject(err);
        });
    }
  }
};
</script>
<style scoped>
@import "../assets/css/index.css";
</style>