<template>
    <el-row style="max-width: 1000px; height: 400px; margin: 0 auto;">
        <el-col :span="4"></el-col>
        <el-col :span="6">
            <el-row style="margin: 5px 0px 0px -3px">
                <el-col :span="10"></el-col>
                <el-col>
                    <!-- upload -->
                    <el-tooltip class="item" effect="dark" content="点击更改头像" placement="bottom">
                        <el-upload
                            class="avatar-uploader"
                            action=""
                            :show-file-list="false"
                            :before-upload="beforeAvatarUpload"
                            :http-request="uploadRequest"
                            >
                            <img v-if="user.userImg" :src="user.userImg" class="avatar">
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        </el-upload>
                    </el-tooltip>
                </el-col>
            </el-row>

        </el-col>
        <el-col :span="11" style="margin-top: 15px;">
            <el-form :model="checkForm" status-icon :rules="rules" ref="checkForm" label-width="100px" class="demo-form">
                <el-form-item label="用户" prop="name" class="form-inline-item">
                    <el-input 
                        prefix-icon="el-icon-user-solid" 
                        placeholder="请输入账号"
                        v-model="checkForm.name"
                        class="disabled"
                    >
                    </el-input>
                    <el-button @click="handleForm('nameFrom')" type="primary" style="margin-left: 10px;">修改名称</el-button>
                </el-form-item>
                
                <el-form-item label="密码" prop="pass" class="form-inline-item">
                    <el-input 
                        prefix-icon="el-icon-view" 
                        placeholder="请先输入旧的密码"
                        type="password" 
                        v-model="checkForm.pass" 
                        autocomplete="off"></el-input>
                    <el-button @click="handleForm('passForm')" type="primary" style="margin-left: 10px;">修改密码</el-button>

                </el-form-item>

                <el-form-item label="手机号" prop="tel" class="form-inline-item">
                    <el-input
                        prefix-icon="el-icon-mobile-phone"
                        placeholder="请输入手机号"
                        type="tel"
                        v-model="checkForm.tel"
                        class="disabled"
                    ></el-input>
                    <el-button @click="handleForm('telForm')" type="primary" style="margin-left: 10px;">发送短信</el-button>
                </el-form-item>
            </el-form>

            <!-- nameFrom -->
            <el-dialog
                title="修改账户名"
                :visible.sync="isOpenNameFrom"
                width="30%"
                center
            >
                
                <el-form :model="nameFrom" status-icon :rules="rules" ref="nameFrom" label-width="100px">
                    <el-form-item label="用户" prop="name" class="form-inline-item">
                        <el-input 
                            prefix-icon="el-icon-user-solid" 
                            placeholder="请输入账号"
                            v-model="nameFrom.name"
                        >
                        </el-input>
                    </el-form-item>
                </el-form>


                <span slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm('nameFrom')">提交</el-button>
                    <el-button @click="resetForm('nameFrom')">重置</el-button>
                </span>
            </el-dialog>

            <!-- passForm -->
            <el-dialog
                title="修改密码"
                :visible.sync="isOpenPassForm"
                width="30%"
                center
            >
                
                <el-form :model="passForm" status-icon :rules="rules" ref="passForm" label-width="100px">
                    <el-form-item label="密码" prop="pass">
                        <el-input 
                            prefix-icon="el-icon-view" 
                            placeholder="请输入密码"
                            type="password" 
                            v-model="passForm.pass" 
                            autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="确认密码" prop="confirmPass">
                        <el-input 
                            prefix-icon="el-icon-view" 
                            placeholder="请输入密码"
                            type="password" 
                            v-model="passForm.confirmPass" 
                            autocomplete="off"></el-input>
                    </el-form-item>
                </el-form>


                <span slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm('passForm')">提交</el-button>
                    <el-button @click="resetForm('passForm')">重置</el-button>
                </span>
            </el-dialog>

            <!-- telForm -->
            <el-dialog
                title="修改密码"
                :visible.sync="isOpenTelForm"
                width="30%"
                center
            >
                
                <el-form :model="telForm" status-icon :rules="rules" ref="telForm" label-width="100px">
                    <el-form-item label="手机号" prop="tel">
                        <el-input
                            prefix-icon="el-icon-mobile-phone"
                            placeholder="请输入手机号"
                            type="tel"
                            v-model="telForm.tel"
                        ></el-input>
                    </el-form-item>
                </el-form>


                <span slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm('telForm')">提交</el-button>
                    <el-button @click="resetForm('telForm')">重置</el-button>
                </span>
            </el-dialog>
        </el-col>
        <el-col :span="3"></el-col>

    </el-row>
