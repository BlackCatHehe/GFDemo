//
//  GCGoodsDetailCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

class GCGoodsDetailCell: UITableViewCell, NibReusable {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = MetricGlobal.mainCellBgColor

    }

    func setModel(_ model: GCGoodsModel) {
        let smodel = model.attributes?.map{$0["value"] as! String}
        guard let attrs = smodel, attrs.isEmpty == false else {return}
        
        
        var bgViews: [UIView] = []
        for attr in attrs {
            let strs = attr.split(separator: ":")
            guard strs.count == 2 else {
                showCustomToast("商品属性有误")
                return
            }
            
            let bgView = UIView()
            contentView.addSubview(bgView)
            bgViews.append(bgView)

            let titleLb = UILabel()
            titleLb.textColor = MetricGlobal.mainGray
            titleLb.font = kFont(adaptW(14.0))
            titleLb.backgroundColor = MetricGlobal.mainCellBgColor
            titleLb.text = String(strs[0])
            titleLb.textAlignment = .left
            bgView.addSubview(titleLb)
            
            let valueLb = UILabel()
            valueLb.textColor = .white
            valueLb.font = kFont(adaptW(14.0))
            valueLb.backgroundColor = MetricGlobal.mainCellBgColor
            valueLb.numberOfLines = 0
            valueLb.text = String(strs[1])
            bgView.addSubview(valueLb)
            
            titleLb.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(15.0))
                make.top.equalToSuperview().offset(adaptW(5.0))
                make.width.equalTo(adaptW(80.0))
            }
            valueLb.snp.makeConstraints { (make) in
                make.left.equalTo(titleLb.snp.right).offset(adaptW(10.0))
                make.right.equalToSuperview().offset(-adaptW(15.0))
                make.top.equalToSuperview().offset(adaptW(5.0))
                make.width.equalTo(adaptW(80.0))
                make.bottom.equalToSuperview().offset(-adaptW(5.0))
            }
        }
        let _ = bgViews.reduce(bgViews[0]) { (old, new) -> UIView in
            new.snp.makeConstraints { (make) in
                if bgViews.firstIndex(of: new) == 0 {
                    make.top.equalToSuperview()
                }else {
                    make.top.equalTo(old.snp.bottom)
                }
                make.left.right.equalToSuperview()
                
                if bgViews.lastIndex(of: new) == bgViews.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            return new
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
