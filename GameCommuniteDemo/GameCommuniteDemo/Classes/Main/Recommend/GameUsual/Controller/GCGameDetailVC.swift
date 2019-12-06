//
//  GCGameDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCGameDetailVC: GCBaseVC {
    
    var pageModel: GCGameModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "游戏简介"
        setupUI()
        setModel()
    }
    
    private var headerScrollV: GCGameDetailHeaderScrollView = {
        let v = GCGameDetailHeaderScrollView()
        return v
    }()
    
    private var centerView: GCGameDetailCenterView = {
        let v = GCGameDetailCenterView()
        return v
    }()
    
    private var descView: GCGameDetailDescView = {
        let v = GCGameDetailDescView()
        return v
    }()
    
    private func setModel() {
        guard let model = pageModel else {return}
        //顶部轮播图
        var imgs = [String]()
        var origins = [String]()
        if let images = pageModel?.images {
            imgs = images.map{$0.image ?? ""}
            origins = images.map{$0.largeImage ?? ""}
        }
        headerScrollV.imageUrls = imgs
        headerScrollV.originImageUrls = origins
        
        //
        centerView.setModel(model)
        
        descView.setModel(model)
    }
    
}

extension GCGameDetailVC {
    
    private func setupUI(){
        
        self.componentInstall(with: JYNavigationComponents.share) {[weak self] (model) in
            self?.clickShare()
        }
        
        let scrollV = UIScrollView()
        if #available(iOS 11.0, *) {
            scrollV.contentInsetAdjustmentBehavior = .never
            self.extendedLayoutIncludesOpaqueBars = true//navigabar不透明
        }
        //设置背景为scrollview
        view.addSubview(scrollV)
        scrollV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        //1.头部可滚动图片视图
        scrollV.addSubview(headerScrollV)
        headerScrollV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(kScreenW)
        }
        
        //2.中部介绍
        scrollV.addSubview(centerView)
        centerView.snp.makeConstraints { (make) in
            make.top.equalTo(headerScrollV.snp.bottom).offset(adaptW(12.0))
            make.left.right.equalToSuperview()
        }
 
        //3.底部游戏简介
        scrollV.addSubview(descView)
        descView.snp.makeConstraints { (make) in
            make.top.equalTo(centerView.snp.bottom).offset(adaptW(12.0))
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomH - adaptW(20.0))
        }
    }
    
    
    
    private func clickShare() {
        let alertVC = GCAlertShareCenterVC()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(241.0) - kBottomH, width: kScreenW, height: adaptW(241.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC
        
        alertVC.clickChoosePlatForm = {[weak self] index in
            switch index {
            case 0:
                JYLog("weixin")
            case 1:
                JYLog("pengyouquan")
            case 2:
                JYLog("xinlang")
            default:
                JYLog("qq")
            }
        }
       present(alertVC, animated: true, completion: nil)
    }
}
