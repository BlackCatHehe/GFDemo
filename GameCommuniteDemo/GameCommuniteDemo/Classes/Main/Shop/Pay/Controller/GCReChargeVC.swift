//
//  GCReChargeVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCReChargeVC: GCBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "充值"
        
        initUI()
        
        topMoneyV.money = "84545.00ETH"
    }
    
    private lazy var topMoneyV: GCRechargeTopView = {
        let tView = GCRechargeTopView()
        return tView
    }()
    
    private lazy var rechargeView: GCChooseRechargeView = {
        let rView = GCChooseRechargeView()
        
        return rView
    }()
    private lazy var rechargeWayView: GCChoosePayWayView = {
        let rwView = GCChoosePayWayView()
        rwView.setModel()
        return rwView
    }()
    private lazy var payBt: UIButton = {
        let button = UIButton()
        button.setTitle("立即付款", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MetricGlobal.mainBlue
        button.layer.cornerRadius = adaptW(22.0)
        button.layer.masksToBounds = true
        return button
    }()
}

extension GCReChargeVC {
    
    private func initUI(){
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(topMoneyV)
        topMoneyV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(18.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(80.0))
            make.width.equalToSuperview()
        }
        
        scrollView.addSubview(rechargeView)
        rechargeView.snp.makeConstraints { (make) in
            make.top.equalTo(topMoneyV.snp.bottom).offset(adaptW(12.0))
            make.left.right.equalToSuperview()
        }
        rechargeView.setModel()
        
        scrollView.addSubview(rechargeWayView)
        rechargeWayView.snp.makeConstraints { (make) in
            make.top.equalTo(rechargeView.snp.bottom).offset(adaptW(12.0))
            make.left.right.equalToSuperview()
        }
        
        
        scrollView.addSubview(payBt)
        payBt.addTarget(self, action: #selector(clickpay), for: .touchUpInside)
        payBt.snp.makeConstraints { (make) in
            make.top.equalTo(rechargeWayView.snp.bottom).offset(adaptW(60.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(44.0))
            make.bottom.equalToSuperview().offset(-kBottomH - adaptW(20.0))
        }
    }
    
    @objc private func clickpay() {
        switch rechargeWayView.selectedIndex {
        case 1:
            JYLog("weixin")
        case 2:
            JYLog("zhifubao")
        default:
            break
        }
    }
}

//MARK: ------------request------------
extension GCReChargeVC {
    ///支付宝支付
    private func requestZFB(){
        
        
        
    }
}
