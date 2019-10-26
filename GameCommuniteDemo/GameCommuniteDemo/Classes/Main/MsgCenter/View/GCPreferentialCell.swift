//
//  GCPreferentialCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCPreferentialCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var timeBt: UIButton!
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var contentLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = MetricGlobal.mainBgColor
        
        timeBt.layer.cornerRadius = adaptW(10.0)
        timeBt.layer.masksToBounds = true
        timeBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(10.0), bottom: 0, right: adaptW(10.0))
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(10.0)
        bgView.layer.masksToBounds = true
        
    }
    
    func setModel() {
        timeBt.setTitle("2019.09.10 11:37", for: .normal)
        titleLb.text = "推荐成功，新人大礼包最高送7000元ddddd"
        contentLb.text = "仅需3秒即可领取专属幸运大礼包，赶快来领取 您的礼包吧，更多惊喜等着你。"
        
        layoutIfNeeded()
        imageV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(10.0), targetSize: imageV.bounds.size, roundingCorners: [.topLeft, .topRight], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
        
    }
}
