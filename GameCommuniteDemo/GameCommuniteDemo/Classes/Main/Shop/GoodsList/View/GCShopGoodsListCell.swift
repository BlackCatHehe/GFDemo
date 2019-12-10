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
    
    func setModel(model: GCGoodsModel) {
        
        goodsImgV.kf.setImage(with: URL(string:model.cover!))
        titleLb.text = model.name
        moneyLb.text = model.price
        
        tagImgV.isHidden = !(model.isBestSeller ?? false)
    }
    
    
}
