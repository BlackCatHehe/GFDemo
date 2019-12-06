//
//  GCGameDetailCenterView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCGameDetailCenterView: UIView {

    private var nameLb: UILabel!
    private var subNameLb: UILabel!
    private var scoreLb: UILabel!
    
    private var tagView: JYTagView!
    private var supportTagView: JYTagView!
    
    private var currentNumLb: UILabel!
    private var totalNumLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: GCGameModel) {
        
        nameLb.text = model.name
        subNameLb.text = model.englishName
        scoreLb.text = String(format: "%.2f", model.score ?? 0)
        
        if let labels = model.labels {
            let tags = labels.map{$0.name!}
            tagView.titles = tags
            tagView.reloadData()
        }
         
        if let btags = model.characteristics {
            let tags = btags.map{$0.name!}
            supportTagView.titles = tags
            supportTagView.reloadData()
        }

        currentNumLb.text = model.currentOnlineCount?.countString()
        totalNumLb.text = model.yesterdayPeakOnlineCount?.countString()
    }
}

extension GCGameDetailCenterView {
    
    private func initUI(){
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        //TODO: 上方
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(18.0))
        self.addSubview(nameLb)
        self.nameLb = nameLb
        
        let subNameLb = UILabel()
        subNameLb.textColor = kRGB(r: 165, g: 164, b: 192)
        subNameLb.font = kFont(adaptW(11.0))
        self.addSubview(subNameLb)
        self.subNameLb = subNameLb
        
        let scoreBollLb = UILabel()
        scoreBollLb.textColor = .white
        scoreBollLb.font = kFont(adaptW(20.0), MetricGlobal.mainMediumFamily)
        scoreBollLb.textAlignment = .center
        scoreBollLb.backgroundColor = MetricGlobal.mainBlue
        scoreBollLb.layer.cornerRadius = adaptW(21.5)
        scoreBollLb.layer.masksToBounds = true
        self.addSubview(scoreBollLb)
        self.scoreLb = scoreBollLb
        
        nameLb.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(adaptW(15.0))
            make.height.equalTo(adaptW(17.0))
        }
        subNameLb.snp.makeConstraints { (make) in
            make.top.equalTo(nameLb.snp.bottom).offset(adaptW(10.0))
            make.height.equalTo(adaptW(10.0))
            make.left.equalTo(nameLb)
        }
        scoreBollLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(11.0))
            make.size.equalTo(CGSize(width: adaptW(43.0), height: adaptW(43.0)))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        
        //TODO: 中间标签
        let cTagV = JYTagView()
        cTagV.itemHeight = adaptW(22.0)
        cTagV.itemInsetPadding = adaptW(7.0)
        cTagV.itemBuilder = {[weak cTagV, weak self] index -> UIButton in
            let bt = UIButton()
            bt.backgroundColor = kRGB(r: 61, g: 59, b: 102)
            bt.titleLabel?.font = kFont(13.0)
            bt.layer.cornerRadius = adaptW(3.0)
            bt.setTitleColor(.white, for: .normal)
            bt.layer.masksToBounds = true
            bt.tag = index + 100
            if index == cTagV!.titles.count - 1 {
                bt.addTarget(self!, action: #selector(self!.clickItem(_:)), for: .touchUpInside)
            }
            return bt
        }
        self.addSubview(cTagV)
        cTagV.snp.makeConstraints { (make) in
            make.top.equalTo(subNameLb.snp.bottom).offset(adaptW(15.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        self.tagView = cTagV

        
        //TODO: 下方标签
        
        let bTagV = JYTagView()
        bTagV.itemHeight = adaptW(22.0)
        bTagV.itemInsetPadding = adaptW(7.0)
        bTagV.itemBuilder = {index -> UIButton in
            let bt = UIButton()
            bt.titleLabel?.font = kFont(12.0)
            bt.setTitleColor(.white, for: .normal)
//            bt.setImage(UIImage(named: "shop_jinbi"), for: .normal)
            bt.tag = index + 100
            bt.isUserInteractionEnabled = false
            return bt
        }
        self.addSubview(bTagV)
        bTagV.snp.makeConstraints { (make) in
            make.top.equalTo(cTagV.snp.bottom).offset(adaptW(15.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        self.supportTagView = bTagV
        
        
        let lineV = UIView()
        lineV.backgroundColor = MetricGlobal.mainBgColor
        self.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(1.0)
            make.top.equalTo(bTagV.snp.bottom).offset(adaptW(12.0))
        }
        
        //TODO: 底部在线人数
        for i in 0..<2 {
            let bBgView = UIView()
            bBgView.backgroundColor = kRGB(r: 37, g: 36, b: 63)
            self.addSubview(bBgView)
            
            let numLb = UILabel()
            numLb.textColor = .white
            numLb.font = kFont(adaptW(18.0))
            numLb.text = "怪物猎人:世界"
            numLb.textAlignment = .center
            bBgView.addSubview(numLb)
            if i == 0 {
                self.currentNumLb = numLb
            }else {
                self.totalNumLb = numLb
            }
            
            
            let subTitleLb = UILabel()
            subTitleLb.textColor = kRGB(r: 165, g: 164, b: 192)
            subTitleLb.font = kFont(adaptW(12.0))
            subTitleLb.text = i == 0 ? "当前在线" : "昨日峰值在线"
            subTitleLb.textAlignment = .center
            bBgView.addSubview(subTitleLb)
            
            bBgView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(15.0 + (110.0 + 12.0)*CGFloat(i)))
                make.size.equalTo(CGSize(width: adaptW(110.0), height: 50.0))
                make.top.equalTo(lineV.snp.bottom).offset(adaptW(15.0))
                if i == 0 {
                    make.bottom.equalToSuperview().offset(-adaptW(15.0))
                }
            }
            numLb.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(adaptW(8.0))
                make.height.equalTo(adaptW(16.0))
            }
            subTitleLb.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(numLb.snp.bottom).offset(adaptW(5.0))
                make.height.equalTo(adaptW(11.5))
            }
        }
        
    }
    
    @objc func clickItem(_ item: UIButton) {
        let tag = item.tag - 100
        JYLog(tag)
        
        showCustomToast("添加标签")
    }
}
