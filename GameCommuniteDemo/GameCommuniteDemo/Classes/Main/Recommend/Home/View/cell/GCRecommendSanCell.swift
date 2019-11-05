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

    func setModel() {
        
        layoutIfNeeded()
        leftImgV.kfSetImage(url: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2334465942,3760491718&fm=115&gp=0.jpg", targetSize: leftImgV.bounds.size, cornerRadius: adaptW(5.0))
        rightTopImgV.kfSetImage(url: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2334465942,3760491718&fm=115&gp=0.jpg", targetSize: rightTopImgV.bounds.size, cornerRadius: adaptW(5.0))
        rightBottomImgV.kfSetImage(url: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2334465942,3760491718&fm=115&gp=0.jpg", targetSize: rightBottomImgV.bounds.size, cornerRadius: adaptW(5.0))
    }
    
    @objc private func tapImgV(_ sender: UITapGestureRecognizer) {
        
        if let tag = sender.view?.tag {
            delegate?.cell(self, didSelectItemAt: tag - 100)
        }

    }
    
}
