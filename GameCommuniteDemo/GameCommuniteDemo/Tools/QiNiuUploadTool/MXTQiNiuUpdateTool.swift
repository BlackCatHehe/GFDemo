////
////  MXTQiNiuUpdateTool.swift
////  mingxint
////
////  Created by payTokens on 2019/4/20.
////  Copyright © 2019 放. All rights reserved.
////
//
//import Foundation
//import Qiniu
//import AFNetworking
//import CommonCrypto
//
//fileprivate struct Metric {
//    //static let postUrl = "pq57cg26e.bkt.clouddn.com"//存储外链
//    static let bucket =  "mxt"  //存储空间名字
//    static let accessKey = "CwoTNa8K7695eiFmYDxp7bqikJ3aC-fWTeB3xTXV"
//    static let secretKey = "qi_FlGI-XW37jfXa4iG49l4GRGIHiCoot46vRpNk"
//}
//
//class MXTQiNiuUpdateTool{
//
//    static var filePath = String()
//
//    static let shareInstance = MXTQiNiuUpdateTool()
//
//    var Index : Int = 0
//
//    init() {
//
//    }
//
//    func token() -> String {
//        return self.createQiniuToken(fileName: Metric.bucket)
//    }
//
//    func hmacsha1WithString(str: String, secretKey: String) -> NSData {
//
//        let cKey  = secretKey.cString(using: String.Encoding.ascii)
//        let cData = str.cString(using: String.Encoding.ascii)
//
//        var result = [CUnsignedChar](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
//        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
//        let hmacData: NSData = NSData(bytes: result, length: (Int(CC_SHA1_DIGEST_LENGTH)))
//        return hmacData
//    }
//
//    func createQiniuToken(fileName: String) -> String {
//
//        let oneHourLater = NSDate().timeIntervalSince1970 + 3600
//        let putPolicy: NSDictionary = ["scope": Metric.bucket, "deadline": NSNumber(value: UInt64(oneHourLater))]
//        let encodedPutPolicy = QNUrlSafeBase64.encode(getJSONStringFromDictionary(dictionary: putPolicy))
//        let sign = self.hmacsha1WithString(str: encodedPutPolicy!, secretKey: Metric.secretKey)
//        let encodedSign = QNUrlSafeBase64.encode(sign as Data?)
//
//        return Metric.accessKey + ":" + encodedSign! + ":" + encodedPutPolicy!
//    }
//
//    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
//        if (!JSONSerialization.isValidJSONObject(dictionary)) {
//            print("无法解析出JSONString")
//            return ""
//        }
//        let data : NSData = try! JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData
//        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
//        return JSONString! as String
//
//    }
//
//    func uploadImageData(image:Data , result: @escaping (_ progress: Float? , _ imageKey:String? ) -> ()) {
//
//
//        let token = self.token()
//
//        let opt = QNUploadOption(mime: nil, progressHandler: {(key, progres) in
//
//            result(progres, nil)
//        }, params: nil, checkCrc: true, cancellationSignal: nil)
//
//        var cutdownData : Data!
//        if (image.count < 9999) {
//            cutdownData = image
//        } else if (image.count < 99999) {
//            let nowImage = UIImage.init(data: image)!
//            cutdownData = nowImage.jpegData(compressionQuality: 0.6)
//        } else {
//            let nowImage = UIImage.init(data: image)!
//            cutdownData = nowImage.jpegData(compressionQuality: 0.3)
//        }
//
//
//
//        if let manager = QNUploadManager() {
//            manager.put(cutdownData, key: nil, token: token, complete: { (Info, key, resp) in
//                if (Info?.isConnectionBroken)! {
//                    print("网络连接错误")
//                    return
//                }
//
//                if let imageKey = resp?["key"] as? String {
//
//                    result(nil, imageKey)
//                }
//
//            }, option: opt)
//        }
//
//    }
//
//    func uploadVideoData(video:Data , result: @escaping (_ progress: Float? , _ imageKey:String? ) -> ()) {
//
//
//        let token = self.token()
//
//        let opt = QNUploadOption(mime: nil, progressHandler: {(key, progres) in
//
//            result(progres, nil)
//        }, params: nil, checkCrc: true, cancellationSignal: nil)
//
//
//
//        if let manager = QNUploadManager() {
//            manager.put(video, key: nil, token: token, complete: { (Info, key, resp) in
//
//                if (Info?.isConnectionBroken)! {
//                    print("网络连接错误")
//                    return
//                }
//
//                if let imageKey = resp?["key"] as? String {
//
//                    result(nil, imageKey)
//                }
//
//            }, option: opt)
//        }
//
//    }
//
//    func upVideoDatas(videos:[Data] , result: @escaping (_ progress: Float? , _ imageKey:String? ) -> (),allTasksCompletion:@escaping () -> () ) {
//
//        if (Index < videos.count) {
//
//            uploadVideoData(video: videos[Index], result: { (progres, imageKey) in
//
//                if (imageKey != nil) {
//
//                    result(progres, imageKey)
//
//                    self.Index += 1
//
//                    self.upVideoDatas(videos: videos, result: result, allTasksCompletion: allTasksCompletion)
//                }
//            })
//        }else{
//            allTasksCompletion()
//            Index = 0
//        }
//
//    }
//
//
//    func upImageDatas(images:[Data] , result: @escaping (_ progress: Float? , _ imageKey:String? ) -> (),allTasksCompletion:@escaping () -> () ) {
//
//        if (Index < images.count) {
//
//            uploadImageData(image: images[Index], result: { (progres, imageKey) in
//
//                if (imageKey != nil) {
//
//                    result(progres, imageKey)
//
//                    self.Index += 1
//
//                    self.upImageDatas(images: images, result: result, allTasksCompletion: allTasksCompletion)
//                }
//            })
//        }else{
//            allTasksCompletion()
//            Index = 0
//        }
//
//    }
//
//}
