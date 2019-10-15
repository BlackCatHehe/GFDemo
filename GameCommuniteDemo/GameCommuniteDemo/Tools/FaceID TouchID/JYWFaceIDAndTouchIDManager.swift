//
//  JYWFaceIDAndTouchIDManager.swift
//  TheWorld
//
//  Created by payTokens on 2019/2/25.
//  Copyright © 2019年 payTokens. All rights reserved.
//

// 使用请在info.plist文件中添加 NSFaceIDUsageDescription

import Foundation
import LocalAuthentication

class JYWFaceIDAndTouchIDManager{
    
    static let shareInstance = JYWFaceIDAndTouchIDManager()
    
    var successBlock : ClickClosure?
    var failBlock : ClickClosure?
    
    
    /// 面部识别
    ///
    /// - Parameters:
    ///   - success: 成功闭包
    ///   - fail: 验证失败闭包
    func jyw_validate(success: @escaping ClickClosure, fail: @escaping ClickClosure) {
        
        // 1.kLAPolicyDeviceOwnerAuthenticationWithBiometrics: 单纯指纹或faceid
        // 2.kLAPolicyDeviceOwnerAuthentication : 带密码
//        let fingerPrint = UserDefaults.standard.value(forKey: "faceID")
//        if fingerPrint != nil && fingerPrint as! Bool{
            let laContext = LAContext()
            if #available(iOS 10.0, *) {
                laContext.localizedCancelTitle = "hehe"
            }
        
            
            var error : NSError?
            let isSupport = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
            
            if isSupport{
                    
               kWindow?.makeToast("面部识别可用")
                
                laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请把脸贴上来") { (pass, error) in
                    if pass{
                        dispatch_async_safe {
                            success()
                        }
                        
                    }else{
                        
                        dispatch_async_safe {
                            kWindow?.makeToast("\(String(describing: error))")
                            fail()
                        }
                        
                    }
                }
            }
        }
//    }
}
