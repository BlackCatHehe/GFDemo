//
//  GCEstateDetailCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable

class GCEstateDetailCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var contentLb: UILabel!
    
    @IBOutlet weak var moneyLb: UILabel!
    
    @IBOutlet weak var timeLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
    }

    func setModel() {
        
        titleLb.text = "签到"
        contentLb.text = "完成签到任务"
        let str = arc4random()%2 == 1 ? "+100.00ETH" : "-50.00ETH"
        if str.hasPrefix("+") {
            moneyLb.textColor = kRGB(r: 244, g: 234, b: 34)
        }else {
            moneyLb.textColor = MetricGlobal.mainBlue
        }
        moneyLb.text = str
        timeLb.text = "2019-03-29 23:12:35"
    }
}
