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

protocol GCGoodsManagerCellDelegate {
    func managerCell(_ cell: GCGoodsManagerCell, didClickDelete button: UIButton)
    func managerCell(_ cell: GCGoodsManagerCell, didClickXiaJia button: UIButton)
}

class GCGoodsManagerCell: UITableViewCell, NibReusable {

    var delegate: GCGoodsManagerCellDelegate?
    
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
        
        selectionStyle = .none
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
    
    func setModel(isXia: Bool = false, model: GCGoodsModel) {
        if let img = model.cover {
            goodsImgV.kf.setImage(with: URL(string: img))
        }

        goodsDescLb.text = model.content
        resNumLb.text = "库存: 2370"
        saledLb.text = "已售: 32"
        totalLb.text = "¥\(model.price ?? "0.00")"
        
        deleteBt.setTitle("删除", for: .normal)
       
        moreBt.setTitle(isXia ? "重新编辑" : " 下架", for: .normal)
        
        deleteBt.isHidden = !isXia
        withdrawImgV.isHidden = !isXia
        
    }
    
    @IBAction func clickDel(_ sender: UIButton) {
        delegate?.managerCell(self, didClickDelete: sender)
    }
    
    @IBAction func clickMore(_ sender: UIButton) {
        delegate?.managerCell(self, didClickXiaJia: sender)
    }
    
}
