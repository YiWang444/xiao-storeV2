<!--
 * @Description: 商品详情页面组件
 * @Author: hai-27
 * @Date: 2020-02-16 20:20:26
 * @LastEditors: hai-27
 * @LastEditTime: 2020-03-07 21:59:26
 -->
<template>
  <div id="details">
    <!-- 头部 -->
    <div class="page-header">
      <div class="title">
        <p>{{productDetails.productName}}</p>
        <div class="list">
          <ul>
            <li>
              <router-link to>概述</router-link>
            </li>
            <li>
              <router-link to>参数</router-link>
            </li>
            <li>
              <router-link to>用户评价</router-link>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <!-- 头部END -->

    <!-- 主要内容 -->
    <div class="main">
      <!-- 左侧商品轮播图 -->
      <div class="block">
        <el-carousel height="560px" v-if="productPicture.length">
          <el-carousel-item v-for="item in productPicture" :key="item.id">
            <img style="height:560px;" :src="item.productPicture" :alt="item.intro" />
          </el-carousel-item>
        </el-carousel>
        <div v-if="productPicture.length==1">
          <img
            style="height:560px;"
            :src="productPicture[0].productPicture"
            :alt="productPicture[0].intro"
          />
        </div>
      </div>
      <!-- 左侧商品轮播图END -->

      <!-- 右侧内容区 -->
      <div class="content">
        <h1 class="name">{{productDetails.productName}}</h1>
        <p class="intro">{{productDetails.productIntro}}</p>
        <p class="store">农户自营</p>
        <div class="price">
          <span>{{productDetails.productSellingPrice}}元</span>
          <span
            v-show="productDetails.productPrice != productDetails.productSellingPrice"
            class="del"
          >{{productDetails.productPrice}}元</span>
        </div>
        <div class="pro-list">
          <span class="pro-name">{{productDetails.productName}}</span>
          <span class="pro-price">
            <span>{{productDetails.productSellingPrice}}元</span>
            <span
              v-show="productDetails.productPrice != productDetails.productSellingPrice"
              class="pro-del"
            >{{productDetails.productPrice}}元</span>
          </span>
          <p class="price-sum">总计 : {{productDetails.productSellingPrice}}元</p>
        </div>
        <!-- 内容区底部按钮 -->
        <div class="button">
          <el-button class="shop-cart" :disabled="dis" @click="addShoppingCart">加入购物车</el-button>
          <el-button class="like" @click="addCollect">喜欢</el-button>
        </div>
        <!-- 内容区底部按钮END -->
        <div class="pro-policy">
          <ul>
            <li>
              <i class="el-icon-circle-check"></i> 农户自营
            </li>
            <li>
              <i class="el-icon-circle-check"></i> 极速发货
            </li>
            <li>
              <i class="el-icon-circle-check"></i> 7天无理由退货
            </li>
            <li>
              <i class="el-icon-circle-check"></i> 7天价格保护
            </li>
          </ul>
          
        </div>
        
      </div>
      <!-- 右侧内容区END -->
      
    </div>
    <!-- 主要内容END -->
    
    <!-- <ul v-for="item in this.discussionList[0].childrenList" :key="item.id">
      <li>{{item.content}}</li>
    </ul> -->

    <div style="width: 1225px; margin: 0 auto">
      <Comment 
        placeholder="123" 
        commentWidth="95%"
        :avatar="user.userImg"
        :commentNum="discussionCount"
        :authorId="user.userId == undefined ? null : user.userId"
        :commentList="discussionList"
        @doSend="doSend"
        @doChidSend="doChidSend"
        ></Comment>
    </div>

    <el-divider></el-divider>
    
    <p style="text-align: center; color: #909399" v-if="loading">正在加载...</p>
    <p style="text-align: center; color: #909399" v-if="lastPage">评论已经到底啦...</p>
    <p style="text-align: center; color: #909399" v-if="ishasMore">请下拉到底部获取更多评论...</p>
  </div>
</template>

<script>
import { mapActions } from "vuex";
import { throttle } from 'lodash';
import Comment from '../components/Comment/Comment.vue'

