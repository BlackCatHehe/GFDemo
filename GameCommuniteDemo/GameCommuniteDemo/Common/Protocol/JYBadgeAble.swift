//
//  BadgeAble.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/25.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

protocol JYBadgeAble {
    
}

extension UIView: JYBadgeAble {}

extension JYBadgeAble where Self: UIView {
    
    ///添加dot
    func showBadgeDot(_ topMargin: CGFloat = 2.0, _ rightMargin: CGFloat = 2.0) {
        removeBadge()
        
        let dotV = UIView()
        dotV.backgroundColor = kRGB(r: 255, g: 45, b: 90)
        dotV.layer.cornerRadius = adaptW(2.5)
        dotV.tag = 1000001
        self.addSubview(dotV)
        dotV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(topMargin)
            make.right.equalToSuperview().offset(-rightMargin)
            make.size.equalTo(CGSize(width: adaptW(5.0), height: adaptW(5.0)))
        }
    }
    
    ///添加带文字的badge
    func showBadge(num: String) {
        removeBadge()
        
        var resultNum = num
        if let number = Int(num), number > 99 {
            resultNum = "99+"
        }
        let button = UIButton()
        button.setTitle(resultNum, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = kRGB(r: 255, g: 45, b: 90)
        button.titleLabel?.font = kFont(adaptW(9.0), MetricGlobal.mainMediumFamily)
        button.layer.cornerRadius = adaptW(7.0)
        button.layer.masksToBounds = true
        button.tag = 1000001

        let width = num.jy_getSizeWith(font: kFont(adaptW(9.0), MetricGlobal.mainMediumFamily), maxSize: CGSize(width: adaptW(20.0), height: adaptW(20.0))).height
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.top).offset(adaptW(4.0))
            make.centerX.equalTo(self.snp.right).offset(-adaptW(4.0))
            make.height.equalTo(adaptW(14.0))
            make.width.equalTo(width < adaptW(14.0) ? adaptW(14.0) : width)
        }
    }
    
    
    ///移除边角
    func removeBadge() {
        for subV in self.subviews {
            if subV.tag == 1000001 {
                subV.removeFromSuperview()
            }
        }
    }
}

