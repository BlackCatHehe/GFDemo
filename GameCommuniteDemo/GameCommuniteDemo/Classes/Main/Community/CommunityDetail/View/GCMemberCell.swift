//
//  GCMemberCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class GCMemberCell: UITableViewCell, NibReusable {
    
    @IBOutlet var iconImgV: UIImageView!
    
    @IBOutlet var nameLb: UILabel!
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet weak var followBt: UIButton!
    
    private var isFollow: Bool = false{
        didSet {
            if isFollow {
                followBt.backgroundColor = kRGB(r: 45, g: 43, b: 77)
                followBt.setTitle("已关注", for: .normal)
            }else {
                followBt.backgroundColor = MetricGlobal.mainBlue
                followBt.setTitle("关注", for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        
        followBt.layer.cornerRadius = adaptW(15.0)
        followBt.layer.masksToBounds = true
    }
    
    func setModel() {
        
        layoutIfNeeded()
        
        iconImgV.kfSetImage(
            url: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg",
            targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
            cornerRadius: adaptW(43.0)/2
        )

    }
    
    
}
