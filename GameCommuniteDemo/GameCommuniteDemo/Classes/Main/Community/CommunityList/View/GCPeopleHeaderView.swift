//
//  GCPeopleHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SnapKit

protocol GCPeopleHeaderViewDelegate {
    func headerViewDidClickFollow(headerView: GCPeopleHeaderView)
    func headerViewDidClickFollowMsgTo(headerView: GCPeopleHeaderView)
}

class GCPeopleHeaderView: UIView {
    
    var delegate: GCPeopleHeaderViewDelegate?
    
    private var bgImageView: UIImageView!
    private var iconImgV: UIImageView!
    private var nameLb: UILabel!
    private var idLb: UILabel!
    private var followBt: UIButton!
    private var msgToBt: UIButton!
    
    private var zanLb: UILabel!
    private var fansLb: UILabel!
    private var followLb: UILabel!
    
    private var followBtRightConstraint: Constraint!
    
    var isFollowed: Bool = false {
        didSet {
            
            followBtRightConstraint.update(priority: isFollowed ? .low : .high)
            msgToBt.isHidden = !isFollowed
            followBt.setTitle(isFollowed ? "已关注" : "关注", for: .normal)
            followBt.backgroundColor = isFollowed ? kRGB(r: 130, g: 146, b: 163) : MetricGlobal.mainBlue
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(isFollowed: Bool = false, model: UserModel) {
        
        self.isFollowed = model.isFollower ?? false
        
        bgImageView.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2164478293,4167951289&fm=26&gp=0.jpg")!)
        if let img = model.avatar {
            iconImgV.kf.setImage(with: URL(string: img))
        }
        
        nameLb.text = model.name
        idLb.text = "ID:\(model.id ?? 0)"
        
        zanLb.text = "none"
        fansLb.text = "\(model.followerCount ?? 0)"
        followLb.text = "\(model.followingCount ?? 0)"
        
    }
}

extension GCPeopleHeaderView {
    
    private func initUI() {
        self.backgroundColor = MetricGlobal.mainBgColor
        
        //背景图
        let bgImgV = UIImageView()
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.clipsToBounds = true
        addSubview(bgImgV)
        self.bgImageView = bgImgV
        bgImgV.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-adaptW(10.0))
        }
        
        //TODO: ----------user视图-----------
        let userBgView = UIView()
        self.addSubview(userBgView)
        
        let iconImgV = UIImageView()
        iconImgV.contentMode = .scaleAspectFill
        iconImgV.layer.borderWidth = 2.0
        iconImgV.layer.borderColor = UIColor.white.cgColor
        iconImgV.layer.cornerRadius = adaptW(55.0)/2
        iconImgV.layer.masksToBounds = true
        userBgView.addSubview(iconImgV)
        self.iconImgV = iconImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(18.0), MetricGlobal.mainMediumFamily)
        userBgView.addSubview(nameLb)
        self.nameLb = nameLb
        
        let idLb = UILabel()
        idLb.textColor = MetricGlobal.mainGray
        idLb.font = kFont(adaptW(13.0))
        userBgView.addSubview(idLb)
        self.idLb = idLb
        
        let flBt = UIButton()
        flBt.setTitle("关注", for: .normal)
        flBt.titleLabel?.font = kFont(adaptW(14.0))
        flBt.setTitleColor(.white, for: .normal)
        flBt.layer.cornerRadius = adaptW(14.0)
        flBt.layer.masksToBounds = true
        flBt.backgroundColor = MetricGlobal.mainBlue
        flBt.addTarget(self, action: #selector(clickFollow), for: .touchUpInside)
        userBgView.addSubview(flBt)
        self.followBt = flBt
        
        let msgToBt = UIButton()
        msgToBt.setTitle("私信", for: .normal)
        msgToBt.titleLabel?.font = kFont(adaptW(14.0))
        msgToBt.setTitleColor(.white, for: .normal)
        msgToBt.layer.cornerRadius = adaptW(14.0)
        msgToBt.layer.masksToBounds = true
        msgToBt.backgroundColor = MetricGlobal.mainBlue
        msgToBt.addTarget(self, action: #selector(clickMsgTo), for: .touchUpInside)
        userBgView.addSubview(msgToBt)
        self.msgToBt = msgToBt
        
        userBgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight + adaptW(10.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(55.0))
        }
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(55.0), height: adaptW(55.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgV.snp.top).offset(adaptW(8.0))
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(10.0))
            make.right.greaterThanOrEqualToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(17.0))
        }
        idLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconImgV.snp.bottom).offset(-adaptW(7.0))
            make.left.equalTo(nameLb)
            make.right.greaterThanOrEqualToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(12.0))
        }
        msgToBt.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.width.equalTo(adaptW(75.0))
            make.height.equalTo(adaptW(28.0))
        }
        flBt.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
             followBtRightConstraint = make.right.equalToSuperview().offset(-adaptW(15.0)).priority(.low).constraint
            make.right.equalTo(msgToBt.snp.left).offset(-adaptW(10.0)).priority(.medium)
            make.height.equalTo(adaptW(28.0))
            make.width.equalTo(adaptW(75.0))
        }
    
        //TODO: ----------赞，关注，粉丝-----------
        let bBgView = UIView()
        addSubview(bBgView)
        bBgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(userBgView.snp.bottom).offset(adaptW(20.0))
            make.height.equalTo(adaptW(40.0))
            make.bottom.equalTo(-adaptW(15.0))
        }
        
        let bTitles = ["获赞", "粉丝", "关注"]
        for i in 0..<bTitles.count {
            let sBgView = UIView()
            bBgView.addSubview(sBgView)
            sBgView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(20.0 + (30.0 + 50.0)*CGFloat(i)))
                make.top.bottom.equalToSuperview()
                make.width.equalTo(adaptW(50.0))
            }
            
            let topLb = UILabel()
            topLb.text = bTitles[i]
            topLb.textColor = MetricGlobal.mainGray
            topLb.font = kFont(adaptW(12.0))
            topLb.textAlignment = .center
            sBgView.addSubview(topLb)
            
            let bottomLb = UILabel()
            bottomLb.textColor = MetricGlobal.mainGray
            bottomLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
            bottomLb.textAlignment = .center
            sBgView.addSubview(bottomLb)
            switch i {
            case 0:
                self.zanLb = bottomLb
            case 1:
                self.fansLb = bottomLb
            case 2:
                self.followLb = bottomLb
            default:
                break
            }
            
            topLb.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.left.top.right.equalToSuperview()
            }
            bottomLb.snp.makeConstraints { (make) in
                make.top.equalTo(topLb.snp.bottom).offset(2.0)
                make.centerX.equalToSuperview()
                make.left.right.bottom.equalToSuperview()
            }
            
        }
    }
    
    //TODO: --------click---------
    @objc func clickFollow() {
        delegate?.headerViewDidClickFollow(headerView: self)
    }
    
    @objc func clickMsgTo() {
        delegate?.headerViewDidClickFollowMsgTo(headerView: self)
    }
}
