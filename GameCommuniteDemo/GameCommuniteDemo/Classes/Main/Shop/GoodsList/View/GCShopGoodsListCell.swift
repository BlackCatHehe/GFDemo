//
//  GCShopGoodsListCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
class GCShopGoodsListCell: UICollectionViewCell, NibReusable{
    
        @IBOutlet weak var tagImgV: UIImageView!
        
        @IBOutlet weak var goodsImgV: UIImageView!
        
        @IBOutlet weak var titleLb: UILabel!
        
        @IBOutlet weak var moneyLb: UILabel!
        
        @IBOutlet weak var bgView: UIView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            bgView.backgroundColor = MetricGlobal.mainCellBgColor
            
            bgView.layer.cornerRadius = adaptW(5.0)
            bgView.layer.masksToBounds = true
            
            moneyLb.textColor = kRGB(r: 244, g: 234, b: 42)
        }

        func setModel() {
            
            layoutIfNeeded()
            goodsImgV.kf.setImage(with: URL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"))
            titleLb.text = "一台之人"
            moneyLb.text = "12.02ETC"
        }
        
        
    }
