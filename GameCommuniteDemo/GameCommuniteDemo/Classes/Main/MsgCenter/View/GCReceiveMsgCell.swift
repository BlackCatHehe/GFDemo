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
        selectionStyle = .none
        contentView.backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(5.0)
        bgView.layer.masksToBounds = true
        
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.masksToBounds = true
        goodsImgV.layer.borderWidth = 1.0
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        
    }

    func setModel(_ model: GCMsgZanModel) {
        if let img = model.sender?.avatar {
            iconImageV.kfSetImage(
                url: img,
                targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
                cornerRadius: adaptW(43.0)/2
            )
        }
        
        nameLb.text = model.sender?.name
        contentLb.text = model.content
        timeLb.text = model.updatedAt
        
        if let gImg = model.target?.cover {
            goodsImgV.kfSetImage(
                url: gImg,
                targetSize: CGSize(width: adaptW(70.0), height: adaptW(70.0)),
                cornerRadius: adaptW(5.0)
            )
        }
    }
    
}

