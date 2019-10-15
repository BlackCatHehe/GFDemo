//
//  UIButton+AutoSize.swift
//  NationalFace
//
//  Created by APP on 2019/7/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import UIKit


//MARK: -定义button相对label的位置
enum JYWButtonEdgeInsetsStyle {
    case Top
    case Left
    case Right
    case Bottom
}
extension UIButton {
    
    @IBInspectable var autoFont: CGFloat {
        get {
            return 0
        }
        set {
            self.titleLabel?.font = UIFont.systemFont(ofSize: newValue)
        }
    }
    
    func layoutButton(style: JYWButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .Top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
            break;
            
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
            break;
            
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
    
    /// 设置图片圆角
    func circleImage(radius: CGFloat) {
        //开始对imageView进行画图
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        
        //使用贝塞尔曲线画出一个圆形图
        UIBezierPath(roundedRect: bounds, cornerRadius: radius).addClip()
        
        self.draw(bounds)
        
        self.setImage(UIGraphicsGetImageFromCurrentImageContext(), for: .normal)
        //结束画图
        UIGraphicsEndImageContext();
    }
}

