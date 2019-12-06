//
//  GCTableViewCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var iconImgV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        lineView.backgroundColor = MetricGlobal.mainBgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
