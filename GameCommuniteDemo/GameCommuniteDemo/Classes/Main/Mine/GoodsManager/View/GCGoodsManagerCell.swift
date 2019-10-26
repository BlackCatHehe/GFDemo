//
//  GCGoodsManagerCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCGoodsManagerCell: UITableViewCell, NibReusable {

    @IBOutlet var bgView: UIView!
    
    @IBOutlet var goodsImgV: UIImageView!
    
    @IBOutlet var goodsDescLb: UILabel!
    
    @IBOutlet var resNumLb: UILabel!
    
    @IBOutlet var saledLb: UILabel!
    
    @IBOutlet var bLineV: UIView!
    
    @IBOutlet var totalLb: UILabel!
    
    @IBOutlet weak var withdrawImgV: UIImageView!
    
    @IBOutlet weak var deleteBt: UIButton!
    
    @IBOutlet var moreBt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = MetricGlobal.mainBgColor
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(5.0)
        bgView.layer.masksToBounds = true
        
        bLineV.backgroundColor = MetricGlobal.mainBgColor
        
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.masksToBounds = true
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        goodsImgV.layer.borderWidth = 1.0
        goodsImgV.contentMode = .scaleAspectFill
        
        goodsDescLb.textColor = .white
        goodsDescLb.font = kFont(adaptW(14.0))
        goodsDescLb.numberOfLines = 2
        
        resNumLb.textColor = MetricGlobal.mainGray
        resNumLb.font = kFont(adaptW(13.0))
        
        saledLb.textColor = MetricGlobal.mainGray
        saledLb.font = kFont(adaptW(13.0))
        
        totalLb.textColor = .white
        totalLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        
        deleteBt.layer.cornerRadius = adaptW(15.0)
        deleteBt.setTitleColor(.white, for: .normal)
        deleteBt.backgroundColor = MetricGlobal.mainCellBgColor
        deleteBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(15.0), bottom: 0, right: adaptW(15.0))
        deleteBt.layer.borderWidth = 1.0
        deleteBt.layer.borderColor = MetricGlobal.mainBlue.cgColor
        
        moreBt.layer.cornerRadius = adaptW(15.0)
        moreBt.setTitleColor(.white, for: .normal)
        moreBt.backgroundColor = MetricGlobal.mainBlue
        moreBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(15.0), bottom: 0, right: adaptW(15.0))
    }
    
    func setModel(isXia: Bool = false) {
        
        goodsImgV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"))
        
        goodsDescLb.text = "暗影战神129加噬魂12匕首 36洞满碎片加猛攻爪和耀眼 项链"
        resNumLb.text = "库存: 2370"
        saledLb.text = "已售: 32"
        totalLb.text = "¥230.00"
        moreBt.setTitle("下架", for: .normal)
        deleteBt.setTitle("删除", for: .normal)
        
        deleteBt.isHidden = !isXia
        withdrawImgV.isHidden = !isXia
        
    }
    
    @IBAction func clickDel(_ sender: UIButton) {
        
    }
    
    @IBAction func clickMore(_ sender: UIButton) {
        
    }
    
}
