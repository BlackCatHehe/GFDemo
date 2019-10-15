//
//  String+MD5.swift
//  NationalFace
//
//  Created by APP on 2019/7/29.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
public extension String {
    
    ///md5加密
    var md5String: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    
    ///是否为空，包含全是空格
    func isEmpty() -> Bool {
        
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        let resultStr = self.trimmingCharacters(in: whitespace)
        if self == "" || resultStr == "" {
            return true
        }
        return false
    }
}
