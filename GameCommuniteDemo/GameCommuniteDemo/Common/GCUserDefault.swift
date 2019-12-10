//
//  GCUserDefault.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/4.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper
import KeychainAccess
class GCUserDefault {
    
    static let shareInstance = GCUserDefault()
    
//    var userInfo: UserModel? {
//        set{
//            if let newModel = newValue {
//                if let userDic = Mapper<UserModel>().toJSON(newModel) as? [String: String] {
//                    UserDefaults.standard.setValue(userDic, forKey: "GCUserInfo")
//
//                }
//            }
//
//        }
//        get{
//            if let userDic = UserDefaults.standard.value(forKey: "GCUserInfo") as? [String: String] {
//                let model = Mapper<UserModel>().map(JSON: userDic)
//                return model
//            }else {
//                return nil
//            }
//        }
//    }
    
    var userInfo: UserModel? {
        set {
            if let user = newValue {
                let keychain = Keychain(service: "com.qiqi.gamecommunite")
                if let json = user.toJSONString() {
                    if let userData = json.data(using: .utf8) {
                        do{
                            try keychain.set(userData, key: "GCUserInfo")
                        }
                        catch let error {
                            JYLog("keychina存储出错：\(error.localizedDescription)")
                        }
                    }else {
                        JYLog("无法转换为Data")
                    }
                }else {
                    JYLog("无法转换为Json")
                }
            }else {
                JYLog("model为nil")
            }
        }
        
        get {
            let keychain = Keychain(service: "com.qiqi.gamecommunite")
            if let data = try? keychain.getData("GCUserInfo") {
                if let json = String(data: data, encoding: .utf8) {
                    if let user = Mapper<UserModel>().map(JSONString: json) {
                        return user
                    }else {
                        JYLog("无法转换model成功")
                        return nil
                    }
                }else {
                    JYLog("无法转换json成功")
                    return nil
                }
            }else {
                JYLog("无法取到keychain数据")
                return nil
            }
        }
    }
    
    var kefuTel: String? {
        get {
            return UserDefaults.standard.value(forKey: "GCkefuTel") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "GCkefuTel")
        }
    }
    
    func resignLogin() {
        //清除用户信息
        let keychainUser = Keychain(service: "com.qiqi.gamecommunite")
        do {
            try keychainUser.remove("GCUserInfo")
        } catch let error {
            JYLog("UsrError: \(error)")
        }
        
        //清除token
        let keychainToken = Keychain(service: "access_token")
        do {
            try keychainToken.remove("header")
        } catch let error {
            JYLog("TokenError: \(error)")
        }
       }
    
}
