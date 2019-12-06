//
//  GCPostNoSteamView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPostNoSteamView: UIView {

    var tapOpen: ClickClosure?
    
    private var title: String
    private var buttonTitle: String
    
    
    init(frame: CGRect, title: String, buttonTitle: String) {
        
        self.title = title
        self.buttonTitle = buttonTitle
        
        super.init(frame: frame)
    
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GCPostNoSteamView {
    
    private func initUI(){
        
        self.backgroundColor = MetricGlobal.mainBgColor
        
        let desLb = UILabel()
        desLb.textColor = .white
        desLb.textAlignment = .center
        desLb.font = kFont(adaptW(16.0))
        desLb.numberOfLines = 2
        desLb.text = title
        self.addSubview(desLb)
   
        
        let openBt = UIButton()
        openBt.setTitleColor(.white, for: .normal)
        openBt.setTitle(buttonTitle, for: .normal)
        openBt.titleLabel?.font = kFont(adaptW(15.0))
        openBt.layer.cornerRadius = adaptW(22.0)
        openBt.layer.masksToBounds = true
        openBt.backgroundColor = MetricGlobal.mainBlue
        openBt.addTarget(self, action: #selector(clickOpen), for: .touchUpInside)
        self.addSubview(openBt)

        
        openBt.snp.makeConstraints { (make) in
            make.width.equalTo(adaptW(172.0))
            make.height.equalTo(adaptW(44.0))
            make.center.equalToSuperview()
        }
        
        desLb.snp.makeConstraints { (make) in
            make.width.equalTo(adaptW(208.0))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(openBt.snp.top).offset(-adaptW(50.0))
        }
    }
    
    @objc func clickOpen() {
        tapOpen?()
    }
}
