//
//  GCRecommendSanCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable

protocol GCRecommendSanCellDelegate {
    func cell(_ cell: GCRecommendSanCell, didSelectItemAt index: Int)
}
class GCRecommendSanCell: UICollectionViewCell, NibReusable {

    var delegate: GCRecommendSanCellDelegate?
    
    @IBOutlet weak var leftImgV: UIImageView!
    
    @IBOutlet weak var rightTopImgV: UIImageView!
    
    @IBOutlet weak var rightBottomImgV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapImgV(_:)))
        leftImgV.addGestureRecognizer(tap1)
        leftImgV.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapImgV(_:)))
        rightTopImgV.addGestureRecognizer(tap2)
        rightTopImgV.isUserInteractionEnabled = true
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapImgV(_:)))
        rightBottomImgV.addGestureRecognizer(tap3)
        rightBottomImgV.isUserInteractionEnabled = true
    }

    func setModel(_ models: [GCNewActivityModel]) {
        guard models.count == 3 else {
            return
        }
        layoutIfNeeded()
        leftImgV.kfSetImage(url: models[0].cover!, targetSize: leftImgV.bounds.size, cornerRadius: adaptW(5.0))
        rightTopImgV.kfSetImage(url: models[1].cover!, targetSize: rightTopImgV.bounds.size, cornerRadius: adaptW(5.0))
        rightBottomImgV.kfSetImage(url: models[2].cover!, targetSize: rightBottomImgV.bounds.size, cornerRadius: adaptW(5.0))
    }
    
    @objc private func tapImgV(_ sender: UITapGestureRecognizer) {
        
        if let tag = sender.view?.tag {
            delegate?.cell(self, didSelectItemAt: tag - 100)
        }

    }
    
}
