//
//  GCGoodsPriceFloatCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCGoodsPriceFloatCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var timeLb: UILabel!
    
    @IBOutlet weak var goodsNameLb: UILabel!
    
    @IBOutlet weak var moneyLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            backgroundColor = MetricGlobal.mainCellBgColor
        }

        func setModel() {
            timeLb.text = "15分钟前"
            goodsNameLb.text = "莲花台爆香"
            moneyLb.text = "1000ETC"
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
