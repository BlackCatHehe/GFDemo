//
//  GCAssociationGoodsCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
class GCAssociationGoodsCell: UITableViewCell, NibReusable {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var goodsImgV: UIImageView!
    
    @IBOutlet weak var goodsNameLb: UILabel!
    
    @IBOutlet weak var subTitleLb: UILabel!
    
    @IBOutlet weak var moneyLb: UILabel!
    
    @IBOutlet weak var selectedBt: UIButton!
    
    var isSel : Bool = false {
        didSet{
            selectedBt.isSelected = isSel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        
        selectedBt.isUserInteractionEnabled = false
        selectedBt.setImage(UIImage(named: "check_noSel"), for: .normal)
        selectedBt.setImage(UIImage(named: "check_sel"), for: .selected)
        
    }
    
    func setModel(_ model: GCGoodsModel) {
        
        layoutIfNeeded()
        
        if let img = model.cover {
            goodsImgV.kfSetImage(
                url: img,
                targetSize: goodsImgV.bounds.size,
                cornerRadius: adaptW(4.0)
            )
        }
        
        goodsNameLb.text = model.name
        subTitleLb.text = model.content
        moneyLb.text = "\(model.price ?? "0.00")ETC"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
