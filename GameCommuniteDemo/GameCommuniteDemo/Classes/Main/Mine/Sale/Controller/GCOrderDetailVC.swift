//
//  GCOrderDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SwiftyJSON

class GCOrderDetailVC: GCBaseVC {

    var pageModel: GCOrderListModel? {
        didSet {
            if let model = pageModel {
                setModel(model)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "订单详情"
        initUI()
    }
    
    private func setModel(_ model: GCOrderListModel) {
        
        headerV.setModel(model)
        orderV.setModel(model)
        bDetailLb.attributedText = "订单编号：\(model.no ?? "")\n下单时间：\(model.createdAt ?? "")\n付款时间：\(model.updatedAt ?? "")\n订单备注: ".jys.add(kFont(adaptW(12.0))).add(CGFloat(10.0)).base
        
    }
    
    private lazy var headerV: GCOrderDetailHeaderView = {
        let view = GCOrderDetailHeaderView(frame: .zero)
        
        return view
    }()
    
    private lazy var orderV: GCGoodsDetailCellView = {
        let view = GCGoodsDetailCellView(frame: .zero)
        view.layer.cornerRadius = adaptW(5.0)
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var bDetailLb: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = kFont(12)
        label.numberOfLines = 0
        label.backgroundColor = MetricGlobal.mainCellBgColor
        return label
    }()
    
    private lazy var bottomV: GCOrderBottomView = {
        let v = GCOrderBottomView()
        return v
    }()
    
}

extension GCOrderDetailVC {
    
    private func initUI(){
        view.addSubview(headerV)
        headerV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(68.0))
        }
        
        view.addSubview(orderV)
        orderV.snp.makeConstraints { (make) in
            make.top.equalTo(headerV.snp.bottom).offset(adaptW(20.0))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(adaptW(90.0))
        }
        
        let detailV = UIView()
        detailV.backgroundColor = MetricGlobal.mainCellBgColor
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.top.equalTo(orderV.snp.bottom).offset(adaptW(14.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        detailV.addSubview(bDetailLb)
        bDetailLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(14.0))
            make.left.equalToSuperview().offset(adaptW(9.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.bottom.equalToSuperview().offset(-adaptW(9.0))
        }
        
        view.addSubview(bottomV)
        bottomV.delegate = self
        bottomV.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(adaptW(48.0) + kBottomH)   
        }
    }
}

extension GCOrderDetailVC: GCOrderBottomViewDelegate {
    
    func bottomViewDidClickKefu(bottomView: GCOrderBottomView) {
        
        if let tel = GCUserDefault.shareInstance.kefuTel {
            call(to: tel)
        }else {
            requestAboutUS()
        }
        
        
    }
    
    func bottomViewDidClickDelete(bottomView: GCOrderBottomView) {
        
    }
}


extension GCOrderDetailVC {
    
    private func requestAboutUS() {
        GCNetTool.requestData(target: GCNetApi.aboutUs, controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            
            let json = JSON(result)
            if let tel = json["service_phone"].string {
                GCUserDefault.shareInstance.kefuTel = tel
                
                call(to: tel)
            }else {
                self.showToast("获取客服电话失败，请重试")
            }

            
            
        }) { (error) in
            JYLog(error)
        }
    }
}


