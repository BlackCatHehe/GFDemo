//
//  GCSortBottomButtonsView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCSortBottomButtonsView: UIView {

    var tapButton: ((Int)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GCSortBottomButtonsView {
    
    private func initUI(){
        self.layer.cornerRadius = adaptW(19.0)
        self.layer.masksToBounds = true
        
        for i in 0..<2 {
            let button = UIButton()
            button.setTitle(i == 0 ? "重制" : "确定", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.tag = 100+i
            button.backgroundColor = i == 0 ? kRGB(r: 130, g: 146, b: 163) : MetricGlobal.mainBlue
            self.addSubview(button)
            button.addTarget(self, action: #selector(clickBt(_:)), for: .touchUpInside)
            button.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(adaptW(93.5*CGFloat(i)))
                make.height.equalTo(adaptW(38.0))
                make.width.equalToSuperview().multipliedBy(0.5)
            }
        }
    }
    
    @objc func clickBt(_ sender: UIButton) {
        let index = sender.tag - 100
        tapButton?(index)
    }
}
