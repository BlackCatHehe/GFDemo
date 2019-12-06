//
//  GCMineHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/4.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCMineHeaderView: UIView {

    var clickMyEstate: ClickClosure?
    
    private var topBgImgV: UIImageView!
    private var iconView: UIImageView!
    private var nameLb: UILabel!
    private var idLabel: UILabel!
    private var moneyLb: UILabel!
    
   // private var chartView: GCChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: UserModel) {
        
        topBgImgV.image = UIImage(named: "mine_top_bg")
        
        if let avatar = model.avatar{
            iconView.kfSetImage(url: avatar, targetSize: CGSize(width: adaptW(55.0), height: adaptW(55.0)), cornerRadius: adaptW(55.0)/2)
        }
        nameLb.text = model.name
        idLabel.text = "ID:\(model.id!)"
        moneyLb.text = "\(model.eth ?? "0.00")ETH"
    }
}

extension GCMineHeaderView {
    
    private func initUI(){
        self.backgroundColor = MetricGlobal.mainBgColor
        
        //MARK: ------------topview------------
        let topBgV = UIView()
        self.addSubview(topBgV)
        
        let bgImgV = UIImageView()
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.clipsToBounds = true
        topBgV.addSubview(bgImgV)
        self.topBgImgV = bgImgV
        
        let iconV = UIImageView()
        iconV.contentMode = .scaleAspectFill
        iconV.layer.borderColor = UIColor.white.cgColor
        iconV.layer.borderWidth = 1.0
        topBgV.addSubview(iconV)
        self.iconView = iconV
        
        let nameLb = UILabel()
        nameLb.font = kFont(adaptW(16.0), MetricGlobal.mainMediumFamily)
        nameLb.textColor = .white
        topBgV.addSubview(nameLb)
        self.nameLb = nameLb
        
        let idLb = UILabel()
        idLb.font = kFont(adaptW(12.0))
        idLb.textColor = kRGB(r: 209, g: 208, b: 231)
        topBgV.addSubview(idLb)
        self.idLabel = idLb
        
        topBgV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kStatusBarheight + kNavBarHeight + adaptW(109.0))
        }
        bgImgV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        iconV.snp.makeConstraints { (make) in
            make.left.equalTo(adaptW(15.0))
            make.top.equalTo(kStatusBarheight + kNavBarHeight + adaptW(7.0))
            make.size.equalTo(CGSize(width: adaptW(55.0), height: adaptW(55.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.left.equalTo(iconV.snp.right).offset(adaptW(12.0))
            make.top.equalTo(iconV.snp.top).offset(adaptW(10.0))
            make.height.equalTo(adaptW(15.0))
        }
        idLb.snp.makeConstraints { (make) in
            make.left.equalTo(nameLb)
            make.bottom.equalTo(iconV.snp.bottom).offset(-adaptW(10.0))
            make.height.equalTo(adaptW(10.0))
        }
        
        //MARK: ------------myEstate------------
        let estateBgV = UIView()
        estateBgV.backgroundColor = MetricGlobal.mainCellBgColor
        self.addSubview(estateBgV)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapEnterMyEState))
        estateBgV.addGestureRecognizer(tap)
        
        let cTitleLb = UILabel()
        cTitleLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        cTitleLb.textColor = .white
        cTitleLb.text = "我的资产"
        estateBgV.addSubview(cTitleLb)
        
        let moneyLb = UILabel()
        moneyLb.font = kFont(adaptW(15.0))
        moneyLb.textColor = .white
        estateBgV.addSubview(moneyLb)
        self.moneyLb = moneyLb
        
        let moreImgV = UIImageView()
        moreImgV.contentMode = .scaleAspectFit
        moreImgV.image = UIImage(named: "base_more")
        estateBgV.addSubview(moreImgV)
        
        estateBgV.snp.makeConstraints { (make) in
            make.top.equalTo(topBgV.snp.bottom).offset(adaptW(11.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(48.0))
        }
        cTitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
        }
        moneyLb.snp.makeConstraints { (make) in
            make.right.equalTo(moreImgV.snp.left).offset(adaptW(-10.0))
            make.centerY.equalTo(cTitleLb)
        }
        moreImgV.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(adaptW(-10.0))
            make.centerY.equalTo(cTitleLb)
            make.size.equalTo(CGSize(width: adaptW(20.0), height: adaptW(20.0)))
        }
        
//        //MARK: ------------lineChart------------
//        let chartBgView = UIView()
//        chartBgView.backgroundColor = MetricGlobal.mainCellBgColor
//        self.addSubview(chartBgView)
//
//        let chartLb = UILabel()
//        chartLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
//        chartLb.textColor = .white
//        chartLb.text = "最近7天ETH走势"
//        chartBgView.addSubview(chartLb)
        
//        let chartV = GCChartView()
//        chartBgView.addSubview(chartV)
//
//        chartBgView.snp.makeConstraints { (make) in
//            make.top.equalTo(estateBgV.snp.bottom).offset(adaptW(12.0))
//            make.left.right.equalToSuperview()
//            make.height.equalTo(adaptW(246.0))
//        }
//        chartLb.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(adaptW(15.0))
//            make.top.equalToSuperview().offset(adaptW(10.0))
//            make.height.equalTo(adaptW(14.0))
//        }
//        chartV.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(adaptW(15.0))
//            make.right.equalToSuperview().offset(-adaptW(15.0))
//            make.top.equalTo(chartLb.snp.bottom).offset(adaptW(12.0))
//            make.bottom.equalToSuperview().offset(-adaptW(15.0))
//        }
    }
    
    @objc private func tapEnterMyEState() {
        clickMyEstate?()
    }
}
