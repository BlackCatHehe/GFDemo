//
//  JYNinePicView.swift
//  NationalFace
//
//  Created by APP on 2019/7/27.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import LZImageBrowser

fileprivate struct Metric {
    static let margin: CGFloat = 10.0
    static let imageW: CGFloat = 100.0
}


class JYWNinePicsView: UIView {
    
    /**
     * 存放当前的imageV数组
     */
    var imageVs = [UIImageView]()
    
    /**
     * 点击图片大屏显示的第三方插件：LZImageBrowser
     */
    var picManager: LZImageBrowserManger?
    
    /**
     点击某个图片大图显示
     
     - Parameters:
     - num: 当前点击的是第几个图片
     - ninePicView:点击图片所在的父视图
     - manager:LZImageBrowserManger
     */
    typealias NormalBlock = (_ num: Int, _ ninePicView: JYWNinePicsView, _ manager: LZImageBrowserManger?) ->()
    
    var itemClick : NormalBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("JYWNinePicsView.deinit")
    }
}

extension JYWNinePicsView {
    
    @objc func tapImage(gesture: UITapGestureRecognizer){
        
        if let view = gesture.view{
            if itemClick != nil{
                
                itemClick!(view.tag - 1000, self, picManager)
            }
        }
    }
    
    
    /**
     收到传进来的图片链接并展示（最多九个）
     
     - Parameters:
     - images: 图片链接
     
     - Returns: nil
     */
    func setImages(image: [String]?){
        
        for subView in self.subviews{
            subView.removeFromSuperview()
        }
        
        guard let images = image else {
            return
        }

        guard images.count != 0 else{return}
        guard images.count <= 9 else{return}
        
        var firstRowV: UIImageView? = nil
        var secondRowV: UIImageView? = nil
        
        for i in 0..<images.count{
            
            let imageV = UIImageView(frame: CGRect.zero)
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            imageV.kf.setImage(with: URL(string: images[i]),placeholder: nil)
            imageV.isUserInteractionEnabled = true
            imageV.tag = 1000 + i
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage(gesture:)))
            imageV.addGestureRecognizer(tapGesture)
            
            self.addSubview(imageV)
            imageVs.append(imageV)
            
            if i == 0{
                firstRowV = imageV
            }else if i == 3{
                secondRowV = imageV
            }
            
            imageV.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: Metric.imageW, height: Metric.imageW))
                make.left.equalToSuperview().offset(CGFloat(i%3) * (Metric.imageW + 10))
                // make.right.equalToSuperview().offset(CGFloat(2 - i%3) * (Metric.imageW + 10))
                if i < 3{
                    make.top.equalToSuperview().offset(Metric.margin)
                    make.bottom.equalToSuperview().offset(-Metric.margin).priority(.low)
                }else if i >= 3 && i < 6{
                    make.top.equalTo(firstRowV!.snp.bottom).offset(Metric.margin)
                    make.bottom.equalToSuperview().offset(-Metric.margin).priority(.medium)
                }else{
                    make.top.equalTo(secondRowV!.snp.bottom).offset(Metric.margin)
                    make.bottom.equalToSuperview().offset(-Metric.margin).priority(.high)
                }
            }
        }
        
        
    }
}
