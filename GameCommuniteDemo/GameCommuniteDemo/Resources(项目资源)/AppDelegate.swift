//
//  AppDelegate.swift
//  SwiftBaseDemo
//
//  Created by kuroneko on 2019/7/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Toast_Swift
import IQKeyboardManagerSwift
import Bugly
import Alamofire
import NIMSDK
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isLandscape = false//是否横屏
    var netMoniter: NetworkReachabilityManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //GCUserDefault.shareInstance.resignLogin()
        
        initRootViewController()
        configSwiftToast()
        configIQKeyboard()
        configBugly()
        configNetMoniter()
        configYunXinSDK()

        registerPushService()
        configYouMengSKD()
        return true
    }
    //即将进入后台
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    //已经进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        //配置为读数前台和后台一致
        let count = NIMSDK.shared().conversationManager.allUnreadCount()
        UIApplication.shared.applicationIconBadgeNumber = count
    
    }
    //即将进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }
    //已经进入前台
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    //将要结束进程
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("云信通知--devicetoken: \(deviceToken.map { String(format: "%02.2hhx", arguments: [$0])}.joined())")
        NIMSDK.shared().updateApnsToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("云信通知--\(userInfo)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("云信通知--error: \(error.localizedDescription)")
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let result = UMSocialManager.default()?.handleOpen(url, options: options) {
            if !result {
                // 其他如支付等SDK的回调
                
            }
            return result
        }
        return false
    }
}

extension AppDelegate{
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if isLandscape {
            return .all
        }else{
            return .portrait
        }
    }
}

extension AppDelegate {
    
    //TODO: ------------rootController------------
    private func initRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = GCBaseTabbarController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
    //TODO: ------------Swift_Toast------------
    private func configSwiftToast(){
        //设置弹窗style
        var style = ToastStyle()
        style.messageColor = .white
        style.messageFont = kFont(14)
        ToastManager.shared.style = style
        ToastManager.shared.duration = 1.0

    }
    
    //TODO: ------------IQKeyboardManager------------
    private func configIQKeyboard(){
        //设置弹窗style
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.disabledToolbarClasses = [GCBaseVC.self]
//        IQKeyboardManager.shared.disabledToolbarClasses = [ViewController.self]
    }
    
    //TODO: ------------Bugly------------
     private func configBugly(){
        
        Bugly.start(withAppId: MetricSDK.Bugly_appid)
    }
    
    //TODO: ------------网络状态检测------------
    private func configNetMoniter(){
        let net = NetworkReachabilityManager()
        self.netMoniter = net
        net?.startListening()
        net?.listener = {status in
            switch status {
            case .notReachable:
                JYLog("网络不可用")
            case .unknown:
                JYLog("未知网络")
            case .reachable(.ethernetOrWiFi):
                JYLog("wifi")
            case .reachable(.wwan):
                JYLog("移动网络")
            }
        }
    }

    //TODO: ------------苹果内购------------
    private func appPayStoreConfig() {
        
    }

}
//MARK: ------------友盟配置------------
extension AppDelegate {
    
    private func configYouMengSKD(){
        //log
        UMCommonLogManager.setUp()
        UMConfigure.setLogEnabled(true)
        
        //注册
        UMConfigure.initWithAppkey(MetricSDK.YM_appkey, channel: "")
        
        //注册qq
        UMSocialManager.default()?.setPlaform(.QQ, appKey: MetricSDK.QQ_appid, appSecret: nil, redirectURL: nil)
 
    }
    
}

//MARK: ------------云信配置------------
extension AppDelegate: NIMLoginManagerDelegate{
    
    
    
    ///配置sdk
    private func configYunXinSDK(){
        
        //配置
        let setting = NIMServerSetting()
        setting.httpsEnabled = false //返回http地址
        NIMSDK.shared().serverSetting = setting
        
        //消息, 包括图片，视频，音频信息都是默认托管在云信上,SDK 会针对他们自动开启 HTTPS 支持，将原本 HTTP URL 转化成可用的 HTTPS URL 。
//        NIMSDKConfig.shared().enabledHttpsForInfo = true
//        NIMSDKConfig.shared().enabledHttpsForMessage = true
        
        //设置该值后 SDK 产生的数据(包括聊天记录，但不包括临时文件)都将放置在这个目录下
        NIMSDKConfig.shared().setupSDKDir(MetricSDK.WYYX_DataDir)

        let options = NIMSDKOption(appKey: MetricSDK.WYYX_appkey)
        //云信推送配置
        options.apnsCername = MetricSDK.WYYX_apnsCername
        print("云信--apns: \(MetricSDK.WYYX_apnsCername)")
        //注册
        NIMSDK.shared().register(with: options)
        
        

        //云信自动登录。
        yunXinAutoLogin()
    }
    
    ///云信自动登录
    func yunXinAutoLogin() {
        
        if let user = GCUserDefault.shareInstance.userInfo, let userAcc = user.neteasyAccid, let userToken = user.neteasyToken {
            
            JYLog("云信accountID：\(userAcc)")
            
            let loginData = NIMAutoLoginData()
            loginData.account = userAcc
            loginData.token = userToken
            loginData.forcedMode = true
            
            NIMSDK.shared().loginManager.autoLogin(loginData)
            NIMSDK.shared().loginManager.add(self)  
        }
    }
    
    //登录状态回调
    func onLogin(_ step: NIMLoginStep) {
        switch step {
        case .linking:
            JYLog("云信--连接服务器中")
        case .linkOK:
            JYLog("云信--连接服务器成功")
        case .linkFailed:
            JYLog("云信--连接服务器失败")
        case .logining:
            JYLog("云信--登录中")
        case .loginOK:
            JYLog("云信--登录成功")
        case .loginFailed:
            JYLog("云信--登录失败")
        case .syncing:
            JYLog("云信--开始同步数据")
        case .syncOK:
            JYLog("云信--同步数据成功")
        case .loseConnection:
            JYLog("云信--失去连接")
        case .netChanged:
            JYLog("云信--网络切换")
        @unknown default:
            JYLog("云信--位置状态")
        }
    }
    
    //登录失败,严重错误需要重新登录
    func onAutoLoginFailed(_ error: Error) {
        JYLog("云信--自动登录失败")
    }
    
    
    ///客户端注册 APNS，并在获取到 APNS Token 时将值传给 SDK
    private func registerPushService() {
        if #available(iOS 11.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
                if !granted {
                    dispatch_async_safe {
                        kWindow?.showCustomToast("请开启推送功能否则无法收到推送通知")
                    }
                }
            }
        }else {
            let settings = UIUserNotificationSettings(types: [.sound, .badge, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        // 注册push权限，用于显示本地推送
        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .badge, .alert], categories: nil))
        
    }
}
