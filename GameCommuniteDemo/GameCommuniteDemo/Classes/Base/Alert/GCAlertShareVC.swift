//
//  GCAlertShareVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCAlertShareVC: GCBaseVC {
    
    var clickJuBao: ClickClosure?
    var clickChoosePlatForm:((Int)->())?
    var clickBack: ClickClosure?

    @IBOutlet private weak var secondItemBt: UIButton!
    @IBOutlet private weak var thirdItemBt: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var shareVBgView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        bgView.backgroundColor = MetricGlobal.mainBgColor
        
        shareVBgView.backgroundColor = MetricGlobal.mainCellBgColor
    }
    

    @IBAction func clickJuBao(_ sender: UIButton) {
        dismissOrPop()
        
        clickJuBao?()
    }
    
    @IBAction func clickBack(_ sender: UIButton) {
        dismissOrPop()
        
        clickBack?()

    }

    @IBAction func tapPlamForm(_ sender: UITapGestureRecognizer) {
        dismissOrPop()
        
        if let index = sender.view?.tag {
            clickChoosePlatForm?(index-100)
        }
        
        
        
    }
    
}
