//
//  GCMemberCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

protocol GCMemberCellDelegate: class {
    func cellDidClickFollow(cell: GCMemberCell)
}

class GCMemberCell: UITableViewCell, NibReusable {
    
    weak var delegate: GCMemberCellDelegate?
    
    @IBOutlet var iconImgV: UIImageView!
    
    @IBOutlet var nameLb: UILabel!
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet weak var followBt: UIButton!
    
    private var isFollow: Bool = false{
        didSet {
            if isFollow {
                followBt.backgroundColor = kRGB(r: 45, g: 43, b: 77)
                followBt.setTitle("已关注", for: .normal)
            }else {
                followBt.backgroundColor = MetricGlobal.mainBlue
                followBt.setTitle("关注", for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        
        followBt.layer.cornerRadius = adaptW(15.0)
        followBt.layer.masksToBounds = true
    }
    
    func setModel(_ model: UserModel) {
        if let img = model.avatar {
             iconImgV.kfSetImage(
                 url: img,
                 targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
                 cornerRadius: adaptW(43.0)/2
             )
        }
        nameLb.text = model.name
        isFollow = model.isFollower ?? false

    }
    
    @IBAction func clickFollow(_ sender: UIButton) {
        delegate?.cellDidClickFollow(cell: self)
    }
    
    
}
