//
//  GCAboutUsVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SwiftyJSON

class GCAboutUsVC: GCBaseVC {

    private var aboutUsV: GCAboutUsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "关于我们"
        
        initUI()
        requestAboutUS()
    }

}

extension GCAboutUsVC {
    private func initUI(){
        let aboutUsV = GCAboutUsView()
        self.aboutUsV = aboutUsV
        view.addSubview(aboutUsV)
        aboutUsV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
        }
    }
}

extension GCAboutUsVC {
    
    private func requestAboutUS() {
        GCNetTool.requestData(target: GCNetApi.aboutUs, controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            
            let json = JSON(result)
            let tel = json["service_phone"].string
            let time = json["service_time"].string
            let email = json["service_email"].string
            
            GCUserDefault.shareInstance.kefuTel = tel
            
            self.aboutUsV?.setModel(values: [
                "tel" : tel,
                "workTime" : time,
                "email" : email
            ])
            
        }) { (error) in
            JYLog(error)
        }
    }
    
}
