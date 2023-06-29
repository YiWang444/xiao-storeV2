<template>
  <div>
    <baidu-map
        style="display:flex;flex-direction: column-reverse;" 
        id="allmap"
        @ready="mapReady"
        @click="getLocation"
        :scroll-wheel-zoom="true"
      >
        <div class="input-area">
          <el-input v-model="name" style="width:400px; margin-top: 15px" placeholder="请填写收货人姓名"></el-input>
          <el-input v-model="telephone" style="width:400px; margin-top: 15px;" placeholder="请填写收货人电话号码"></el-input>

          <div style="margin-top: 15px;"></div>

          <el-cascader
            size="large"
            :options="pcaTextArr"
            placeholder="请选择你所在的城市"
            v-model="addressOptions">
          </el-cascader>
          <bm-auto-complete v-model="searchJingwei" :sugStyle="{zIndex: 999999}" style="margin-top: 15px">
            <el-input v-model="addressDetail" style="width:400px; " placeholder="请输入详细地址" @blur="getAddressToPoint()"></el-input>
          </bm-auto-complete>
          <!-- <el-button type="primary" @click="getBaiduMapPoint">搜索</el-button> -->
        </div>
        <bm-map-type :map-types="['BMAP_NORMAL_MAP', 'BMAP_HYBRID_MAP']" anchor="BMAP_ANCHOR_TOP_LEFT"></bm-map-type>
        <bm-marker v-if="infoWindowShow" :position="{lng: longitude, lat: latitude}" :dragging="true" animation="BMAP_ANIMATION_BOUNCE"></bm-marker>
        <!--  经纬度窗口
        <bm-info-window :position="{lng: longitude, lat: latitude}" :show="infoWindowShow" @clickclose="infoWindowClose">
          <p>纬度:{{this.latitude}}</p>
          <p>经度:{{this.longitude}}</p>
        </bm-info-window>
        -->
        <bm-geolocation anchor="BMAP_ANCHOR_BOTTOM_RIGHT" :showAddressBar="true" :autoLocation="true" @locationSuccess="getPointToAddress"></bm-geolocation>
    </baidu-map>
    
  </div>
</template>

<script>
  import { pcaTextArr } from 'element-china-area-data'
  export default {
    data () {
      return {
        pcaTextArr,

        name: '',
        telephone: '',
        addressOptions: [] ,
        searchJingwei:'',
        // addressDetail: '',

        infoWindowShow:false,
        longitude:'',
        latitude:''
      }
    },
    methods: {
      changeAddressOptions({province, city, district, street, streetNumber}) {
        this.addressOptions = [province, city, district];
        this.searchJingwei = street + streetNumber;
      },

      //地图初始化
      mapReady({ BMap, map }) {
        this.BMap=BMap;
        this.map=map;

        this.getCurrentPosition();
      },
      getCurrentPosition() {
        //保存this指向，因为在百度的回调中this不指向vue
        const _this = this;
        // 获取自动定位方法
        var geolocation = new this.BMap.Geolocation();
        var gc = new this.BMap.Geocoder();

        geolocation.getCurrentPosition(
          function (r) {
            var pt = r.point;
            _this.map.centerAndZoom(pt, 12);
            gc.getLocation(pt, function (rs) {
                var addComp = rs.addressComponents;
                _this.changeAddressOptions(addComp);
            });
            //r里面包含了检索到的位置信息
            _this.longitude = r.point.lng
            _this.latitude =  r.point.lat
            _this.infoWindowShow=true
            
          },
          //启用高精度
          { enableHighAccuracy: true }
        );
      },
      //点击获取经纬度
      getLocation(e){
        this.longitude=e.point.lng
        this.latitude=e.point.lat
        this.infoWindowShow=true
      },
      getBaiduMapPoint(){
        let that=this
        let myGeo = new this.BMap.Geocoder()
        myGeo.getPoint(this.searchJingwei,function(point){
          if(point){
            that.map.centerAndZoom(point,15)
            that.latitude=point.lat
            that.longitude=point.lng
            that.infoWindowShow=true
          }
        })
      },
      //信息窗口关闭
      infoWindowClose(){
        this.latitude=''
        this.longitude=''
        this.infoWindowShow=false
      },
      getPointToAddress({point}) {
        //保存this指向，因为在百度的回调中this不指向vue
        const _this = this;
        var gc = new this.BMap.Geocoder();

        // 获取自动定位获取的坐标信息
        gc.getLocation(point, function (rs) {
            var addComp = rs.addressComponents;
            
            _this.changeAddressOptions(addComp);
        });
        
        _this.longitude = point.lng;
        _this.latitude =  point.lat;
        _this.infoWindowShow = true;
      },
      getAddressToPoint() {
        let pre = this.addressOptions[0] + this.addressOptions[1] + this.addressOptions[2] + this.searchJingwei;
        let address = pre + this.searchJingwei;

        //保存this指向，因为在百度的回调中this不指向vue
        const _this = this;
        var gc = new this.BMap.Geocoder();
        
        gc.getPoint(address,function (point) {
          if(point){
            _this.map.centerAndZoom(point,15)
            _this.longitude = point.lng;
            _this.latitude =  point.lat;
            _this.infoWindowShow = true;

            console.log("X:" + _this.longitude + ",Y:" + _this.latitude);
          }
        });
      },
      // 删除 ..省, ..市, ..区的前缀
      deletePreAddress(address) {
        const provinceIndex = address.indexOf("省");
        if(provinceIndex !== -1) address = address.slice(provinceIndex + 1);

        const cityIndex = address.indexOf("市");
        if(cityIndex !== -1) address = address.slice(cityIndex + 1);
        
        const districtIndex = address.indexOf("区");
        if(districtIndex !== -1) address = address.slice(districtIndex + 1);

        return address;
      },

      callGetAddress() {
        return {
            name: this.name,
            telephone: this.telephone,
            province: this.addressOptions[0], 
            city: this.addressOptions[1], 
            district: this.addressOptions[2], 
            detail: this.searchJingwei
        };
      }
    },
    computed: {
      addressDetail: {
        get() {
          return this.deletePreAddress(this.searchJingwei);
        },
        set(newValue) {
          this.searchJingwei = this.deletePreAddress(newValue);
        }
      }
    }
  }
</script>

<style scoped>

  .input-area {
    margin: 15px;
    display: flex;
    flex-direction: column; /* 垂直方向排列 */
    justify-content: center; /* 垂直居中对齐 */
    align-items: center; /* 水平居中对齐 */
  }

  .el-cascader {
    width: 400px !important;
  }

  #allmap{
    height: 450px;
    width: 450px;
    margin: 10px 0;
  }
</style>
