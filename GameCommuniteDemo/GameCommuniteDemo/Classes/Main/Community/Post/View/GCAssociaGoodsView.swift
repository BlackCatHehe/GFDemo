//
//  GCAssociaGoodsView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/5.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCAssociaGoodsView: UIView {
    
    var goodsTitle: String? {
        didSet {
            goodsTitleLb.text = goodsTitle
        }
    }
    
    var clickTag: ClickClosure?
    
    private var goodsTitleLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GCAssociaGoodsView {
    
    private func initUI() {
    
        layer.cornerRadius = adaptW(15.0)
        layer.masksToBounds = true
        backgroundColor = kRGB(r: 39, g: 38, b: 65)

        let tag = UITapGestureRecognizer(target: self, action: #selector(tapTag))
        addGestureRecognizer(tag)
        
        let tagLb = UILabel()
        tagLb.text = "商品"
        tagLb.textColor = .white
        tagLb.font = kFont(adaptW(8.0))
        tagLb.backgroundColor = kRGB(r: 255, g: 45, b: 90)
        tagLb.layer.cornerRadius = adaptW(7.0)
        tagLb.layer.masksToBounds = true
        tagLb.textAlignment = .center
        addSubview(tagLb)
        
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(13.0))
        addSubview(titleLb)
        goodsTitleLb = titleLb
        
        tagLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(7.0))
            make.centerY.equalToSuperview()
            make.width.equalTo(adaptW(23.0))
            make.height.equalTo(adaptW(14.0))
        }
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(tagLb.snp.right).offset(adaptW(5.0))
            make.right.equalToSuperview().offset(adaptW(-7.0))
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func tapTag() {
        clickTag?()

    }
}
