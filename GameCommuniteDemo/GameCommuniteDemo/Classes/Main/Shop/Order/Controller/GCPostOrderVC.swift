//
//  GCPostOrderVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPostOrderVC: GCBaseVC {
    
    var gModel: GCGoodsModel!
    
    private var orderId: Int?
    
    private var selectIndex: Int = 0 //1微信 2支付宝
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "确认订单"
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        initUI()
    }
    
    private lazy var orderV: GCMakeSureOrderView = {
        let view = GCMakeSureOrderView(frame: .zero)
        
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
        
        orderV.setModel(self.gModel)
        view.addSubview(orderV)
        orderV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(bottomV)
        bottomV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(49.0))
            make.bottom.equalToSuperview().offset(-kBottomH)
        }
        bottomV.payClick = {[weak self] in
            self?.pay()
        }
    }
}

extension GCPostOrderVC {
    
    private func pay() {
        
        self.requestCreateOrder {[weak self] in
            let alertVC = GCAlertPayVC()
            
            let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
            preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(348.0) - kBottomH, width: kScreenW, height: adaptW(348.0))
            alertVC.modalPresentationStyle = .custom
            alertVC.transitioningDelegate = preAniVC

            alertVC.paySelectClick = { index in
                if index == 0 {
                    alertVC.dismissOrPop()
                }else {
                    self?.requestPayOrder(index: index)
                }
            }
            alertVC.clickPay = {[weak self] in
                
                let vc = GCPayResultVC()
                vc.title = "立即支付"
                self?.push(vc)
            }
            
            self?.present(alertVC, animated: true, completion: nil)
        }
    }
}
//MARK: ------------request------------
extension GCPostOrderVC {
    
    ///创建订单
    private func requestCreateOrder(success: @escaping (()->())) {
        
        guard let numStr = orderV.numTF.text, let num = Int(numStr), num >= 1 else {
            showToast("请输入正确的购买数量")
            return
        }
        let prama = [
            "ornament_id" : self.gModel.id!,
            "amount" : num
            ] as [String : Any]
        
        JYLog(prama)
        GCNetTool.requestData(target: GCNetApi.createOrder(prama: prama), success: { (result) in
            
            if let orderId = result["id"] as? Int {
                self.orderId = orderId
                dispatch_async_safe {
                    success()
                }
            }
        }) { (error) in
            JYLog(error)

        }
    }
    
    
    /// 支付订单
    /// - Parameter index: 1为微信 2为支付宝
    private func requestPayOrder(index: Int) {
        
        guard let oid = self.orderId else {
            showToast("获取订单信息出错")
            return
        }
        let prama: [String: Int] = [
            "payment_method" : index,
            "order_id" : oid
            ] as [String : Any] as! [String : Int]
        JYLog(prama)
        GCNetTool.requestData(target: GCNetApi.orderPay(prama), success: { (result) in
            
            
            
        }) { (error) in
            JYLog(error)
            
        }
    }
    
}
