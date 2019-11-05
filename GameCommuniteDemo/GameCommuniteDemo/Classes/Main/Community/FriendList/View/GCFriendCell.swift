//
//  GCFriendCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
class GCFriendCell: UITableViewCell, NibReusable {

    @IBOutlet var iconImgV: UIImageView!
    
    @IBOutlet var nameLb: UILabel!
    
    @IBOutlet var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
    }

    func setModel() {
        
        layoutIfNeeded()
        
        iconImgV.kfSetImage(
            url: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
            targetSize: self.iconImgV.bounds.size,
            cornerRadius: adaptW(43.0)/2
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
