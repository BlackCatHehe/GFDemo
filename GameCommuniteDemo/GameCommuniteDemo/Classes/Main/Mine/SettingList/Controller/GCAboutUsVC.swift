//
//  GCAboutUsVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCAboutUsVC: GCBaseVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "关于我们"
        initUI()
        
    }

}

extension GCAboutUsVC {
    private func initUI(){
        let aboutUsV = GCAboutUsView()
        aboutUsV.setModel()
        view.addSubview(aboutUsV)
        aboutUsV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
        }
    }
}
