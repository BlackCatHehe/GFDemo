//
//  GCNormalHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCNormalHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var iconImgV: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var moreBt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        
        moreBt.isHidden = true
    }
 
    func setModel() {
        titleLb.text = "属性"
    }
}
