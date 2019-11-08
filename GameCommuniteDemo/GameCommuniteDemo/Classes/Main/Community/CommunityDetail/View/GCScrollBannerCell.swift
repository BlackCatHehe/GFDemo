//
//  GCScrollBannerCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/7.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCScrollBannerCell: UITableViewCell, Reusable {

    private var titleLb: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(title: String?) {
        titleLb?.text = title
    }
}

extension GCScrollBannerCell {
    
    private func setupUI(){
        
        self.selectionStyle = .none
        self.contentView.backgroundColor = MetricGlobal.mainCellBgColor
        
        let label = UILabel()
        label.text = "置顶"
        label.textAlignment = .center
        label.textColor = .white
        label.font = kFont(adaptW(11.0))
        label.backgroundColor = kRGB(r: 255, g: 45, b: 90)
        self.contentView.addSubview(label)
        
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = kFont(adaptW(13.0))
        self.contentView.addSubview(titleLabel)
        self.titleLb = titleLabel
        
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.width.equalTo(adaptW(30.0))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(adaptW(7.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.centerY.equalToSuperview()
        }
    }
}
