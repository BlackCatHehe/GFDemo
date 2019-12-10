//
//  MetricSDK.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/31.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

///项目常量
struct MetricSDK {
    //Bugly
    static let Bugly_appid = "dfdc2588d2"
    
    //友盟
    static let YM_appkey = "5de89de6570df3b6b10002df"
    
    //qq
    static let QQ_appkey = "aebbb019dc61739c9153cd688f854d05"
    static let QQ_appid = "101831505"
    
    //云信
    static let WYYX_appkey = "20388728ad8e060ef73246df54bd6bab"
    
    static let WYYX_DataDir = "GameCommunity" //云信数据保存沙盒位置
    
    #if DEBUG
    static let WYYX_apnsCername = "apnsSanBox"
    #else
    static let WYYX_apnsCername = "apns"
    #endif
}
