//
//  GCReceiveMsgCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCReceiveMsgCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet private var iconImageV: UIImageView!
    @IBOutlet private var nameLb: UILabel!
    @IBOutlet private var contentLb: UILabel!
    @IBOutlet private var timeLb: UILabel!
    @IBOutlet private var goodsImgV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(5.0)
        bgView.layer.masksToBounds = true
        
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.masksToBounds = true
        goodsImgV.layer.borderWidth = 1.0
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        
    }

    func setModel() {

        iconImageV.kfSetImage(
            url: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg",
            targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
            cornerRadius: adaptW(43.0)/2
        )
        nameLb.text = "欧巴嘻嘻"
        contentLb.text = "这个游戏道具看起来很棒呀！"
        timeLb.text = "今天 23:59"
        
        goodsImgV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(5.0), targetSize: CGSize(width: adaptW(70.0), height: adaptW(70.0)), roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
        goodsImgV.kfSetImage(
            url: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg",
            targetSize: CGSize(width: adaptW(70.0), height: adaptW(70.0)),
            cornerRadius: adaptW(5.0)
        )
        
    }
    
}