export default {
  data() {
    return {
      user: {},

      discussionList: [], // 已加载数据的数组
      discussionCount: 0, // 评论个数
      currentPage: 1, // 当前页码
      loading: false, // 添加loading动画 
      lastPage: false, // 是否最后一页,如果最后一页了就不再发送请求了
      ishasMore: true, // 
      
      dis: false, // 控制“加入购物车按钮是否可用”
      productId: Number,
      productDetails: {}, // 商品详细信息
      productPicture: [] // 商品图片
    };
  },
  // 通过路由获取商品id
  created() {
    if (this.$route.query.productId != undefined) {
      this.productId = parseInt(this.$route.query.productId);
    }
  },
  watch: {
    // 监听商品id的变化，请求后端获取商品数据
    
    productId: function(val) { 
      this.getDetails(val);
      this.getDetailsPicture(val);
    }
  },
  methods: {
    ...mapActions(["unshiftShoppingCart", "addShoppingCartNum"]),
    // 获取商品详细信息
    getDetails(val) {
      this.$axios
        .post("/api/product/getDetails", {
          "productId": val
        })
        .then(res => {
          this.productDetails = res.data.data;
        })
        .catch(err => {
          return Promise.reject(err);
        });
    },
    // 获取商品图片
    getDetailsPicture(val) {
      this.$axios
        .post("/api/product/getDetailsPicture", {
          "productId": val
        })
        .then(res => {
          this.productPicture = res.data.data;
        })
        .catch(err => {
          return Promise.reject(err);
        });
    },
    // 加入购物车
    addShoppingCart() {
      // 判断是否登录,没有登录则显示登录组件
      if (!this.$store.getters.getUser) {
        this.$store.dispatch("setShowLogin", true);
        return;
      }
      
      this.$axios
        .post("/api/shoppingCart/addShoppingCart", {
          "userId": this.$store.getters.getUser.userId,
          "productId": this.productId
        })
        .then(res => {
          
          switch (res.data.code) {
            case "001":
              // 新加入购物车成功
              this.unshiftShoppingCart(res.data.data);
              this.notifySucceed(res.data.msg);
              break;
            case "002":
              // 该商品已经在购物车，数量+1
              this.addShoppingCartNum(this.productId);
              console.log()
              this.notifySucceed(res.data.msg);
              break;
            case "003":
              // 商品数量达到限购数量
              this.dis = true;
              this.notifyError(res.data.msg);
              break;
            default:
              this.notifyError(res.data.msg);
          }
        })
        .catch(err => {
          return Promise.reject(err);
        });
    },
    addCollect() {
      // 判断是否登录,没有登录则显示登录组件
      if (!this.$store.getters.getUser) {
        this.$store.dispatch("setShowLogin", true);
        return;
      }
      this.$axios
        .post("/api/collect/addCollect", {
          "userId": this.$store.getters.getUser.userId,
          "productId": this.productId
        })
        .then(res => {
          if (res.data.code == "001") {
            // 添加收藏成功
            this.notifySucceed(res.data.msg);
          } else {
            // 添加收藏失败
            this.notifyError(res.data.msg);
          }
        })
        .catch(err => {
          return Promise.reject(err);
        });
    },
    getUserInfo() {
      this.$axios.post("/api/users/getUserInfo" ,{
          "userId": this.$store.getters.getUser.userId
      }).then(res => {
          this.user = res.data.data;
      })
    },

    // 评论函数
    getDiscussionInfo(currentPage = 1) {
      console.log(this.productId)
        this.$axios.post("/api/discussion/getDiscussionInfo" ,{
            "productId": this.productId,
            "currentPage": currentPage,
            "lastDiscussionId": 0 // 默认不开启分页过滤
        }).then(res => {
            if(res.data.code === '002') {
              this.$message.error(res.data.msg);
            }else{
              this.discussionList.push(...res.data.data);
            }

            if(this.discussionList.length == this.discussionCount) {
              this.lastPage = true;
              this.ishasMore = false;
            }
            this.loading = false;
        })
    },
    getDiscussionCount() {
        this.$axios.post("/api/discussion/getDiscussionCount" ,{
            "productId": this.productId
        }).then(res => {
            this.discussionCount =  res.data.data;
        })
    },
    async doSend(content) {
      const isBuy = await this.isCheckBuy();

      if(!isBuy) return false;

      this.$axios.post("/api/discussion/addDiscussion" ,{
          "userId": this.$store.getters.getUser.userId,
          "productId": this.productId,
          "content": content
      }).then(res => {
          this.discussionCount++;
          this.discussionList.unshift(res.data.data);

          this.$message.success('评论成功!');
      })
    },
    async doChidSend(content, userId, parentId, arrIndex, touchId) {
      const isBuy = await this.isCheckBuy();

      if(!isBuy) return false;
      
      this.$axios.post("/api/discussion/addSunDiscussion" ,{
          "userId": userId,
          "parentId": parentId,
          "productId": this.productId,
          "touchId": touchId,
          "content": content
      }).then(res => {
        this.discussionList[arrIndex].childrenList.push(res.data.data);
        this.$message.success('评论成功!');
      })
    },

    async isCheckBuy() {
      if (!this.$store.getters.getUser) {
        this.$store.dispatch("setShowLogin", true);
        return false;
      }

      try {
        const res = await this.$axios.post("/api/order/checkBuy", {
          "userId": this.$store.getters.getUser.userId,
          "productId": this.productId
        });

        if (res.data.code === '001') {
          return true;
        } else {
          this.$message.error('请购买后再评论!');
          return false;
        }
      } catch (error) {
        console.error(error);
        return false;
      }
    },
    // 下拉滚动 - 监听滚动条
    handleScroll() {
      const scrollHeight = document.documentElement.scrollHeight;
      const scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
      const clientHeight = document.documentElement.clientHeight;

      if(scrollTop + clientHeight >= scrollHeight && !this.lastPage) {
        this.ishasMore = false; this.loading = true;
        this.currentPage++;

        this.$axios.post("/api/discussion/getDiscussionInfo" ,{
            "productId": this.productId,
            "currentPage": this.currentPage,
            "lastDiscussionId": this.discussionList[this.discussionList.length - 1].id
        }).then(res => {
          this.loading = false;

          if(res.data.code === '002') {
              this.$message.error(res.data.msg);
              this.lastPage = true;
              this.ishasMore = false;
          }else{
            var flag = true;
            
            for(var item of res.data.data) {
              this.discussionList.push(item);

              if(this.discussionList.length == this.discussionCount) {
                this.lastPage = true;
                flag = false;
                break;
              }
            }

            this.ishasMore = flag;
          }
        })
      }
    }
  },
  mounted() {
    this.getUserInfo();
    this.getDiscussionInfo();
    this.getDiscussionCount();

    window.addEventListener('scroll', throttle(this.handleScroll, 500));
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  components:{
    Comment
  }
};
</script>
<style>
/* 头部CSS */
#details .page-header {
  height: 64px;
  margin-top: -20px;
  z-index: 4;
  background: #fff;
  border-bottom: 1px solid #e0e0e0;
  -webkit-box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.07);
  box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.07);
}
#details .page-header .title {
  width: 1225px;
  height: 64px;
  line-height: 64px;
  font-size: 18px;
  font-weight: 400;
  color: #212121;
  margin: 0 auto;
}
#details .page-header .title p {
  float: left;
}
#details .page-header .title .list {
  height: 64px;
  float: right;
}
#details .page-header .title .list li {
  float: left;
  margin-left: 20px;
}
#details .page-header .title .list li a {
  font-size: 14px;
  color: #616161;
}
#details .page-header .title .list li a:hover {
  font-size: 14px;
  color: #ff6700;
}
/* 头部CSS END */

