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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.loginBt)
        loginBt.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        
        
        loginBt.rx.tap
            .bind{[weak self] in
                let vc = GCLoginVC()
                vc.addTransition(type: .push, position: .fromBottom)
                self?.push(vc)
        }.disposed(by: rx.disposeBag)
        
    }
}

extension GCLoginVC: JYNaviControllerTransitionProtocol {}
