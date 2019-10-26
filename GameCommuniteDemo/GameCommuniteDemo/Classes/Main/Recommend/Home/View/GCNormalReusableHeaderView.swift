//
//  GCNormalReusableHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/11.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCNormalReusableHeaderView: UICollectionReusableView, NibReusable {

    @IBOutlet weak var iconImgV: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
