//
//  GCNotiSettingVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCNotiSettingVC: GCBaseVC {

    
    @IBOutlet weak var gameSaleNotiSwitch: UISwitch!
    @IBOutlet weak var PUBGNotiSwitch: UISwitch!
    @IBOutlet weak var msgNotiSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "推送设置"
    }

}
