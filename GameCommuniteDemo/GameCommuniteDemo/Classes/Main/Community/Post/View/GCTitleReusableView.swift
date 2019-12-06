//
//  GCTitleReusableView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCTitleReusableView: UICollectionReusableView, Reusable {
    
    var title: String? {
        didSet {
            titleLb.text = title
        }
    }
    
    private var titleLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GCTitleReusableView {
    
    private func initUI(){
        
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(15.0))
        titleLb.backgroundColor = MetricGlobal.mainBgColor
        self.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.height.equalTo(adaptW(20.0))
        }
        self.titleLb = titleLb
    }
}
