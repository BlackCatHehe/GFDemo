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
    
    func setModel() {
        
        layoutIfNeeded()
        iconImgV.kf.setImage(with: URL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(55.0)/2, targetSize: self.iconImgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
        nameLb.text = "欧巴嘻嘻"
        contentLb.text = "ID 1284884"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
