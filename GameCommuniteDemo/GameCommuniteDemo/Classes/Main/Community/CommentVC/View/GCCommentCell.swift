//
//  GCCommentCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCCommentCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var contentLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = kRGB(r: 31, g: 31, b: 55)
        contentLb.font = kFont(adaptW(12.0))
        contentLb.textColor = .white
    }

    func setModel() {
        var name = "一生不羁:".jys.add(MetricGlobal.mainBlue).base
        name.append("速来，装备齐全！".jys.add(UIColor.white).base)
        
        contentLb.attributedText = name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
