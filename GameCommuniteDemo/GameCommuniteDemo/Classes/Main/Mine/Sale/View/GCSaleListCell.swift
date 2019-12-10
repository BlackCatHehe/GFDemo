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

protocol GCSaleListCellDelegate: class {
    
    func cellDidClickMore(cell: GCSaleListCell)
    
    func cellDidClickComment(cell: GCSaleListCell)
    
    func cellDidClickGoods(cell: GCSaleListCell, goodsId: Int)
}

class GCSaleListCell: UITableViewCell, NibReusable {
    
    weak var delegate: GCSaleListCellDelegate?
    
    var model: GCOrderListModel?
    
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
    
    @IBOutlet weak var commentBt: UIButton!
    
    @IBOutlet weak var goodsV: UIView!//用来点击的
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
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
        
        moreBt.layer.cornerRadius = adaptW(14.0)
        moreBt.setTitleColor(.white, for: .normal)
        moreBt.backgroundColor = MetricGlobal.mainBlue
        moreBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(10.0), bottom: 0, right: adaptW(10.0))
        moreBt.setTitle("查看详情", for: .normal)
        
        commentBt.layer.cornerRadius = adaptW(14.0)
        commentBt.setTitleColor(.white, for: .normal)
        commentBt.backgroundColor = MetricGlobal.mainBlue
        commentBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: adaptW(10.0), bottom: 0, right: adaptW(10.0))
        commentBt.setTitle("立即评价", for: .normal)
        commentBt.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGoods))
        goodsV.addGestureRecognizer(tap)
    }
    
    func setModel(_ model: GCOrderListModel) {
        
        self.model = model
        
        if let img = model.items?.first?.ornament?.cover {
            goodsImgV.kf.setImage(with: URL(string: img))
        }
        //1:待付款，2:待发货，3:待签收，4:已完成
        var statusStr: String? = nil
        
        commentBt.isHidden = true
        switch model.status {
        case 1:
            statusStr = "待付款"
        case 2:
            statusStr = "待发货"
        case 3:
            statusStr = "待签收"
        case 4:
            statusStr = "已完成"
            commentBt.isHidden = false
            
        default:
            break
        }
        statusLb.text = statusStr
        goodsDescLb.text = model.items?.first?.ornament?.content
        moneyLb.text = "ETH\(model.items?.first?.price ?? "0.00")"
        totalLb.text = "合计: ETH\(model.totalAmount ?? "0.00")"
        numLb.text = "X\(model.items?.first?.amount ?? 1)"
        
    }
    
    
    @IBAction func clickMore(_ sender: UIButton) {
        delegate?.cellDidClickMore(cell: self)
    }
    
    @objc func tapGoods(_ sender: UITapGestureRecognizer) {
        
        guard let gid = model?.items?.first?.ornament?.id else {return }
        delegate?.cellDidClickGoods(cell: self, goodsId: gid)
        
    }
    
    @IBAction func clickComment(_ sender: UIButton) {
        delegate?.cellDidClickComment(cell: self)
    }
    
}
