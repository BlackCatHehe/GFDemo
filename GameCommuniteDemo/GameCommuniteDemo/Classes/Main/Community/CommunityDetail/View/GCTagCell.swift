//
//  GCTagCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCTagCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var tagButton: UIButton!
    
    @IBOutlet weak var contentLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        tagButton.layer.cornerRadius = 2.0
        tagButton.layer.masksToBounds = true
        tagButton.backgroundColor = kRGB(r: 255, g: 45, b: 90)
        
        
    }
    
    func setModel() {
        tagButton.setTitle("置顶", for: .normal)
        contentLb.text = "【官方开黑技术】队伍构成战略技巧篇"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
