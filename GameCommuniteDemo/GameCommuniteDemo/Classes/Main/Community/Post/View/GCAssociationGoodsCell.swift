//
//  GCAssociationGoodsCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCAssociationGoodsCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
     
     @IBOutlet weak var goodsImgV: UIImageView!
     
     @IBOutlet weak var goodsNameLb: UILabel!
     
     @IBOutlet weak var subTitleLb: UILabel!
     
     @IBOutlet weak var moneyLb: UILabel!
    
    @IBOutlet weak var selectedBt: UIButton!
     
     override func awakeFromNib() {
         super.awakeFromNib()
         
         backgroundColor = MetricGlobal.mainBgColor
         bgView.backgroundColor = MetricGlobal.mainCellBgColor
         
     }
     
     func setModel() {
         
         layoutIfNeeded()
         goodsImgV.kf.setImage(with: URL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(4.0), targetSize: goodsImgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
         goodsNameLb.text = "发誓无敌套"
         subTitleLb.text = "【赠送强15法杖】+【赠送5颗噬魂珠】"
         moneyLb.text = "0.50ETC"
         
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