</template>

<script>
  import OSS from 'ali-oss';
  import CryptoJS from 'crypto-js';

  export default {
    data() {
        // 用户名的校验方法
        let validateName = (rule, value, callback) => {
            if (!value) {
                return callback(new Error("请输入用户名"));
            }
            // 用户名以字母开头,长度在5-16之间,允许字母数字下划线
            const userNameRule = /^[a-zA-Z][a-zA-Z0-9_]{4,15}$/;
            if (userNameRule.test(value)) {
                return callback();
            } else {
                return callback(new Error("字母开头,长度5-16之间,允许字母数字下划线"));
            }
        };
        let validatePass = (rule, value, callback) => {
            if (value === "") {
                return callback(new Error("请输入密码"));
            }
            // 密码以字母开头,长度在6-18之间,允许字母数字和下划线
            const passwordRule = /^[a-zA-Z]\w{5,17}$/;
            if (passwordRule.test(value)) {
                return callback();
            } else {
                return callback(
                    new Error("字母开头,长度6-18之间,允许字母数字和下划线")
                );
            }
        };
        // 确认密码的校验方法
        let validateConfirmPass = (rule, value, callback) => {
            if (value === "") {
                return callback(new Error("请输入确认密码"));
            }
            // 校验是否以密码一致
            if (this.passForm.pass != "" && value === this.passForm.pass) {
                return callback();
            } else {
                return callback(new Error("两次输入的密码不一致"));
            }
        };

        return {
            isOpenNameFrom: false,
            isOpenPassForm: false,
            isOpenTelForm: false,
            user: {},
            checkForm: {
                name: "",
                pass: "",
                tel: ""
            },
            nameFrom: {
                name: ""
            },
            passForm: {
                pass: "",
                confirmPass: ""
            },
            telForm: {
                tel: ""
            },
            rules: {
                name: [{ validator: validateName, trigger: "blur" }],
                pass: [{ validator: validatePass, trigger: "blur" }],
                confirmPass: [{ validator: validateConfirmPass, trigger: "blur" }],
                tel: [
                    { message: "请输入手机号", trigger: "blur" },
                    { pattern: /^1[3456789]\d{9}$/, message: "请输入正确的手机号", trigger: "blur" },
                ]
            },
            OSSClient: {}
        };
    },
    methods: {
        getUserInfo() {
            this.$axios.post("/api/users/getUserInfo" ,{
                "userId": this.$store.getters.getUser.userId
            }).then(res => {
                this.user = res.data.data;
                this.checkForm.name = this.user.userName;
                this.checkForm.tel = this.user.telephone;
            })
        },
        handleForm(targetFrom) {
            if(targetFrom === 'nameFrom') {
                this.isOpenNameFrom = true;
            }else if(targetFrom === 'passForm') {
                // 校验密码是否正确
                this.$axios.post("/api/users/checkField" ,{
                    "userId": this.$store.getters.getUser.userId,
                    "field": 'password',
                    "value": this.checkForm.pass
                }).then(res => {
                    let code = res.data.code;
                    if(code === '001') {
                        this.isOpenPassForm = true;
                    }else{
                        this.$message.error(res.data.msg);
                    }
                })
            }else if(targetFrom === 'telForm') {
                // 校验电话号码 && 返回验证码 是否正确
                this.$axios.post("/api/users/checkField" ,{
                    "userId": this.$store.getters.getUser.userId,
                    "field": 'telephone',
                    "value": this.checkForm.tel
                }).then(res => {
                    let code = res.data.code;
                    if(code === '001') {
                        this.isOpenTelForm = true;
                    }else{
                        this.$message.error(res.data.msg);
                    }
                })
            }
        },
        // upload
        beforeAvatarUpload(file) {
            const isJPG = file.type === 'image/jpeg';
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isJPG) {
            this.$message.error('上传头像图片只能是 JPG 格式!');
            }
            if (!isLt2M) {
            this.$message.error('上传头像图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
        },
        uploadRequest(option) {
            // get File
            let file = option.file;

            // 获取文件名称及后缀名
            const fileName = file.name;
            const extension = fileName.split('.').pop();

            // 使用哈希算法生成新的文件名
            const hash = CryptoJS.MD5(fileName + new Date()).toString();
            const newFileName = `store_system/user/${hash}.${extension}`;

            // object表示上传到OSS的文件名称。
            // file表示浏览器中需要上传的文件，支持HTML5 file和Blob类型。
            this.OSSClient.put(newFileName, file).then(r1 => {
                console.log('put success: %j', r1);
                this.returnFile = r1
                // return this.client.get('object');
            }).then(r2 => {
                this.handleSuccess(newFileName);
                console.log('get success: %j', r2);
            }).catch(err => {
                this.$Message.erros('上传失败');
                console.error('error: %j', err);
            })
        },
        handleSuccess(fileName) {
            console.log(fileName);
            
            this.$axios.post("/api/users/saveUserImg" ,{
                "userId": this.$store.getters.getUser.userId,
                "fileName": fileName
            }).then(res => {
                let code = res.data.code;
                if(code === '001') {
                    this.user.userImg = res.data.data;
                    this.$message.success("更新头像成功");
                    // setTimeout(() => {
                    //     location.reload();
                    // }, 250);
                }else{
                    this.OSSClient.delete(fileName);
                    this.$message.error("更新头像失败");
                }
            })
        },
        // Form
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
            if (valid) {

                if(formName === 'nameFrom') {
                    this.$axios.post("/api/users/updateField" ,{
                        "userId": this.$store.getters.getUser.userId,
                        "field": "name",
                        "value": this.nameFrom.name
                    }).then(res => {
                        let code = res.data.code;
                        if(code === '001') {
                            this.isOpenNameFrom = false;
                            this.checkForm.name = this.nameFrom.name;
                            this.nameFrom.name = "";

                            this.$message.success("更新用户名称成功");
                        }else{
                            this.$message.error(res.data.msg);
                        }
                    })
                } else if(formName === 'passForm') {
                    this.$axios.post("/api/users/updateField" ,{
                        "userId": this.$store.getters.getUser.userId,
                        "field": "password",
                        "value": this.passForm.pass
                    }).then(res => {
                        let code = res.data.code;
                        if(code === '001') {
                            this.isOpenPassForm = false;
                            this.checkForm.pass = this.passForm.pass = this.passForm.confirmPass = "";
                        
                            this.$message.success("更新密码成功");
                        }else{
                            this.$message.error(res.data.msg);
                        }
                    })
                } else {
                    this.$axios.post("/api/users/updateField" ,{
                        "userId": this.$store.getters.getUser.userId,
                        "field": "telephone",
                        "value": this.telForm.tel
                    }).then(res => {
                        let code = res.data.code;
                        if(code === '001') {
                            this.isOpenTelForm = false;
                            this.checkForm.tel = this.telForm.tel;
                            this.telForm.tel = "";

                            this.$message.success("更新号码成功");
                        }else{
                            this.$message.error(res.data.msg);
                        }
                    })
                }
                
            } else {
                console.log('error submit!!');
                return false;
            }
            });
        },
        resetForm(formName) {
            this.$refs[formName].resetFields();
        },
    },
    mounted() {
        this.getUserInfo();

        this.OSSClient = new OSS({
            region: '',
            accessKeyId: '',
            accessKeySecret: '',
            bucket: ''
        });
    }
  }
</script>
    
<style>
    .space-content {
        padding: 0px 50px 0px 50px;
    }

    .submit-container {
        display: flex;
        justify-content: center; 
        align-items: center;
    }
    
    .avatar-uploader .el-upload {
        border: 1px dashed #d9d9d9;
        border-radius: 6px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
    }
    .avatar-uploader .el-upload:hover {
        border-color: #409EFF;
    }
    .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 178px;
        height: 178px;
        line-height: 178px;
        text-align: center;
    }
    .avatar {
        width: 178px;
        height: 178px;
        display: block;
    }

    .form-inline-item .el-form-item__content {
        display: flex;
    }

    .form-item-center {
        margin: auto;
    }

    .el-form-item__label {
        text-align: center;
    }

    .disabled {
        pointer-events: none;
        filter: grayscale(100%);
        opacity: 0.5;
    }
</style>