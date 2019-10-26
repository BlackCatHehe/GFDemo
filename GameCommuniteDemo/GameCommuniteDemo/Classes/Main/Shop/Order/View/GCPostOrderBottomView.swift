//
//  GCPostOrderBottomView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPostOrderBottomView: UIView {
    
    private var moneyLb: UILabel!
    private var payBt: UIButton!
    
    var payClick: ClickClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        
        moneyLb.text = "总额:5000ETH=￥100"
        payBt.setTitle("立即付款", for: .normal)
        
    }
}

extension GCPostOrderBottomView {
    
    private func initUI() {
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(16.0))
        addSubview(nameLb)
        self.moneyLb = nameLb
        
        let moneyBt = UIButton()
        moneyBt.tintColor = .white
        moneyBt.backgroundColor = MetricGlobal.mainBlue
        moneyBt.setTitleColor(.white, for: .normal)
        moneyBt.titleLabel?.font = kFont(adaptW(15.0))
        moneyBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(33.0), bottom: 0, right: adaptW(33.0))
        moneyBt.layer.cornerRadius = adaptW(19.0)
        moneyBt.layer.masksToBounds = true
        moneyBt.addTarget(self, action: #selector(clickPay), for: .touchUpInside)
        addSubview(moneyBt)
        self.payBt = moneyBt
        
        nameLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
        }
        moneyBt.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.centerY.equalToSuperview()
            make.height.equalTo(adaptW(38.0))
        }
    }
    
    @objc private func clickPay() {
        payClick?()
    }
}
