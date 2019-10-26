//
//  GCMsgSectionHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCMsgSectionHeaderView: UITableViewHeaderFooterView, Reusable {

    var titleLb: UILabel?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func setModel() {
        self.titleLb?.text = "私信"
    }

}

extension GCMsgSectionHeaderView {
    
    private func initUI() {
        contentView.backgroundColor = MetricGlobal.mainBgColor
        backgroundColor = MetricGlobal.mainBgColor
        
        let bgView = UIView()
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(adaptW(0.5))
        }
        
        layoutIfNeeded()
        let path = UIBezierPath(roundedRect: bgView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: adaptW(5.0), height: adaptW(5.0)))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bgView.bounds
        shapeLayer.path = path.cgPath
        bgView.layer.addSublayer(shapeLayer)
        
        let tLb = UILabel()
        tLb.textColor = UIColor.white
        tLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        bgView.addSubview(tLb)
        tLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.centerY.equalToSuperview()
        }
        self.titleLb = tLb
    }
    
}

