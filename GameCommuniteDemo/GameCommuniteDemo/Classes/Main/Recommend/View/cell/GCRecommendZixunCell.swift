//
//  GCRecommendZixunCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCRecommendZixunCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var viewNumLb: UILabel!
    
    @IBOutlet weak var timeLb: UILabel!
    
    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
