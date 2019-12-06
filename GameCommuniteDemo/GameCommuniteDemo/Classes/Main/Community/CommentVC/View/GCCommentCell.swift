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
        
        self.selectionStyle = .none
        
        backgroundColor = MetricGlobal.mainCellBgColor
        contentView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.backgroundColor = kRGB(r: 31, g: 31, b: 55)
        contentLb.font = kFont(adaptW(12.0))
        contentLb.textColor = .white
        contentLb.numberOfLines = 0
    }

    func setModel(_ model: GCCommentReplyModel) {
        
        let userName = model.user?.name?.jys.add(MetricGlobal.mainBlue).base
        
        let beComName = model.parent?.name?.jys.add(MetricGlobal.mainBlue).base
        beComName?.append(":  ".jys.add(MetricGlobal.mainBlue).base)
        
        var result = NSMutableAttributedString()
        if let beCom = beComName {
            userName?.append("回复".jys.add(UIColor.white).base)
            
            userName?.append(beCom)
            
            if let r = userName {
                result = r
            }
        }else {
            userName?.append(":  ".jys.add(MetricGlobal.mainBlue).base)
            if let r = userName {
                result = r
            }
        }
        
        if let content = model.content {
            result.append(content.jys.add(UIColor.white).base)
        }
        
        
        contentLb.attributedText = result
    }

    
}
