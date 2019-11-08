//
//  GCNoDataView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/4.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import MJRefresh

class GCNoDataView: UIView {

    var refreshHeader: MJRefreshHeader? {
        didSet {
            scrollView?.mj_header = refreshHeader
        }
    }
    
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
    
    private var scrollView: UIScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    private lazy var titleLb: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = kFont(adaptW(16.0))
        label.textAlignment = .center
        return label
    }()
}

extension GCNoDataView {
    
    private func setupUI(){
        //self.isUserInteractionEnabled = false
        self.backgroundColor = MetricGlobal.mainBgColor
        
        let scrollV = UIScrollView()
        self.addSubview(scrollV)
        self.scrollView = scrollV
        scrollV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(kScreenW)
        }
        
        scrollV.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(adaptW(200.0))
            make.size.equalTo(CGSize(width: adaptW(187.0), height: 130.0))
        }
        
        scrollV.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(adaptW(10.0))
            make.height.equalTo(adaptW(15.0))
            make.bottom.equalToSuperview()
        }
    }
}
