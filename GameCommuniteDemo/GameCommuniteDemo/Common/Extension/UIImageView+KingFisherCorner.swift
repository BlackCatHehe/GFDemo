//
//  UIImageView+KingFisherCorner.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/31.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import Kingfisher

//kingfisher对圆角的处理
extension UIImageView {
    func kfSetImage(
        url: String,
        placeholder: UIImage? = nil,
        targetSize: CGSize,
        cornerRadius: CGFloat,
        roundingcorners: RectCorner = .all,
        backgroundColor: UIColor = .clear,
        downloadPriority: Float = 1.0
    ) {
//        let resize = ResizingImageProcessor(referenceSize: targetSize, mode: .aspectFill)//将图片自适应至目标大小
//        let crop = CroppingImageProcessor(size: targetSize)//剪切图片
//        let corner = RoundCornerImageProcessor(cornerRadius: cornerRadius, targetSize: targetSize, roundingCorners: roundingcorners, backgroundColor: backgroundColor)//给剪切后的图片加上圆角
//        let processor = (resize >> crop) >> corner
//
//        self.kf.setImage(
//            with: URL(string: url),
//            placeholder: placeholder,
//            options: [
//                .processor(corner),
//                .cacheOriginalImage
//            ],
//            progressBlock: nil,
//            completionHandler: nil)
        
//        self.contentMode = .scaleAspectFit
//
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        //图片包含中文路径的处理
        var encodeStr: URL? = nil
        if let resultUrl = URL(string: url) {
            encodeStr = resultUrl
        } else {
            let str = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            encodeStr = URL(string: str!)
        }
        self.kf.setImage(with: ImageResource(downloadURL: encodeStr!), placeholder: nil, options: nil, progressBlock: nil) { (_, _, _, _) in
//
//            UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
//            let rect = CGRect( origin: .zero, size: targetSize)
//            let ref = UIGraphicsGetCurrentContext()
//            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
//            ref?.addPath(path.cgPath)
//            ref?.clip()
//            self.draw(rect)
//            ref?.drawPath(using: .fillStroke)
//            let img = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//
//            self.image = img
        }
        

    }
}
