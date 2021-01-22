//app.js
App({
  onLaunch: function () {
    var logs = wx.getStorageSync('logs') || []
    logs.unshift(Date.now())
    wx.setStorageSync('logs', logs)

    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
      }
    })
  },
  globalData: {
    APP_ID : 'wx9c8f760162254c72',//输入小程序appid  
    APP_SECRET : '2e72cc122150ef5ef140ba24c223ebb1',//输入小程序app_secret  
    userInfo: null,
    openid:"",
    code:"",
    url: 'http://47.107.176.184:8080',//云服务器
    sessionId:'',
    sessionCarId:'',
    isInput: false,  //判断是否停车
    timer:''
  }
})