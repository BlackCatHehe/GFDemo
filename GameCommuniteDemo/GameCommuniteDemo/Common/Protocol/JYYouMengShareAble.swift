//
//  JYYouMengShareAble.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/4.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

protocol JYYouMengShareAble: GCBaseVC {
    
}

extension JYYouMengShareAble {

    ///分享链接
    func share(title: String, description: String, thrumb imageUrl: String, url: String, to platform: JYSharePlatForm) {
        
        guard UMSocialManager.default()?.isInstall(platform.youmengType) == true else {
            showToast("您没有安装该应用")
            return
        }
        
        let messageObj = UMSocialMessageObject()
        
        let webPageObj = UMShareWebpageObject.shareObject(withTitle: title, descr: description, thumImage: imageUrl)
        webPageObj?.webpageUrl = url
        messageObj.shareObject = webPageObj
        
        UMSocialManager.default()?.share(to: platform.youmengType, messageObject: messageObj, currentViewController: self, completion: {result, error in
            
            if let err = error {
                print("友盟分享出错: \(err)")
            }else {
                self.showToast("分享成功!")
                print("友盟分享结果: \(String(describing: result))")
            }
            
        })
    }
    
}


enum JYSharePlatForm {
    case QQ
    case weixinFriend
    case weixinFriendCycle
    case xlWeibo
}

extension JYSharePlatForm {
    
    var youmengType: UMSocialPlatformType{
        switch self {
        case .QQ:
            return .QQ
        case .weixinFriend:
            return .wechatSession
        case .weixinFriendCycle:
            return .wechatFavorite
        case .xlWeibo:
            return .sina
        }
    }
}
