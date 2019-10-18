//
//  NFBaseVC.swift
//  NationalFace
//
//  Created by APP on 2019/7/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SnapKit
import Toast_Swift

class GCBaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackItem()
        setBackgroundColor(bgColor: kRGB(r: 24, g: 23, b: 40), shadowColor: .clear)
        setTitleAttri(color: .white, font: kFont(adaptW(18.0), "HelveticaNeue-Medium"))
        view.backgroundColor = MetricGlobal.mainBgColor
    }
    
    func showToast(_ msg: String, position: ToastPosition = .center) {
        //        let bgView = UIView(frame: view.bounds)
        //        bgView.isUserInteractionEnabled = tapEnabled
        //        view.addSubview(bgView)
        view.makeToast(msg, duration: ToastManager.shared.duration, position: position, title: nil, image: nil, style: ToastManager.shared.style)
    }
    
    func push(_ vc: UIViewController, animated: Bool = true) {
        
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: animated)
        
    }
    func dismissOrPop(_ animated: Bool = true) {
        
        if self.presentingViewController != nil {
            self.dismiss(animated: animated, completion: nil)
        }else {

            navigationController?.popViewController(animated: animated)
        }
        
        
        
    }
    
    ///设置返回按钮
    func setBackItem(title: String = "", tintColor: UIColor = kRGB(r: 4, g: 4, b: 4)) {
        
        //        let backItem = UIBarButtonItem(title: title, style: .done, target: nil, action: nil)
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(clickPop))
        backItem.tintColor = tintColor
        navigationItem.leftBarButtonItem = backItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
    }
    
    @objc private func clickPop() {
        navigationController?.popViewController(animated: true)
    }

}

extension GCBaseVC: UIGestureRecognizerDelegate {}
extension GCBaseVC: JYNavigationComponentProtocol {}
