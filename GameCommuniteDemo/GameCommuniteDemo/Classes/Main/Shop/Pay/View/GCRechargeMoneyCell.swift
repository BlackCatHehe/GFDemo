//
//  GCRechargeMoneyCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCRechargeMoneyCell: UIView {

    var clickChoose: ((Int)->())?
    
    var isChoosed: Bool = false {
        didSet {
            self.backgroundColor = isChoosed ? kRGBA(r: 46, g: 37, b: 219, a: 0.5) : nil
        }
    }
    
    private var rmbLabel: UILabel!
    private var moneyLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        rmbLabel.text = "¥60.00"
        moneyLb.text = "6000ETH"
    }
}

extension GCRechargeMoneyCell {
    
    private func initUI(){
        
        self.layer.cornerRadius = adaptW(10.0)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = kRGB(r: 83, g: 76, b: 219).cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapChoose(_:)))
        addGestureRecognizer(tap)
        
        let rmbLb = UILabel()
        rmbLb.font = kFont(adaptW(17.0), MetricGlobal.mainMediumFamily)
        rmbLb.textColor = .white
        addSubview(rmbLb)
        self.rmbLabel = rmbLb
        
        let vLable = UILabel()
        vLable.font = kFont(adaptW(14.0))
        vLable.textColor = kRGB(r: 209, g: 208, b: 231)
        addSubview(vLable)
        self.moneyLb = vLable
        
        rmbLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(16.0))
            make.centerX.equalToSuperview()
            make.height.equalTo(adaptW(15.0))
        }
        vLable.snp.makeConstraints { (make) in
            make.top.equalTo(rmbLb.snp.bottom).offset(adaptW(10.0))
            make.centerX.equalToSuperview()
            make.height.equalTo(adaptW(12.0))
        }
    }
    
    @objc private func tapChoose(_ sender: UITapGestureRecognizer) {
        clickChoose?(self.tag - 100)
    }
}
