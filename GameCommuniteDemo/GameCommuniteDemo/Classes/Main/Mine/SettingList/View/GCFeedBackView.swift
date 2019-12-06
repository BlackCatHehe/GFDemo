//
//  GCFeedBackView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import GrowingTextView

class GCFeedBackView: UIView {
    
    var contentTV: GrowingTextView!
    private var numLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(){
        
        
        
    }
}

extension GCFeedBackView {
    
    private func initUI() {
        
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(17.0), MetricGlobal.mainMediumFamily)
        titleLb.textAlignment = .center
        titleLb.text = "对我们的建议或意见"
        self.addSubview(titleLb)
      
        let tvBgV = UIView()
        tvBgV.backgroundColor = MetricGlobal.mainCellBgColor
        self.addSubview(tvBgV)
        
        let textView = GrowingTextView()
        textView.placeholder = "请输入反馈内容，我们会为您更好的服务"
        textView.backgroundColor = MetricGlobal.mainCellBgColor
        textView.placeholderColor = kRGB(r: 128, g: 126, b: 184)
        textView.font = kFont(adaptW(14.0))
        textView.textColor = kRGB(r: 128, g: 126, b: 184)
        textView.maxLength = 500
        textView.delegate = self
        textView.minHeight = adaptW(151.0)
        textView.maxHeight = adaptW(151.0)
        tvBgV.addSubview(textView)
        self.contentTV = textView
        
        let countLb = UILabel()
        countLb.textColor = kRGB(r: 27, g: 26, b: 47)
        countLb.font = kFont(adaptW(13.0))
        countLb.textAlignment = .right
        countLb.text = "0/500"
        tvBgV.addSubview(countLb)
        self.numLb = countLb
        
        let postBt = UIButton()
        postBt.setTitle("提交", for: .normal)
        postBt.setTitleColor(.white, for: .normal)
        postBt.titleLabel?.font = kFont(adaptW(15.0))
        postBt.backgroundColor = MetricGlobal.mainBlue
        postBt.layer.cornerRadius = adaptW(22.0)
        postBt.layer.masksToBounds = true
        postBt.addTarget(self, action: #selector(clickPost), for: .touchUpInside)
        self.addSubview(postBt)
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.top.equalToSuperview().offset(adaptW(31.0))
            make.height.equalTo(adaptW(16.5))
        }
        tvBgV.snp.makeConstraints { (make) in
            make.top.equalTo(titleLb.snp.bottom).offset(adaptW(22.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(191.0))
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(10.0))
            make.right.equalToSuperview().offset(-adaptW(10.0))
        }
        countLb.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(adaptW(5.0))
            make.right.equalTo(textView)
            make.height.equalTo(adaptW(13.0))
            make.bottom.equalTo(-adaptW(5.0))
        }
        postBt.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalTo(tvBgV.snp.bottom).offset(adaptW(60.0))
            make.height.equalTo(adaptW(44.0))
            make.bottom.equalToSuperview()
        }
    }
}

extension GCFeedBackView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.numLb.text = "\(textView.text.count)/500"
    }
}

extension GCFeedBackView {
    
    @objc func clickPost() {
        
    }
}
