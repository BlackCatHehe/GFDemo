//
//  GCTieziSubGoodsView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher

class GCTieziSubGoodsView: UIView {

    private var imageV: UIImageView!
    private var titleLb: UILabel!
    private var moneyBt: UIButton!
    private var payNumLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        imageV.kfSetImage(
            url: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg",
            targetSize: CGSize(width: adaptW(70.0), height: adaptW(70.0)),
            cornerRadius: adaptW(5.0)
        )
        titleLb.text = "法师噬魂9星强15， 【赠送强15法杖】+【赠送永久时装】"
        moneyBt.setTitle("0.50ETH", for: .normal)
        payNumLb.text = "525人支付"
    }
    
}

extension GCTieziSubGoodsView {
    
    private func setupUI(){
        
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        addSubview(imgV)
        self.imageV = imgV
        
        let nLabel = UILabel()
        nLabel.textColor = .white
        nLabel.font = kFont(adaptW(13.0))
        nLabel.numberOfLines = 2
        addSubview(nLabel)
        self.titleLb = nLabel
        
        let moneyBt = UIButton()
        moneyBt.isUserInteractionEnabled = false
        moneyBt.setTitleColor(.white, for: .normal)
        moneyBt.titleLabel?.font = kFont(adaptW(12.0))
        addSubview(moneyBt)
        self.moneyBt = moneyBt
        
        let payNumLb = UILabel()
        payNumLb.textColor = kRGB(r: 165, g: 164, b: 192)
        payNumLb.font = kFont(adaptW(12.0))
        payNumLb.textAlignment = .center
        addSubview(payNumLb)
        self.payNumLb = payNumLb
        
        imgV.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(adaptW(5.0))
            make.bottom.equalToSuperview().offset(-adaptW(5.0))
            make.size.equalTo(CGSize(width: adaptW(70.0), height: adaptW(70.0)))
        }
        nLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgV.snp.right).offset(adaptW(8.0))
            make.top.equalTo(imgV)
            make.right.equalToSuperview().offset(-adaptW(5.0))
        }
        moneyBt.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgV.snp.bottom)
            make.left.equalTo(nLabel)
            make.height.equalTo(adaptW(17.0))
        }
        payNumLb.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(2.0))
            make.centerY.equalTo(moneyBt)
        }
    }
}
