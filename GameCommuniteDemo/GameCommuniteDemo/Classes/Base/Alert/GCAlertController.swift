//
//  GCAlertController.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCAlertController: GCBaseVC {
    
    var clickChoose:((Int)->())?
    var clickBack: ClickClosure?

    @IBOutlet weak var fistItemBt: UIButton!
    @IBOutlet weak var secondItemBt: UIButton!
    @IBOutlet weak var thirdItemBt: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    var firstTitle: String = "拍照"
    var secondTitle: String = "从相册选择"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        bgView.backgroundColor = MetricGlobal.mainBgColor
        
        fistItemBt.setTitle(firstTitle, for: .normal)
        secondItemBt.setTitle(secondTitle, for: .normal)
        
    }

    @IBAction func clickItem(_ sender: UIButton) {
        dismissOrPop()
        
        clickChoose?(sender.tag-101)
    }
    
    @IBAction func clickBack(_ sender: UIButton) {
        clickBack?()
        
        dismissOrPop()
    }
}
