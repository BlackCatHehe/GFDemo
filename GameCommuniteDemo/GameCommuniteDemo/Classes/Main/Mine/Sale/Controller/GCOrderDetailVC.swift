//
//  GCOrderDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCOrderDetailVC: GCBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "订单详情"
        initUI()
    }
    
    private lazy var headerV: GCOrderDetailHeaderView = {
        let view = GCOrderDetailHeaderView(frame: .zero)
        view.setModel()
        return view
    }()
    
    private lazy var orderV: GCGoodsDetailCellView = {
        let view = GCGoodsDetailCellView(frame: .zero)
        view.layer.cornerRadius = adaptW(5.0)
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var bDetailLb: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = kFont(12)
        label.numberOfLines = 0
        label.backgroundColor = MetricGlobal.mainCellBgColor
        return label
    }()
    
}

extension GCOrderDetailVC {
    
    private func initUI(){
        view.addSubview(headerV)
        headerV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(68.0))
        }
        
        view.addSubview(orderV)
        orderV.setModel()
        orderV.snp.makeConstraints { (make) in
            make.top.equalTo(headerV.snp.bottom).offset(adaptW(28.0))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(adaptW(117.0))
        }
        
        view.addSubview(bDetailLb)
        bDetailLb.snp.makeConstraints { (make) in
            make.top.equalTo(orderV.snp.bottom).offset(adaptW(14.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        
        bDetailLb.attributedText = "订单编号：1234567890002121\n下单时间：2019-04-15 12:30:25\n付款时间：2019-04-15\n订单备注: 帮我关下灯谢谢".jys.add(CGFloat(10.0)).base
    }
}
