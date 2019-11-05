//
//  GCMyEstateHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCMyEstateHeaderView: UIView {

    var tapRecharge: ClickClosure?
    
    private var tLabel: UILabel!
    private var moneyLb: UILabel!
    private var payButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        moneyLb.text = "85645.00ETH"
        
    }
}
extension GCMyEstateHeaderView {
    
    private func initUI() {
        
        let bgView = UIView()
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(5.0)
        bgView.layer.masksToBounds = true
        addSubview(bgView)
        
        let topLb = UILabel()
        topLb.text = "余额(¥)"
        topLb.textColor = UIColor.white
        topLb.textAlignment = .center
        topLb.font = kFont(adaptW(14.0))
        bgView.addSubview(topLb)
        self.tLabel = topLb
        
        let cLb = UILabel()
        cLb.textColor = UIColor.white
        cLb.textAlignment = .center
        cLb.font = kFont(adaptW(25.0), MetricGlobal.mainMediumFamily)
        bgView.addSubview(cLb)
        self.moneyLb = cLb
        
        let bBt = UIButton()
        bBt.setTitle("充值", for: .normal)
        bBt.setTitleColor(.white, for: .normal)
        bBt.layer.cornerRadius = adaptW(15.0)
        bBt.layer.masksToBounds = true
        bBt.backgroundColor = MetricGlobal.mainBlue
        bBt.addTarget(self, action: #selector(clickRecharge), for: .touchUpInside)
        bgView.addSubview(bBt)
        self.payButton = bBt
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(12.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.bottom.equalToSuperview().offset(-adaptW(15.0))
        }
        topLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(20.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(15.0))
        }
        cLb.snp.makeConstraints { (make) in
            make.top.equalTo(topLb.snp.bottom).offset(adaptW(15.0))
            make.left.right.equalTo(topLb)
            make.height.equalTo(adaptW(20.0))
        }
        bBt.snp.makeConstraints { (make) in
            make.top.equalTo(cLb.snp.bottom).offset(adaptW(27.0))
            make.bottom.equalToSuperview().offset(-adaptW(20.0))
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(90.0), height: adaptW(30.0)))
        }
        
    }
    
    @objc private func clickRecharge() {
        tapRecharge?()
    }
}
