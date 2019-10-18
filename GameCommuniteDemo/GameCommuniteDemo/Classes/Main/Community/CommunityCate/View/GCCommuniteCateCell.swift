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

    
    func setModel(_ model: [String: String], isAdd: Bool = false) {
        
        //设置是否含有添加按钮
        addButton.isHidden = !isAdd
        noButtonConstraint.priority =  isAdd ? .defaultLow : .defaultHigh
        buttonConstraint.priority =  isAdd ? .defaultHigh : .defaultLow
        
        layoutIfNeeded()
        
        self.titleLb.text = model["title"]
        self.imageV.kf.setImage(with: URL(string: model["img"]!), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(14.0), targetSize: self.imageV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
    }
    
    
    @IBAction func clickAdd(_ sender: UIButton) {
        
        self.delegate?.cateCell(self, didClickAdd: sender)
        
    }
    
}
