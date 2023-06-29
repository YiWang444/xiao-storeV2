<template>
  <div>
    <div class="basic-style voucher">
      <div class="coupon" v-for="item in voucherList" :key="item.id" @click="getVoucher(item.id)">
        <div class="main-coupon">
          <p class="coupon-shop">{{ item.title }}</p>
          <p class="coupon-value"> <span>￥</span> {{ item.actualValue }} <span>优惠券</span></p>
          <p class="coupon-required">订单满{{ item.payValue }}元使用</p>
        </div>
        <div class="vice-coupon">
          <p class="title">副券</p>
          <p class="start-date">{{ item.beginTime | dateFormat}}</p>
          <p class="end-date">{{ item.endTime | dateFormat}}</p>
        </div>
        <i></i>
      </div>
    </div>
  <!-- 另一种优惠券
    <div class="taobao-style">
      <div class="coupon">
        <div class="main">
          <div class="main-container">
            <div class="top">
              <span class="sign">￥</span>
              <span class="number">5</span>
              <span class="range">全店通用</span>
            </div>
            <p class="shop">发行店铺 : xxxx旗舰店</p>
            <p class="require">使用条件 : 满45.00</p>
            <p class="expire">使用期限 : 2016.03.03 至 2016.03.31</p>
          </div>
        </div>
        <div class="divider">
          <div class="divider-top"></div>
          <div class="divider-bottom"></div>
        </div>
        <div class="vice">
          <div class="vice-container">
            <p class="title">副券</p>
          </div>
        </div>
      </div>
    </div>
  -->
  </div>
</template>

<script>

  export default {
    data() {
      return {
        voucherList: []
      }
    },
    methods: {
      getVoucherList() {
        this.$axios.post("/api/voucher/getVoucherAll")
          .then(res => {
            this.voucherList = res.data.data;
          })
      },
      getVoucher(voucherId) {
        this.$axios.post("/api/voucher/getVoucher", {
          'userId': this.$store.getters.getUser.userId,
          'voucherId': voucherId
        })
        .then(res => {
          if(res.data.code === '001') {
            this.$message({
              message: '恭喜你，抢券成功',
              type: 'success'
            });
          }else {
            this.$message.error(res.data.msg);
          }
        })
      },
    },
    mounted() {
      this.getVoucherList();
    },
    filters: {
      dateFormat(value) {
        const date = new Date(value);
        const year = date.getFullYear();
        const month = ("0" + (date.getMonth() + 1)).slice(-2);
        const day = ("0" + date.getDate()).slice(-2);
        return `${year}-${month}-${day}`;
      }
  }
  }
</script>

<style scoped>
* {
	padding: 0;
	margin: 0;
	color: rgb(255, 255, 255);
	font-family: "Microsoft YaHei";
	font-size: 13px;
}

.voucher {
  width: 1225px;
  /* line-height: 30px;
  font-size: 16px; */
  margin: 0 auto;
}

body{
	padding: 20px;
}

/* basic style */


