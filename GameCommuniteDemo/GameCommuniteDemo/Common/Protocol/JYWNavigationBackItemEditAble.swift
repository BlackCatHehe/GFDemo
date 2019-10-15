//
//  YKZNavigationBackItemEditAble.swift
//  一刻钟
//
//  Created by kuroneko on 2019/6/10.
//  Copyright © 2019 连杰. All rights reserved.
//

import Foundation
import UIKit

protocol JYWNavigationBackItemEditAble {
    
}

extension JYWNavigationBackItemEditAble where Self: UIViewController {
    ///设置标题颜色和字体大小
    func setTitleAttri(color: UIColor = kRGB(r: 51, g: 51, b: 51), font: UIFont = kFont(adaptW(16.0))) {
        
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font : font]
        //标题颜色
        navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
    }
    ///设置背景颜色和阴影颜色
    func setBackgroundColor(bgColor: UIColor? = nil, shadowColor: UIColor? = nil) {
        
        let bgImage = bgColor == nil ? nil : UIImage.creatImageWithColor(color: bgColor!)
        let shadowColor = shadowColor == nil ? nil :  UIImage.creatImageWithColor(color: shadowColor!)
        if bgImage != nil {}
        navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
        navigationController?.navigationBar.shadowImage = shadowColor
    }

}

extension UIViewController: JYWNavigationBackItemEditAble {}
