//
//  GCCommuniteResuableView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCCommuniteResuableView: UICollectionReusableView, NibReusable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
    }
    
}