.basic-style .coupon {
  display: inline-block !important;
  margin-left: 15px;
	position: relative;
	width: 392px;
	height: 140px;
	overflow: hidden;
	background-color: #F39B00;
	background: radial-gradient(rgba(0, 0, 0, 0) 0, rgba(255, 0, 0, 0) 5px, #F39B00 5px);
	background-size: 15px 15px;
	background-position: 9px 3px;
}

.basic-style .coupon :hover{
  cursor: pointer;
}

.basic-style .coupon:before{
	content: '';
	position: absolute;
	top:0;
	bottom:0;
	left:10px;
	right:10px;
	z-index: -1;
	background-color:#F39B00;
}



.basic-style .coupon i{
	position: absolute;
	left: 20%;
	top: 45px;
	height: 190px;
	width: 390px;
	background-color: rgba(255, 255, 255, .15);
	transform: rotate(-30deg);
}

.basic-style .coupon .main-coupon {
	float: left;
	width: 220px;
	height: 100%;
	border-right: 2px dashed rgba(255, 255, 255, 0.3);
	padding: 15px;
}


.basic-style .coupon .vice-coupon {
	width: 100px;
	padding: 15px;
	display: inline-block;
}


.basic-style .coupon .vice-coupon {
	text-align: center;
}

.basic-style .coupon .coupon-value {
	font-size: 35px;
	margin-top: 25px;
}

.basic-style .coupon .vice-coupon .coupon-required {
	margin-top: 10px;
	text-align: center;
}

.basic-style .coupon .vice-coupon .title{
	font-size: 23px;
}

.basic-style .coupon .vice-coupon .start-date{
  font-size: 12px;
	margin-top: 45px;
}

.basic-style .coupon .vice-coupon .end-date{
  font-size: 12px;
}

/* taobao style */
.taobao-style .coupon{
	width: 241px;
	height: 258px;
	
}

.taobao-style .coupon .main{
	position: relative;
	width: 100%;
	height: 148px;
	background: radial-gradient(rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 4px, #F39B00 4px);
	background-size: 12px 12px;
	background-position: 0px 6px;	
}

.taobao-style .coupon .main:before{
	content: '';
	position: absolute;
	top: 6px;
	bottom: 0px;
	left: 0px;
	right: 0px;
	z-index: -1;
	background-color:#F39B00;
}

.taobao-style .coupon .divider{
	position: relative;
	width: 100%;
	height: 16px;	
}

.taobao-style .coupon .divider .divider-top{
	height: 50%;
	background-color: #F39B00;
	border-bottom: 2px dashed white;
}

.taobao-style .coupon .divider .divider-top:after{
	content: '';
	position: absolute;
	top: 0px;
	bottom: 50%;
	left: 0px;
	right: 230px;
	background: radial-gradient(white 0, white 5px, rgba(0, 0, 0, 0) 5px);
	background-size: 16px 16px;
	background-position: 8px 0px;	
}

.taobao-style .coupon .divider .divider-top:before{
	content: '';
	position: absolute;
	top: 0px;
	bottom: 50%;
	left: 230px;
	right: 0px;
	background: radial-gradient(white 0, white 5px, rgba(0, 0, 0, 0) 5px);
	background-size: 16px 16px;
	background-position: 2px 0px;	
}

.taobao-style .coupon .divider .divider-bottom{
	height: 50%;
	background-color: #9F9F9F;
}

.taobao-style .coupon .divider .divider-bottom:after{
	content: '';
	position: absolute;
	top: 50%;
	bottom: 0px;
	left: 0px;
	right: 230px;
	background: radial-gradient(white 0, white 5px, rgba(0, 0, 0, 0) 5px);
	background-size: 16px 16px;
	background-position: 8px 8px;	
}

.taobao-style .coupon .divider .divider-bottom:before{
	content: '';
	position: absolute;
	top: 50%;
	bottom: 0px;
	left: 230px;
	right: 0px;
	background: radial-gradient(white 0, white 5px, rgba(0, 0, 0, 0) 5px);
	background-size: 16px 16px;
	background-position: 2px 8px;	
}

.taobao-style .coupon .vice{
	position: relative;
	width: 100%;
	height: 100px;
	background: radial-gradient(rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 4px, #9F9F9F 4px);
	background-size: 12px 12px;
	background-position: 0px 10px;
}

.taobao-style .coupon .vice:after{
	content: '';
	position: absolute;
	top: 0px;
	bottom: 6px;
	left: 0px;
	right: 0px;
	z-index: -1;
	background-color: #9F9F9F;
}

/* ---- */
.taobao-style .coupon .main-container{
	position: relative;
	padding : 9px;
}

.taobao-style .coupon .main-container div.top{
	margin-bottom: 70px;
}

.taobao-style .coupon .main-container div.top span{
	position: absolute;	
}

.taobao-style .coupon .main-container div.top span.sign{
	top: 18px;
	left: 6px;
	font-size: 24px;
}

.taobao-style .coupon .main-container div.top span.number{
	top: 5px;
	left: 28px;
	font-size: 52px;
}

.taobao-style .coupon .main-container div.top span.range{
	top: 30px;
	right: 15px;
}

.taobao-style .coupon .vice-container {
	padding: 6px;
}

.taobao-style .coupon .vice-container .title{
	text-align: center;
}
</style>