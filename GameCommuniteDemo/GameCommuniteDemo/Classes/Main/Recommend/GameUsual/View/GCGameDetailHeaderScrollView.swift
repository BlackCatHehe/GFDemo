//
//  GCGameDetailHeaderScrollView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCGameDetailHeaderScrollView: UIView {

    var imageUrls = [String]() {
        didSet {
            self.setImages()
        }
    }
    
    var originImageUrls = [String]()
    
    private var mainImgV: UIImageView!
    private var scrollV: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImages() {
        
        if originImageUrls.isEmpty {
            if let firstUrl = imageUrls.first {
                mainImgV.kfSetImage(url: firstUrl, targetSize: CGSize(width: kScreenW, height: adaptW(179.0)), cornerRadius: 0)
            }
        }else {
            mainImgV.kfSetImage(url: originImageUrls[0], targetSize: CGSize(width: kScreenW, height: adaptW(179.0)), cornerRadius: 0)
        }
        
        
        
        
        for i in 0..<imageUrls.count {
            let imgUrl = imageUrls[i]
            
            let subImageV = UIImageView()
            subImageV.isUserInteractionEnabled = true
            subImageV.tag = i+100
            subImageV.kfSetImage(url: imgUrl, targetSize: CGSize(width: adaptW(75.0), height: 50.0), cornerRadius: 0)
            scrollV.addSubview(subImageV)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(_:)))
            subImageV.addGestureRecognizer(tap)
            
            subImageV.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(adaptW(75.0*CGFloat(i)))
                make.height.equalTo(adaptW(50.0))
                make.width.equalTo(adaptW(75.0))
                if i == imageUrls.count - 1 {
                    make.right.equalToSuperview()
                }
            }
        }
    }
}

extension GCGameDetailHeaderScrollView {
    
    private func initUI(){
        
        let imageV = UIImageView()
        self.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(179.0))
        }
        self.mainImgV = imageV
        
        let scrollV = UIScrollView()
        scrollV.bounces = false
        self.addSubview(scrollV)
        scrollV.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(50.0))
            make.bottom.equalToSuperview()
        }
        self.scrollV = scrollV
        
    }
    
    @objc func tapImg(_ tap: UITapGestureRecognizer) {
        if let tag = tap.view?.tag {
            let index = tag - 100
            
            let imgUrl = originImageUrls.isEmpty ? imageUrls[index] : originImageUrls[index]
            
            mainImgV.kfSetImage(url: imgUrl, targetSize: CGSize(width: kScreenW, height: adaptW(179.0)), cornerRadius: 0)
            
        }
    }
}
