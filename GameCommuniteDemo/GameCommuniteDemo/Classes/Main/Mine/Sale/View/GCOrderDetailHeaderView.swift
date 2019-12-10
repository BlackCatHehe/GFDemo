//
//  GCOrderDetailHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCOrderDetailHeaderView: UIView {

    private var titleLb: UILabel!
    private var subTitleLb: UILabel!
    private var statusImgV: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: GCOrderListModel) {
        //1:待付款，2:待发货，3:待签收，4:已完成,
        //图片是错的 需要对方切正确的图
        var statusStr: String? = nil
        var statusImgStr: String? = nil
        switch model.status {
        case 1:
            statusStr = "待付款"
            statusImgStr = "order_bagcar"
        case 2:
            statusStr = "待发货"
            statusImgStr = "order_car"
        case 3:
            statusStr = "待签收"
            statusImgStr = "order_chahao"
        case 4:
            statusStr = "已完成"
            statusImgStr = "order_duihao"
        default:
            break
        }
        titleLb.text = statusStr
        subTitleLb.text = statusStr
        statusImgV.image = UIImage(named: statusImgStr!)
    }
    
}

extension GCOrderDetailHeaderView {
    
    private func initUI(){
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        let label = UILabel()
        label.textColor = .white
        label.font = kFont(adaptW(15.0))
        self.addSubview(label)
        self.titleLb = label
        
        let subLabel = UILabel()
        subLabel.textColor = kRGB(r: 184, g: 181, b: 236)
        subLabel.font = kFont(adaptW(12.0))
        self.addSubview(subLabel)
        self.subTitleLb = subLabel
        
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        self.addSubview(imgV)
        self.statusImgV = imgV
        
        imgV.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(58.0))
            make.size.equalTo(CGSize(width: adaptW(52.0), height: adaptW(52.0)))
            make.top.equalTo(adaptW(8.0))
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(60.0))
            make.top.equalToSuperview().offset(adaptW(20.0))
            make.height.equalTo(adaptW(15.0))
            make.right.greaterThanOrEqualTo(statusImgV.snp.left).offset(10.0)
        }
        subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(label.snp.bottom).offset(adaptW(8.0))
            make.height.equalTo(adaptW(12.0))
            make.right.greaterThanOrEqualTo(statusImgV.snp.left).offset(10.0)
        }
        
        
        
    }
}
