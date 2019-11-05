//
//  GCRechargeTopView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCRechargeTopView: UIView {
    
    var money: String? {
        didSet {
            moneyLb.text = money
        }
    }
    
    private var moneyLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension GCRechargeTopView {
    
    private func initUI(){
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        let label = UILabel()
        label.textColor = .white
        label.text = "当前余额(¥)"
        label.font = kFont(adaptW(13.0))
        addSubview(label)
        
        let moneyLb = UILabel()
        moneyLb.textColor = .white
        moneyLb.font = kFont(adaptW(22.0), MetricGlobal.mainMediumFamily)
        addSubview(moneyLb)
        self.moneyLb = moneyLb
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(17.0))
            make.centerX.equalToSuperview()
            make.height.equalTo(adaptW(13.0))
        }
        moneyLb.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(adaptW(17.0))
            make.centerX.equalToSuperview()
            make.height.equalTo(adaptW(16.5))
        }
    }
    
}
