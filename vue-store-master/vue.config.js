module.exports = {
  publicPath: './',
  devServer: {
    open: true,
    proxy: {
      '/api': {
        target: 'http://localhost:18888/', // 本地后端地址
        changeOrigin: true, //允许跨域
        pathRewrite: {
          '^/api': ''
        }
      }
    }
  }
}