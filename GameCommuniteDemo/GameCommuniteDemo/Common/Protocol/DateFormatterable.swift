//
//  DateFormatterable.swift
//  SwiftBaseDemo
//
//  Created by APP on 2019/9/2.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

protocol DateFormatterable {
   
}

extension DateFormatterable where Self == String {
    func format(use format: String) -> String? {
        if let time = Int(self) {
            let dataFormatter = MXTDateFormatter.dateFormatter
            dataFormatter.dateFormat = format
            let dateInterval = TimeInterval(time)
            let date = Date(timeIntervalSince1970: dateInterval)
            let timeStr = dataFormatter.string(from: date)
            return timeStr
        }else {
            assert(true, "字符串不是时间戳格式")
            return nil
        }
    }
}

extension DateFormatterable where Self == Int {
    
    func format(use format: String) -> String {
        let dataFormatter = MXTDateFormatter.dateFormatter
        dataFormatter.dateFormat = format
        let dateInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: dateInterval)
        let timeStr = dataFormatter.string(from: date)
        return timeStr
    }
}

extension String: DateFormatterable {}
extension Int: DateFormatterable {}

//extension DateFormatterable {
//
//    func format(timeStamp: Int, use format: String) -> String{
//        let dataFormatter = MXTDateFormatter.dateFormatter
//        dataFormatter.dateFormat = format
//        let dateInterval = TimeInterval(timeStamp)
//
//        let date = Date(timeIntervalSince1970: dateInterval)
//
//        //        let nowInterval = Date().timeIntervalSince1970
//
//        //        let cha = nowInterval - dateInterval
//
//        let timeStr = dataFormatter.string(from: date)
//        //        //判断时间
//        //        if cha/3600 < 1{
//        //            //距现在小于1分钟
//        //            if cha/60 < 1{
//        //                if cha < 10{
//        //                    timeStr = "刚刚"
//        //                }else{
//        //                    timeStr = "\(Int(round(cha)))秒前"
//        //                }
//        //            }else{//大于1分钟小于1小时
//        //                timeStr = "\(Int(round(cha/60)))分前"
//        //            }
//        //        }else if cha/3600 >= 1 && cha/3600 < 24{//大于1天小于4天（最多显示3天前）
//        //            timeStr = "\(Int(cha/3600))小时前"
//        //        }else if cha/3600/24 >= 1 && cha/3600/24 < 2{//1天前
//        //            timeStr = "前天"
//        //        }else if cha/3600/24 >= 2 && cha/3600/24 < 30{
//        //            timeStr = "\(Int(cha/3600/24))天前"
//        //        }else if cha/3600/24/30 >= 1 && cha/3600/24/30 < 12{
//        //            timeStr = "\(Int(cha/3600/24/30))月前"
//        //        }else{
//        //            timeStr = dataFormatter.string(from: date)
//        //        }
//
//        return timeStr
//    }
//}
