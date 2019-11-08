//
//  GCCommuniteCateCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

protocol GCCommuniteCateCellDelegate {
    func cateCell(_ cell: GCCommuniteCateCell, didClickAdd button: UIButton)
}

class GCCommuniteCateCell: UICollectionViewCell, NibReusable {

    var delegate: GCCommuniteCateCellDelegate?
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var noButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addButton.layer.cornerRadius = 11.0
        addButton.layer.masksToBounds = true

    }

    
    func setModel(_ model: GCCommuniteModel, isJoin: Bool) {
        
        //设置是否含有添加按钮
        addButton.isHidden = isJoin
        noButtonConstraint.priority =  isJoin ? .defaultLow : .defaultHigh
        buttonConstraint.priority =  isJoin ? .defaultHigh : .defaultLow
        
        self.titleLb.text = model.name
        
        self.imageV.kfSetImage(
            url: model.cover!,
            targetSize: CGSize(width: adaptW(70.0), height: adaptW(70.0)),
            cornerRadius: adaptW(14.0)
        )

    }
    
    
    @IBAction func clickAdd(_ sender: UIButton) {
        
        self.delegate?.cateCell(self, didClickAdd: sender)
        
    }
    
}
