//
//  GCGoodsDetailCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCGoodsDetailCell: UITableViewCell, NibReusable {

    @IBOutlet weak var detailLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = MetricGlobal.mainCellBgColor
        detailLb.backgroundColor = MetricGlobal.mainCellBgColor
        detailLb.textColor = .white
        detailLb.font = kFont(adaptW(14.0))
    }

    func setModel(_ model: GCGoodsModel) {
        detailLb.text = model.content
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
