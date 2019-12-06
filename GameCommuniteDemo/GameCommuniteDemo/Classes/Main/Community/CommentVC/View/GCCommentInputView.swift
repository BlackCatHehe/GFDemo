//
//  GCCommentInputView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/20.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import GrowingTextView

protocol GCCommentInputViewDelegate: class {
    func inputViewDidClickEmoji(inputView: GCCommentInputView)
    func inputView(inputView: GCCommentInputView, didClickPost text: String)
}

class GCCommentInputView: UIView {

    weak var delegate: GCCommentInputViewDelegate?
    
    var isFirstClassComment: Bool = true//是否为一级评论
    
    private var contentTV: GrowingTextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///弹出键盘
    func alert(with placeholder: String) {
        contentTV.placeholder = placeholder
        if contentTV.canBecomeFirstResponder {
            contentTV.becomeFirstResponder()
        }
    }
    ///清除输入框内容
    func clearMsg() {
        contentTV.text = ""
        contentTV.placeholder = ""
    }
}

extension GCCommentInputView {
    
    private func initUI() {
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        let contentTV = GrowingTextView()
        contentTV.placeholderColor = kRGB(r: 229, g: 229, b: 229)
        contentTV.font = kFont(adaptW(13.0))
        contentTV.textColor = .white
        contentTV.minHeight = adaptW(34.0)
        contentTV.maxHeight = adaptW(100.0)
        contentTV.layer.cornerRadius = adaptW(17.0)
        contentTV.layer.masksToBounds = true
        contentTV.backgroundColor = kRGB(r: 39, g: 38, b: 65)
        contentTV.contentInset = UIEdgeInsets(top: adaptW(2.0), left: adaptW(5.0), bottom: 0, right: adaptW(5.0))
        self.contentTV = contentTV
        self.addSubview(contentTV)
        contentTV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7.0)
            make.bottom.equalToSuperview().offset(-7.0 - kBottomH)
            make.height.greaterThanOrEqualTo(adaptW(34.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
        }
        
        
        let rightBt = UIButton()
        rightBt.setTitle("发送", for: .normal)
        rightBt.titleLabel?.font = kFont(adaptW(15.0))
        rightBt.backgroundColor = MetricGlobal.mainBlue
        rightBt.layer.cornerRadius = adaptW(15.0)
        rightBt.layer.masksToBounds = true
        rightBt.addTarget(self, action: #selector(clickPost), for: .touchUpInside)
        self.addSubview(rightBt)
        rightBt.snp.makeConstraints { (make) in
            make.left.equalTo(contentTV.snp.right).offset(adaptW(12.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalToSuperview().offset(9.0)
            make.size.equalTo(CGSize(width: adaptW(57.0), height: adaptW(30.0)))
        }
    }
    
    @objc func clickEmoji() {
        delegate?.inputViewDidClickEmoji(inputView: self)
    }
    
    @objc func clickPost() {
        if contentTV.canResignFirstResponder {
            contentTV.resignFirstResponder()
        }
        delegate?.inputView(inputView: self, didClickPost: contentTV.text)
    }
}
