//
//  GCPreferentialCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCPreferentialCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var timeBt: UIButton!
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var contentLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.backgroundColor = MetricGlobal.mainBgColor
        
        timeBt.layer.cornerRadius = adaptW(10.0)
        timeBt.layer.masksToBounds = true
        timeBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(10.0), bottom: 0, right: adaptW(10.0))
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(10.0)
        bgView.layer.masksToBounds = true
        
    }
    
    func setModel(_ model: GCCheapActivityModel) {
        timeBt.setTitle(model.target?.updatedAt, for: .normal)
        titleLb.text = model.target?.title
        contentLb.text = model.target?.content
        
        layoutIfNeeded()
        if let img = model.target?.cover {
            imageV.kfSetImage(
                url: img,
                targetSize: imageV.bounds.size,
                cornerRadius: adaptW(10.0)
            )
        }
   
    }
}
