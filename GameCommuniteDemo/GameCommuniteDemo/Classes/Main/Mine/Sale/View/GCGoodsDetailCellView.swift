//
//  GCGoodsDetailCellView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCGoodsDetailCellView: UIView {
    
    private var goodsImageV: UIImageView!
    private var goodsNameLb: UILabel!
    private var goodsQuLb: UILabel!
    private var goodsMoneyBt: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setModel(_ model: GCGoodsModel) {
//        goodsImageV.kf.setImage(with: URL(string:model.cover!))
//        goodsNameLb.text = model.name
//        goodsQuLb.text = "所在区/服：魔兽世界(国服）/一区"
//        goodsMoneyBt.setTitle("\(model.price!)ETH", for: .normal)
//
//    }
    func setModel() {
       // goodsImageV.kf.setImage(with: URL(string:model.cover!))
        goodsNameLb.text = "ddd"
        goodsQuLb.text = "所在区/服：魔兽世界(国服）/一区"
        goodsMoneyBt.setTitle("100.00ETH", for: .normal)
        
    }
}

extension GCGoodsDetailCellView {
    
    private func initUI() {
        
        let scrollview = UIScrollView()
        if #available(iOS 11.0, *) {
            scrollview.contentInsetAdjustmentBehavior = .never
        }
        addSubview(scrollview)
        scrollview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        
        //MARK: ------------topGoodsMsg------------
        let topBgview = UIView()
        topBgview.backgroundColor = MetricGlobal.mainCellBgColor
        topBgview.layer.cornerRadius = adaptW(5.0)
        topBgview.layer.masksToBounds = true
        scrollview.addSubview(topBgview)
        
        let goodsImgV = UIImageView()
        goodsImgV.contentMode = .scaleAspectFill
        goodsImgV.clipsToBounds = true
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        goodsImgV.layer.borderWidth = 1.0
        topBgview.addSubview(goodsImgV)
        self.goodsImageV = goodsImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(15.0))
        nameLb.numberOfLines = 2
        topBgview.addSubview(nameLb)
        self.goodsNameLb = nameLb
        
        let quLb = UILabel()
        quLb.textColor = kRGB(r: 165, g: 164, b: 192)
        quLb.font = kFont(adaptW(13.0))
        topBgview.addSubview(quLb)
        self.goodsQuLb = quLb
        
        let moneyBt = UIButton()
        moneyBt.tintColor = .white
        moneyBt.setImage(UIImage(named: "icon_silver"), for: .normal)
        moneyBt.setTitleColor(.white, for: .normal)
        moneyBt.titleLabel?.font = kFont(adaptW(14.0))
        topBgview.addSubview(moneyBt)
        self.goodsMoneyBt = moneyBt
        
        topBgview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.width.equalTo(kScreenW - adaptW(15.0)*2)
        }
        goodsImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(8))
            make.top.equalToSuperview().offset(adaptW(12.0))
            make.size.equalTo(CGSize(width: adaptW(60.0), height: adaptW(60.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(goodsImgV)
            make.left.equalTo(goodsImgV.snp.right).offset(adaptW(10.0))
            make.right.equalToSuperview().offset(-adaptW(7.0))
        }
        quLb.snp.makeConstraints { (make) in
            make.top.equalTo(nameLb.snp.bottom).offset(adaptW(10.0))
            make.left.right.equalTo(nameLb)
            make.height.equalTo(adaptW(12.0))
        }
        moneyBt.snp.makeConstraints { (make) in
            make.top.equalTo(quLb.snp.bottom).offset(adaptW(10.0))
            make.left.equalTo(quLb)
            make.height.equalTo(adaptW(15.0))
            make.bottom.equalToSuperview().offset(-adaptW(12.0))
        }
        
    }
}
