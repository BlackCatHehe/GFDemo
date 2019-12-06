//
//  GCChatListCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
import NIMSDK
class GCChatListCell: UITableViewCell, NibReusable {

    
    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var contentLb: UILabel!
    
    @IBOutlet weak var timeLb: UILabel!
    
    @IBOutlet weak var newMsgBt: UIButton!
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        nameLb.font = kFont(adaptW(16.0), MetricGlobal.mainMediumFamily)
        nameLb.textColor = .white
        
        contentLb.font = kFont(adaptW(13.0))
        contentLb.textColor = MetricGlobal.mainGray
        
        newMsgBt.titleLabel?.font = kFont(adaptW(11.0))
        newMsgBt.backgroundColor = kRGB(r: 255, g: 0, b: 72)
        newMsgBt.setTitleColor(.white, for: .normal)
        newMsgBt.layer.cornerRadius = adaptW(18.0)/2
        newMsgBt.layer.masksToBounds = true
        newMsgBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: 5.0)
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
    }

    func setModel(_ session: NIMRecentSession) {
        
        if let friendId = session.session?.sessionId {
            if let user = NIMSDK.shared().userManager.userInfo(friendId) {
                if let img = user.userInfo?.avatarUrl {
                    iconImgV.kfSetImage(
                        url: img,
                        targetSize: CGSize(width: adaptW(55.0), height: adaptW(55.0)),
                        cornerRadius: adaptW(55.0)/2
                    )
                }
                nameLb.text = user.userInfo?.nickName
                contentLb.text = session.lastMessage?.text
                let time = Int(session.lastMessage!.timestamp).formatTimeStamp(with: "hh:mm")
                timeLb.text = time
                
                newMsgBt.setTitle("\(session.unreadCount)", for: .normal)
                if session.unreadCount == 0 {
                    newMsgBt.isHidden = true
                }   
            }
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
