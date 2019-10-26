//
//  GCAlertPayVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCAlertPayVC: GCBaseVC {

    var paySelectClick: ((Int)->())?
    var clickPay: ClickClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    private lazy var alertV: GCAlertPayView = {
        let alertV = GCAlertPayView()
        return alertV
    }()
}

extension GCAlertPayVC {
    
    private func initUI(){
        
        view.addSubview(alertV)
        alertV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(adaptW(348.0))
        }
        alertV.paySelectClick = paySelectClick
        
        alertV.clickPay = {[weak self] in
            self?.dismissOrPop()
            self?.clickPay?()
        }
    }
}
