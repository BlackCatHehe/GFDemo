//
//  UIImage+AutoSize.swift
//  mingxint
//
//  Created by payTokens on 2019/4/2.
//  Copyright © 2019 放. All rights reserved.
//

import UIKit

extension UIImage {

    ///根据颜色创建图片
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
    
    ///根据限制宽高设置图片大小约束
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

//MARK: ------------图片压缩------------
extension UIImage {
    
    ///对指定图片进行拉伸
    func resizableImage(name: String) -> UIImage {
        
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsets(top: imageHeight, left: imageWidth, bottom: imageHeight, right: imageWidth))
        
        return normal
    }
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(maxLength: Int) -> Data? {
        
        let newSize = self.scaleImage(image: self, imageLength: 300)
        let newImage = self.resizeImage(image: self, newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = newImage?.jpegData(compressionQuality: compress)
        
        guard let rData = data else {return nil}
        while rData.count > maxLength && compress > 0.01 {
            compress -= 0.02
            data = newImage?.jpegData(compressionQuality: compress)
        }
        
        return data
    }
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
    
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
