//
//  GCMineVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCMineVC: GCBaseVC {

    private lazy var loginBt: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(nil, for: .normal)
        button.backgroundColor = UIColor.blue
        return button
    }()
    
    private lazy var settingBt: UIButton = {
        let button = UIButton()
        button.setTitle("setting", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(nil, for: .normal)
        button.backgroundColor = UIColor.blue
        return button
    }()
    
    private lazy var myItemBt: UIButton = {
           let button = UIButton()
           button.setTitle("myItem", for: .normal)
           button.setTitleColor(.white, for: .normal)
           button.setImage(nil, for: .normal)
           button.backgroundColor = UIColor.blue
           return button
       }()
    private lazy var myEstateBt: UIButton = {
        let button = UIButton()
        button.setTitle("myEstateBt", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(nil, for: .normal)
        button.backgroundColor = UIColor.blue
        return button
    }()
    private lazy var mySaleBt: UIButton = {
        let button = UIButton()
        button.setTitle("mySale", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(nil, for: .normal)
        button.backgroundColor = UIColor.blue
        return button
    }()
    
    private lazy var myGoodsMBt: UIButton = {
        let button = UIButton()
        button.setTitle("GoodsM", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(nil, for: .normal)
        button.backgroundColor = UIColor.blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.loginBt)
        loginBt.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100.0)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        loginBt.rx.tap
            .bind{[weak self] in
                
               // self?.requestInfo()
                let vc = GCLoginVC()
                vc.addTransition(type: .push, position: .fromBottom)
                self?.push(vc)
        }.disposed(by: rx.disposeBag)
        
        view.addSubview(self.settingBt)
        settingBt.snp.makeConstraints { (make) in
            make.top.equalTo(loginBt.snp.bottom).offset(20)
            make.centerX.equalTo(loginBt)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        settingBt.rx.tap
            .bind{[weak self] in
                let vc = GCSettingListVC()
                self?.push(vc)
        }.disposed(by: rx.disposeBag)
        
        view.addSubview(self.myItemBt)
        myItemBt.snp.makeConstraints { (make) in
            make.top.equalTo(settingBt.snp.bottom).offset(20)
            make.centerX.equalTo(loginBt)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        myItemBt.rx.tap
            .bind{[weak self] in
                let vc = GCShopVC()
                vc.title = "我的道具"
                self?.push(vc)
        }.disposed(by: rx.disposeBag)
        
        view.addSubview(self.myEstateBt)
        myEstateBt.snp.makeConstraints { (make) in
            make.top.equalTo(myItemBt.snp.bottom).offset(20)
            make.centerX.equalTo(loginBt)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        myEstateBt.rx.tap
            .bind{[weak self] in
                let vc = GCMyEstateVC()
                self?.push(vc)
        }.disposed(by: rx.disposeBag)
        
        view.addSubview(self.mySaleBt)
        mySaleBt.showBadge(num: "22")
        mySaleBt.snp.makeConstraints { (make) in
            make.top.equalTo(myEstateBt.snp.bottom).offset(20)
            make.centerX.equalTo(loginBt)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        mySaleBt.rx.tap
            .bind{[weak self] in
                let vc = GCSaleVC()
                self?.push(vc)
                
        }.disposed(by: rx.disposeBag)
        
        view.addSubview(self.myGoodsMBt)
        myGoodsMBt.showBadgeDot()
        myGoodsMBt.snp.makeConstraints { (make) in
            make.top.equalTo(mySaleBt.snp.bottom).offset(20)
            make.centerX.equalTo(loginBt)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        myGoodsMBt.rx.tap
            .bind{[weak self] in
                let vc = GCGoodsManagerVC()
                self?.push(vc)
                
        }.disposed(by: rx.disposeBag)
        
    }
}

extension GCLoginVC: JYNaviControllerTransitionProtocol {}

extension GCMineVC {
    private func requestInfo() {
          let prama = ["phone": "15333831665"]
          GCNetTool.requestData(target: GCNetApi.getUserInfo(prama: prama), showAcvitity: true, success: { (result) in
                     
                     
                     
                 }) { (error) in
                     JYLog(error)
                 }
      }
}
