//
//  GCMsgCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
import NIMSDK
class GCMsgCell: UITableViewCell, NibReusable {

    @IBOutlet weak var iconImgV: UIImageView!
       
       @IBOutlet weak var nameLb: UILabel!
       
       @IBOutlet weak var contentLb: UILabel!
       
       @IBOutlet weak var timeLb: UILabel!
       
       @IBOutlet weak var bgView: UIView!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        selectionStyle = .none
    }
    
    func setModel(_ session: NIMRecentSession) {
        if let friendId = session.session?.sessionId {
            if let user = NIMSDK.shared().userManager.userInfo(friendId) {
                if let img = user.userInfo?.avatarUrl {
                    iconImgV.kfSetImage(
                        url: img,
                        targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
                        cornerRadius: adaptW(43.0)/2
                    )
                }
                nameLb.text = user.userInfo?.nickName
                contentLb.text = session.lastMessage?.text
                let time = Int(session.lastMessage!.timestamp).formatTimeStamp(with: "hh:mm")
                timeLb.text = time
        
            }
        }
    }
}
