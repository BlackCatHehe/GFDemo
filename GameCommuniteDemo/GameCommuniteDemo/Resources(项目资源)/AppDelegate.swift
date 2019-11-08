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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isLandscape = false//是否横屏
    var netMoniter: NetworkReachabilityManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initRootViewController()
        configSwiftToast()
        configIQKeyboard()
        configBugly()
        configNetMoniter()
        return true
    }
    //即将进入后台
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    //已经进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    //即将进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    //已经进入后台
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    //将要结束进程
    func applicationWillTerminate(_ application: UIApplication) {
        
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
    
    private func initRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = GCBaseTabbarController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
    private func configSwiftToast(){
        //设置弹窗style
        var style = ToastStyle()
        style.messageColor = .white
        style.messageFont = kFont(14)
        ToastManager.shared.style = style
        ToastManager.shared.duration = 1.0

    }
    
    private func configIQKeyboard(){
        //设置弹窗style
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        IQKeyboardManager.shared.disabledToolbarClasses = [ViewController.self]
    }
    
     private func configBugly(){
        
        Bugly.start(withAppId: MetricSDK.Bugly_appid)
    }
    
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
}
