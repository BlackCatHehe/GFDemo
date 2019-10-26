//
//  GCUsualSettingVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCUsualSettingVC: GCBaseVC {

    
    @IBOutlet weak var phoneDataSwitch: UIView!
    
    @IBOutlet weak var catcheLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "通用设置"
        
    }

    @IBAction func clickClearCache(_ sender: UITapGestureRecognizer) {
        
    }
}
