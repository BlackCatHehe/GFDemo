//
//  GCUsualGameCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCUsualGameCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var hotBt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(5.0)
        
        imageV.backgroundColor = MetricGlobal.mainCellBgColor
    }
    
    func setModel(_ model: GCGameModel) {
        if let img = model.cover {
            imageV.kf.setImage(with: URL(string: img))
        }

        titleLb.text = model.name
        hotBt.setTitle("\(model.score ?? 0)", for: .normal)
        hotBt.layoutButton(style: .Left, imageTitleSpace: adaptW(3.0))
    }

}
