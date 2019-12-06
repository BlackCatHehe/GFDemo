//
//  File.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/6.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import MBProgressHUD
import Kingfisher
import Toast_Swift

protocol JYToastAble {
    
}

extension JYToastAble where Self: UIView {
    
    ///弹出
    func showCustomToast(_ msg: String, title: String? = nil, _ position: ToastPosition = .center) {
        self.hideToast()
        self.makeToast(msg, duration: ToastManager.shared.duration, position: position, title: title, image: nil, style: ToastManager.shared.style)
    }
    ///显示动态加载图
    func showGifLoad() {

        let hud = MBProgressHUD(view: self)
        hud.bezelView.style = .solidColor//自己定义背景颜色
        hud.bezelView.backgroundColor = .clear//背景颜色
        hud.removeFromSuperViewOnHide = true
        hud.mode = .customView
  
        hud.customView = JYGifCustomView(frame: CGRect(x: self.jy_centerX, y: 0, width: kScreenW, height: adaptW(100.0)))
  
        self.addSubview(hud)
        hud.show(animated: true)
    }
    
    ///隐藏动态加载图
    func hiddenGifLoad() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}

extension UIView: JYToastAble {}

//MARK: ------------自定义gifview 上gif下字------------
class JYGifCustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: adaptW(150.0), height: adaptW(150.0))
    }
}

extension JYGifCustomView{
    
    private func initUI(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let path = Bundle.main.path(forResource: "load.gif", ofType: nil)
        
        let imageview = UIImageView(frame: CGRect(x: adaptW((150.0 - 60.0)/2.0), y: 20, width: adaptW(60.0), height: adaptW(60.0)))
        
        imageview.kf.setImage(with: ImageResource(downloadURL: URL(fileURLWithPath: path!)))
        self.addSubview(imageview)
        
        let titleLb = UILabel(frame: CGRect(x: 0, y: imageview.jy_maxY + adaptW(10.0), width: adaptW(150.0), height: adaptW(20)))
        titleLb.font = kFont(adaptW(15.0))
        titleLb.textAlignment = .center
        titleLb.textColor = .white
        titleLb.text = "正在加载，请稍等…"
        self.addSubview(titleLb)
    }
}
