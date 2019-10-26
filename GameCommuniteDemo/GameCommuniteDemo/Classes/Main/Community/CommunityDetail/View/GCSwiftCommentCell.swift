//
//  GCSwiftCommentCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable

class GCSwiftCommentCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var commentLb: UILabel!
    
    @IBOutlet weak var timeLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        commentLb.backgroundColor = MetricGlobal.mainCellBgColor
        timeLb.backgroundColor = MetricGlobal.mainCellBgColor
    }
    
    func setModel() {
        let str = "一生不羁：再说一句，世界频道的在喊人来"
        
        commentLb.attributedText = str.jys.add(MetricGlobal.mainGray).add(UIColor.white, at: NSMakeRange(0, "一生不羁：".count)).add(kFont(adaptW(13.0), MetricGlobal.mainMediumFamily), at: NSMakeRange(0, "一生不羁：".count)).base
        timeLb.text = "10分钟前"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