/* 主要内容CSS */
#details .main {
  width: 1225px;
  height: 560px;
  padding-top: 30px;
  margin: 0 auto;
}
#details .main .block {
  float: left;
  width: 560px;
  height: 560px;
}
#details .el-carousel .el-carousel__indicator .el-carousel__button {
  background-color: rgba(163, 163, 163, 0.8);
}
#details .main .content {
  float: left;
  margin-left: 25px;
  width: 640px;
}
#details .main .content .name {
  height: 30px;
  line-height: 30px;
  font-size: 24px;
  font-weight: normal;
  color: #212121;
}
#details .main .content .intro {
  color: #b0b0b0;
  padding-top: 10px;
}
#details .main .content .store {
  color: #ff6700;
  padding-top: 10px;
}
#details .main .content .price {
  display: block;
  font-size: 18px;
  color: #ff6700;
  border-bottom: 1px solid #e0e0e0;
  padding: 25px 0 25px;
}
#details .main .content .price .del {
  font-size: 14px;
  margin-left: 10px;
  color: #b0b0b0;
  text-decoration: line-through;
}
#details .main .content .pro-list {
  background: #f9f9fa;
  padding: 30px 60px;
  margin: 50px 0 50px;
}
#details .main .content .pro-list span {
  line-height: 30px;
  color: #616161;
}
#details .main .content .pro-list .pro-price {
  float: right;
}
#details .main .content .pro-list .pro-price .pro-del {
  margin-left: 10px;
  text-decoration: line-through;
}
#details .main .content .pro-list .price-sum {
  color: #ff6700;
  font-size: 24px;
  padding-top: 20px;
}
#details .main .content .button {
  height: 55px;
  margin: 10px 0 20px 0;
}
#details .main .content .button .el-button {
  float: left;
  height: 55px;
  font-size: 16px;
  color: #fff;
  border: none;
  text-align: center;
}
#details .main .content .button .shop-cart {
  width: 340px;
  background-color: #ff6700;
}
#details .main .content .button .shop-cart:hover {
  background-color: #f25807;
}

#details .main .content .button .like {
  width: 260px;
  margin-left: 40px;
  background-color: #b0b0b0;
}
#details .main .content .button .like:hover {
  background-color: #757575;
}
#details .main .content .pro-policy li {
  float: left;
  margin-right: 20px;
  color: #b0b0b0;
}
/* 主要内容CSS END */
</style>