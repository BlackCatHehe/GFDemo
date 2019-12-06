//
//  GCOtherMsgCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import NIMSDK
class GCOtherMsgCell: UITableViewCell, Reusable {

    private var iconImgV: UIImageView!
    private var contentLb: UILabel!
    private var timeLb: UILabel!
    
    private var contentTopCon: Constraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(isHaveTime: Bool = false, message: NIMMessage) {
        
        contentTopCon.update(priority: isHaveTime ? .low : .high)
        timeLb.isHidden = !isHaveTime
        
        timeLb.text = "09:50"
        
        if let friendId = message.session?.sessionId {
            if let user = NIMSDK.shared().userManager.userInfo(friendId) {
                if let img = user.userInfo?.avatarUrl {
                    iconImgV.kfSetImage(
                        url: img,
                        targetSize: CGSize(width: adaptW(44.0), height: adaptW(44.0)),
                        cornerRadius: adaptW(44.0)/2
                    )
                }
            }
        }
        contentLb.text = message.text
    }
}

extension GCOtherMsgCell {
    
    private func setupUI(){
        selectionStyle = .none
        backgroundColor = MetricGlobal.mainBgColor

        //TODO: -----------时间(默认隐藏)-------------
        let timeLb = UILabel()
        timeLb.textColor = .white
        timeLb.font = kFont(adaptW(10.0))
        timeLb.textAlignment = .center
        timeLb.backgroundColor = kRGB(r: 45, g: 44, b: 75)
        timeLb.layer.cornerRadius = adaptW(9.0)
        timeLb.layer.masksToBounds = true
        timeLb.isHidden = true
        contentView.addSubview(timeLb)
        self.timeLb = timeLb
        timeLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(20.0))
            make.centerX.equalToSuperview()
            make.height.equalTo(adaptW(18.0))
            make.width.equalTo(adaptW(60.0))
        }
        
        //TODO: -----------正文-------------
        let iconImgV = UIImageView()
        contentView.addSubview(iconImgV)
        self.iconImgV = iconImgV
        
        let contentBgV = UIView()
        contentView.addSubview(contentBgV)
        
        let contentImgV = UIImageView()
        contentImgV.image = UIImage(named: "chat_bg_other")
        contentBgV.addSubview(contentImgV)
        
        let contentLb = UILabel()
        contentLb.textColor = .white
        contentLb.font = kFont(adaptW(14.0))
        contentLb.numberOfLines = 0
        contentLb.preferredMaxLayoutWidth = kScreenW - adaptW(15.0 + 44.0 + 15.0)*2
        contentBgV.addSubview(contentLb)
        self.contentLb = contentLb
        
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.size.equalTo(CGSize(width: adaptW(44.0), height: adaptW(44.0)))
            make.top.equalTo(timeLb.snp.bottom).offset(adaptW(20.0)).priority(.medium)
            contentTopCon = make.top.equalToSuperview().offset(adaptW(10.0)).priority(.high).constraint
        }
        
        contentBgV.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(5.0))
            make.width.lessThanOrEqualTo(kScreenW-adaptW(15.0 + 44.0 + 10.0)*2)
            make.top.equalTo(iconImgV)
            make.bottom.equalToSuperview().offset(-adaptW(10.0))
        }
        
        contentLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(13.0)
            make.right.equalToSuperview().offset(-10.0)
            make.left.equalToSuperview().offset(15.0)
            make.bottom.equalToSuperview().offset(-10.0)
        }
        
        contentImgV.snp.makeConstraints { (make) in
            make.top.equalTo(contentLb).offset(-10.0)
            make.left.equalTo(contentLb).offset(-15.0)
            make.right.equalTo(contentLb).offset(10.0)
            make.bottom.equalTo(contentLb).offset(10.0)
            make.height.greaterThanOrEqualTo(adaptW(40.0))
        }
    }
}
