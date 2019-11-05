//
//  GCChatListCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
class GCChatListCell: UITableViewCell, NibReusable {

    
    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var contentLb: UILabel!
    
    @IBOutlet weak var timeLb: UILabel!
    
    @IBOutlet weak var newMsgLb: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newMsgLb.layer.cornerRadius = adaptW(15.0)/2
        newMsgLb.layer.masksToBounds = true
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
    }

    func setModel() {
        
        layoutIfNeeded()

        iconImgV.kfSetImage(
            url: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
            targetSize: self.iconImgV.bounds.size,
            cornerRadius: adaptW(55.0)/2
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
