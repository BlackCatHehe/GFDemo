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
    
    func setModel() {
        layoutIfNeeded()
        
        imageV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"))
        
        titleLb.text = "天天天天"
        hotBt.setTitle("1852", for: .normal)
        hotBt.layoutButton(style: .Left, imageTitleSpace: adaptW(3.0))
    }

}
