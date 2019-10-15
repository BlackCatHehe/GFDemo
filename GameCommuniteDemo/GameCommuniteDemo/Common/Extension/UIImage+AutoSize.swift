//
//  UIImage+AutoSize.swift
//  mingxint
//
//  Created by payTokens on 2019/4/2.
//  Copyright © 2019 放. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func creatImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //根据限制宽高设置图片大小约束
    public func getImageSize(limiteSize: CGSize) -> CGSize {
        let imageW = self.size.width
        let imageH = self.size.height
        
        let limiteW = limiteSize.width
        let limiteH = limiteSize.height
        
        
        var endHeight: CGFloat = 0
        var endwidth: CGFloat = 0
        
        if imageW < imageH{
            
            if imageH < limiteH{
                endHeight = imageH
                endwidth = imageW

            }else{
                endHeight = limiteH
                endwidth  = imageW * (limiteH/imageH)

            }
            
            if endwidth > limiteW{
                
                endHeight = endHeight * (limiteW/endwidth)
                endwidth = limiteW
            }
            
        }else{
            if imageW < limiteW{
                endwidth = imageW
                endHeight = imageH
            }else{
                endwidth = limiteW
                endHeight = imageH * (limiteW/imageW)  
            }
            
            if endHeight > limiteH{  
                endwidth  = endwidth * (limiteH/endHeight)
                endHeight = limiteH
            }
        }

        return CGSize(width: endwidth, height: endHeight)
    }
    
    //根据宽度返回等比放大的图片高度
    func getImageHeight(width: CGFloat) -> CGFloat{
        let imageW = self.size.width
        let imageH = self.size.height
        
        let endHeight = imageH * (width / imageW)

        return endHeight
    }
}
