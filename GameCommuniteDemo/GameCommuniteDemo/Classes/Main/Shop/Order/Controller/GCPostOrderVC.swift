//
//  GCPostOrderVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPostOrderVC: GCBaseVC {
    
    private var selectIndex: Int = 0 //0微信 1支付宝
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "确认订单"
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        initUI()
    }
    
    private lazy var orderV: GCMakeSureOrderView = {
        let view = GCMakeSureOrderView(frame: .zero)
        view.setModel()
        return view
    }()
    
    private lazy var bottomV: GCPostOrderBottomView = {
        let view = GCPostOrderBottomView(frame: .zero)
        view.setModel()
        return view
    }()

}

extension GCPostOrderVC {
    
    private func initUI() {
        
        view.addSubview(orderV)
        orderV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(bottomV)
        bottomV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(adaptW(49.0))
        }
        bottomV.payClick = {[weak self] in
            self?.pay()
        }
    }
}

extension GCPostOrderVC {
    
    private func pay() {
        let alertVC = GCAlertPayVC()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(348.0) - kBottomH, width: kScreenW, height: adaptW(348.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC

        alertVC.paySelectClick = {[weak self] index in
//            self?.selectIndex = index 
        }
        alertVC.clickPay = {[weak self] in
            
            
            let vc = GCPayResultVC()
            vc.title = "立即支付"
            self?.push(vc)
        }
        
        var rootVC = kWindow?.rootViewController
        while rootVC?.presentedViewController != nil {
            if let vc = rootVC?.presentedViewController {
                if let nvc = vc as? UINavigationController{
                    rootVC = nvc.visibleViewController
                }else if let tvc = vc as? UITabBarController{
                    rootVC = tvc.selectedViewController
                }
            }
            
        }
        rootVC?.present(alertVC, animated: true, completion: nil)
    }
}
