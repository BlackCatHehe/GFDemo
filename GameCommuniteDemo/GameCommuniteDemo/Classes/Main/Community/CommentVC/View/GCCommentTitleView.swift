//
//  GCCommentTitleView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/20.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCCommentTitleView: UIView {

    var clickBack: ClickClosure?
   
    var comNum: Int = 0 {
        didSet{
            titleLb.text = "共\(comNum)条评论"
        }
    }
    
    private var titleLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension GCCommentTitleView {
    
    private func initUI(){
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        let titleLabel = UILabel()
        titleLabel.text = "共0条评论"
        titleLabel.textColor = .white
        titleLabel.font = kFont(adaptW(16.0))
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        self.titleLb = titleLabel
        
        let button = UIButton()
        button.setImage(UIImage(named: "chahao"), for: .normal)
        button.addTarget(self, action: #selector(clickChahao), for: .touchUpInside)
        self.addSubview(button)
        
        let lineV = UIView()
        lineV.backgroundColor = MetricGlobal.mainBgColor
        self.addSubview(lineV)
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenW, height: adaptW(16.0)))
        }
        button.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.size.equalTo(CGSize(width: adaptW(20.0), height: adaptW(20.0)))
        }
        lineV.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    @objc func clickChahao() {
        clickBack?()
    }
}
