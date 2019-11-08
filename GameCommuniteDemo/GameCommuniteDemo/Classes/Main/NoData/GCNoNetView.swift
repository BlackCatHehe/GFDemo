//
//  GCNoNetView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/6.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

class GCNoNetView: UIView {
    
    var title: String = "暂无数据" {
        didSet {
            titleLb.text = title
        }
    }
    
    var imageStr: String = "noData" {
        didSet {
            imageView.image = UIImage(named: imageStr)
        }
    }
    
    var refreshClourse: ClickClosure?
    var netMoniterClourse: ClickClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "noSingal")
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    private lazy var titleLb: UILabel = {
        let label = UILabel()
        label.text = "网络不给力"
        label.textColor = UIColor.white
        label.font = kFont(adaptW(16.0))
        label.textAlignment = .center
        return label
    }()
    private lazy var subTitleLb: UILabel = {
        let label = UILabel()
        label.text = "别紧张，试试刷新页面"
        label.textColor = kRGB(r: 171, g: 168, b: 227)
        label.font = kFont(adaptW(13.0))
        label.textAlignment = .center
        return label
    }()
    private lazy var refreshBt: UIButton = {
        let button = UIButton()
        button.setTitle("刷新", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = adaptW(22.0)
        button.layer.masksToBounds = true
        button.layer.borderColor = MetricGlobal.mainBlue.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()
    private lazy var netMoniterBt: UIButton = {
        let button = UIButton()
        button.setTitle("网络诊断", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = adaptW(22.0)
        button.layer.masksToBounds = true
        button.backgroundColor = MetricGlobal.mainBlue
        return button
    }()
    
}

extension GCNoNetView {
    
    private func setupUI(){
        //self.isUserInteractionEnabled = false
        self.backgroundColor = MetricGlobal.mainBgColor
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(adaptW(143.0))
            make.size.equalTo(CGSize(width: adaptW(187.0), height: 130.0))
        }
        
        self.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(adaptW(10.0))
            make.height.equalTo(adaptW(15.0))
        }
        
        self.addSubview(subTitleLb)
        subTitleLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(titleLb.snp.bottom).offset(adaptW(10.0))
            make.height.equalTo(adaptW(15.0))
        }
        self.addSubview(refreshBt)
        refreshBt.addTarget(self, action: #selector(clickRefresh), for: .touchUpInside)
        refreshBt.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleLb.snp.bottom).offset(adaptW(51.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.size.equalTo(CGSize(width: adaptW(162.0), height: adaptW(44.0)))

        }
        self.addSubview(netMoniterBt)
        netMoniterBt.addTarget(self, action: #selector(clickNetMoniter), for: .touchUpInside)
        netMoniterBt.snp.makeConstraints { (make) in
            make.top.equalTo(refreshBt)
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.size.equalTo(CGSize(width: adaptW(162.0), height: adaptW(44.0)))

        }
    }
    
    @objc private func clickRefresh() {
        refreshClourse?()
    }
    
    @objc private func clickNetMoniter() {
        netMoniterClourse?()
    }
}
