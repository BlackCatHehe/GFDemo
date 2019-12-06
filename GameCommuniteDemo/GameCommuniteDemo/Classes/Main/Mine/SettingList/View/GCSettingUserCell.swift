//
//  GCSettingUserCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCSettingUserCell: UITableViewCell, NibReusable {

    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var contentLb: UILabel!

    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
    }
    
    func setModel(_ model: UserModel) {
        if let img = model.avatar {
            iconImgV.kfSetImage(
                url: img,
                targetSize: CGSize(width: adaptW(55.0), height: adaptW(55.0)),
                cornerRadius: adaptW(55.0)/2
            )
        }
        nameLb.text = model.name
        contentLb.text = "ID \(model.id!)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
