//
//  GCUsualSettingVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
class GCUsualSettingVC: GCBaseVC {

    
    @IBOutlet weak var phoneDataSwitch: UIView!
    
    @IBOutlet weak var catcheLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "通用设置"
        
        let cache = KingfisherManager.shared.cache
        //计算图片缓存
        cache.calculateDiskCacheSize { (size) in
            let imgMb = Double(size)/1024.00/1024.00
            self.catcheLb.text = String(format: "%.2fM", imgMb)
        }
        
    }

    @IBAction func clickClearCache(_ sender: UITapGestureRecognizer) {
        
        
        
    }
}
