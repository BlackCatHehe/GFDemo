//
//  GoodDetailHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import TYCyclePagerView
import SDCycleScrollView
class GoodDetailHeaderView: UIView {
    
    private var iconImgV: UIImageView!
    private var nameLb: UILabel!
    private var timeLb: UILabel!
    private var goodsNameLb: UILabel!
    private var moneyLb: UILabel!
    private var cycleView: SDCycleScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initUI()
    }
    
}

extension GoodDetailHeaderView {
    
    private func initUI() {
        self.backgroundColor = MetricGlobal.mainBgColor
        
        //TODO: ----------user视图-----------
        let userBgView = UIView()
        userBgView.backgroundColor = MetricGlobal.mainCellBgColor
        self.addSubview(userBgView)
        
        let iconImgV = UIImageView()
        iconImgV.contentMode = .scaleAspectFill
        userBgView.addSubview(iconImgV)
        self.iconImgV = iconImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        userBgView.addSubview(nameLb)
        self.nameLb = nameLb
        
        let timeLb = UILabel()
        timeLb.textColor = MetricGlobal.mainGray
        timeLb.font = kFont(adaptW(12.0), MetricGlobal.mainMediumFamily)
        userBgView.addSubview(timeLb)
        self.timeLb = timeLb
        
        userBgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(10.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(73.0))
        }
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(49.0), height: adaptW(49.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgV.snp.top).offset(adaptW(6.0))
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(7.0))
            make.right.greaterThanOrEqualToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(14.0))
        }
        timeLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconImgV.snp.bottom).offset(-adaptW(6.0))
            make.left.equalTo(nameLb)
            make.right.greaterThanOrEqualToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(12.0))
        }
        
        //TODO: ----------goods视图-----------
        let goodsImageV = SDCycleScrollView()
        goodsImageV.currentPageDotColor = .white
        goodsImageV.pageDotColor = kRGB(r: 153, g: 153, b: 153)
        goodsImageV.autoScroll = true
        goodsImageV.autoScrollTimeInterval = 3.0
        goodsImageV.bannerImageViewContentMode = .scaleAspectFill
        goodsImageV.infiniteLoop = true
        goodsImageV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        goodsImageV.delegate = self
        self.addSubview(goodsImageV)
        self.cycleView = goodsImageV
        
        goodsImageV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(userBgView.snp.bottom).offset(adaptW(10.0))
            make.height.equalTo(adaptW(165.0))
        }
        
        let goodsBgView = UIView()
        goodsBgView.backgroundColor = MetricGlobal.mainCellBgColor
        self.addSubview(goodsBgView)
        
        let goodsNameLb = UILabel()
        goodsNameLb.textColor = .white
        goodsNameLb.font = kFont(adaptW(14.0))
        goodsBgView.addSubview(goodsNameLb)
        self.goodsNameLb = goodsNameLb
        
        let coinsImgV = UIImageView()
        coinsImgV.contentMode = .scaleAspectFill
        coinsImgV.image = UIImage(named: "shop_jinbi")
        goodsBgView.addSubview(coinsImgV)
        
        let moneyLb = UILabel()
        moneyLb.textColor = kRGB(r: 244, g: 234, b: 42)
        moneyLb.font = kFont(adaptW(12.0))
        goodsBgView.addSubview(moneyLb)
        self.moneyLb = moneyLb
        
        goodsBgView.snp.makeConstraints { (make) in
            make.top.equalTo(goodsImageV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-adaptW(10.0))
            make.height.equalTo(adaptW(50.0))
        }
        goodsNameLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.height.equalTo(adaptW(14.0))
            make.right.greaterThanOrEqualTo(coinsImgV.snp.left).offset(-20)
        }
        moneyLb.snp.makeConstraints { (make) in
            make.centerY.equalTo(goodsNameLb)
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(12.0))
        }
        coinsImgV.snp.makeConstraints { (make) in
            make.right.equalTo(moneyLb.snp.left).offset(-adaptW(5.0))
            make.size.equalTo(CGSize(width: adaptW(16.0), height: adaptW(16.0)))
            make.centerY.equalTo(goodsNameLb)
        }
    }
    
    func setModel() {
        layoutIfNeeded()
        
//        iconImgV.kf.setImage(with: URL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(49.0)/2, targetSize: iconImgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
        nameLb.text = "欧巴嘻嘻"
        timeLb.text = "上架时间:2019/08/04"
        cycleView.imageURLStringsGroup = ["https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"]
        goodsNameLb.text = "莲花台爆香"
        moneyLb.text = "10.21ETC"
    }
}

extension GoodDetailHeaderView: SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
         
    }
  
}
