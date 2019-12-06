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
        
        selectionStyle = .none
        contentView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
    }

    func setModel(_ model: GCEstateModel) {
        //model.type  1 签到，2: 奖励，3：充值， 4:交易
        switch model.type ?? 0 {
        case 1:
            titleLb.text = "签到"
        case 2:
            titleLb.text = "奖励"
        case 3:
            titleLb.text = "充值"
        case 4:
            titleLb.text = "交易"
        default:
            titleLb.text = nil
        }
        
        contentLb.text = model.descriptionField
        let str = "\(model.eth ?? "0.00")ETH"
        if str.hasPrefix("-") {
            moneyLb.textColor = MetricGlobal.mainBlue
        }else {
            moneyLb.textColor = kRGB(r: 244, g: 234, b: 34)
        }
        moneyLb.text = str
        timeLb.text = model.updatedAt
    }
}
