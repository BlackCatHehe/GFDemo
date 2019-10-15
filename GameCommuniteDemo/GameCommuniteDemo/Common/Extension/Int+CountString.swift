//
//  Int+CountString.swift
//  SwiftBaseDemo
//
//  Created by APP on 2019/9/2.
//  Copyright © 2019 kuroneko. All rights reserved.
//


extension Int {
    
    // MARK:- 数字转字符串大法
    func countString(count: Int64) -> String{
        
        var countStr = ""
        if count < 10000{
            countStr = String(format: "%i", count)
        }else if count >= 10000 && count < 100000000{
            countStr = String(format: "%.1f万", Double(count) / 10000.0)
        }else{
            countStr = String(format: "%.1f亿", Double(count) / 100000000.0)
        }
        return countStr
    }
}

