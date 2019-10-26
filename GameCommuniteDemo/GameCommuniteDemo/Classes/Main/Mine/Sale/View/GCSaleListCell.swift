//
//  GCSaleLIstCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCSaleListCell: UITableViewCell, NibReusable {
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet var statusLb: UILabel!
    
    @IBOutlet var tLineV: UIView!
    
    @IBOutlet var goodsImgV: UIImageView!
    
    @IBOutlet var goodsDescLb: UILabel!
    
    @IBOutlet var moneyLb: UILabel!
    
    @IBOutlet var numLb: UILabel!
    
    @IBOutlet var bLineV: UIView!
    
    @IBOutlet var totalLb: UILabel!
    
    @IBOutlet var moreBt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(5.0)
        bgView.layer.masksToBounds = true
        
        bLineV.backgroundColor = MetricGlobal.mainBgColor
        tLineV.backgroundColor = MetricGlobal.mainBgColor
        
        statusLb.textColor = kRGB(r: 244, g: 234, b: 42)
        statusLb.font = kFont(adaptW(14.0))
        
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.masksToBounds = true
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        goodsImgV.layer.borderWidth = 1.0
        goodsImgV.contentMode = .scaleAspectFill
        
        goodsDescLb.textColor = .white
        goodsDescLb.font = kFont(adaptW(14.0))
        goodsDescLb.numberOfLines = 3
        
        moneyLb.textColor = MetricGlobal.mainGray
        moneyLb.font = kFont(adaptW(13.0))
        
        numLb.textColor = MetricGlobal.mainGray
        numLb.font = kFont(adaptW(13.0))
        
        totalLb.textColor = .white
        totalLb.font = kFont(adaptW(15.0))
        
        moreBt.layer.cornerRadius = adaptW(15.0)
        moreBt.setTitleColor(.white, for: .normal)
        moreBt.backgroundColor = MetricGlobal.mainBlue
        moreBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(15.0), bottom: 0, right: adaptW(15.0))
        moreBt.showBadge(num: "22")
    }
    
    func setModel() {
        
        goodsImgV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"))
        
        statusLb.text = "买家未付款"
        goodsDescLb.text = "暗影战神129加噬魂12匕首 36洞满碎片加猛攻爪和耀眼 项链"
        moneyLb.text = "¥2370.00"
        totalLb.text = "合计: ¥2370.00"
        numLb.text = "X1"
        moreBt.setTitle("查看详情", for: .normal)
        
        
    }
    
}
