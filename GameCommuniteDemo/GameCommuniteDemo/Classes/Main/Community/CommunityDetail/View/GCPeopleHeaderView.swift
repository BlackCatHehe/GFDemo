//
//  GCPeopleHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPeopleHeaderView: UIView {
    
    private var bgImageView: UIImageView!
    private var iconImgV: UIImageView!
    private var nameLb: UILabel!
    private var idLb: UILabel!
    private var followBt: UIButton!
    
    private var zanLb: UILabel!
    private var fansLb: UILabel!
    private var followLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        bgImageView.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2164478293,4167951289&fm=26&gp=0.jpg")!)
        iconImgV.kf.setImage(with: URL(string: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3916481728,2850933383&fm=26&gp=0.jpg")!)
        nameLb.text = "欧巴嘻嘻"
        idLb.text = "ID:5155956"
        
        zanLb.text = "6500"
        fansLb.text = "100"
        followLb.text = "600"
        
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
        flBt.setTitleColor(.white, for: .normal)
        flBt.layer.cornerRadius = adaptW(14.0)
        flBt.layer.masksToBounds = true
        flBt.backgroundColor = MetricGlobal.mainBlue
        flBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
        userBgView.addSubview(flBt)
        self.followBt = flBt
        
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
        flBt.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(28.0))
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
    
}
