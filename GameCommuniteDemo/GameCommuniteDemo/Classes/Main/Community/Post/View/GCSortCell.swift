//
//  GCSortCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCSortCell: UICollectionViewCell, Reusable {
    
    var title: String? {
        didSet {
            titleLb.text = title
        }
    }
    
    var isSel: Bool = false {
        didSet {
            titleLb.backgroundColor = isSel ? MetricGlobal.mainBlue : kRGB(r: 39, g: 38, b: 65)
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

extension GCSortCell {
    
    private func initUI(){
        
        self.layer.cornerRadius = 2.0
        self.layer.masksToBounds = true
        
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(13.0))
        titleLb.textAlignment = .center
        titleLb.backgroundColor = kRGB(r: 39, g: 38, b: 65)
        self.contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.titleLb = titleLb
    }
}
