////
////  MXTYYTextEmotionParser.swift
////  mingxint
////
////  Created by payTokens on 2019/4/16.
////  Copyright © 2019 放. All rights reserved.
////
//
//import UIKit
//import YYText
//import YYImage
//
//class MXTYYTextEmotionParser: NSObject {
//
//    static let defaultParser: YYTextSimpleEmoticonParser = {
//        let instance = YYTextSimpleEmoticonParser()
//
//        var emojis = [String : UIImage]()
//        let path = Bundle.main.path(forResource: "emotionToText", ofType: "plist")
//        let emojisDic: [String : String] = NSDictionary(contentsOfFile: path!)! as! [String : String]
//
//        let bundle = Bundle(path: Bundle.main.path(forResource: "Emotion", ofType: "bundle") ?? "")
//
//
//        //将表情设置到解析器
//        for i in 1...emojisDic.count {
//            let name = "\(i)@2x"
//
//            let path = bundle?.path(forScaledResource: name, ofType: "png")
//            let data = NSData(contentsOfFile: path ?? "") as Data?
//            var image: YYImage? = nil
//            if let data = data {
//                image = YYImage(data: data, scale: 2)
//            }
//            image?.preloadAllAnimatedImageFrames = true
//
//            if image != nil{
//                let index = String(i)
//                let emojiName = emojisDic[index]
//                emojis[emojiName!] = image!
//            }
//        }
//
//        instance.emoticonMapper = emojis
//
//        return instance
//    }()
//
//}
