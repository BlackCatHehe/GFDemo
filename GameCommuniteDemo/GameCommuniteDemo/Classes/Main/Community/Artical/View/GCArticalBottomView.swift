//
//  GCArticalBottomView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import GrowingTextView

protocol GCArticalBottomViewDelegate {
    func bView(_ bottomView: GCArticalBottomView, didClickComment button: UIButton)
    func bView(_ bottomView: GCArticalBottomView, didClickLike button: UIButton)
}
class GCArticalBottomView: UIView {

    var delegate: GCArticalBottomViewDelegate?
    
    private var contentTV: GrowingTextView!
    private var commentBt: UIButton!
    private var likeBt: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func setModel() {
        contentTV.placeholder = "评论(已有100条评论)"
        
        commentBt.setTitle("10000", for: .normal)
        commentBt.layoutButton(style: .Left, imageTitleSpace: 5.0)
        
        likeBt.setTitle("20", for: .normal)
        likeBt.layoutButton(style: .Left, imageTitleSpace: 5.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GCArticalBottomView {
    
    private func initUI(){
        
        backgroundColor = kRGB(r: 24, g: 23, b: 40)
        
        let textView = GrowingTextView()
        textView.backgroundColor = kRGB(r: 39, g: 38, b: 65)
        textView.font = kFont(adaptW(13.0))
        textView.placeholderColor = kRGB(r: 229, g: 229, b: 229)
        textView.minHeight = adaptW(34.0)
        textView.maxHeight = adaptW(100.0)
        textView.contentInset = UIEdgeInsets(top: adaptW(2.0), left: adaptW(5.0), bottom: 0, right: adaptW(5.0))
        textView.layer.cornerRadius = adaptW(17.0)
        textView.layer.masksToBounds = true
        addSubview(textView)
        self.contentTV = textView
        
        let commentBt = UIButton()
        commentBt.setTitleColor(.white, for: .normal)
        commentBt.setImage(UIImage(named: "communite_comment"), for: .normal)
        commentBt.titleLabel?.font = kFont(adaptW(13.0))
        commentBt.addTarget(self, action: #selector(clickComment(_:)), for: .touchUpInside)
        addSubview(commentBt)
        self.commentBt = commentBt
        
        let likeBt = UIButton()
        likeBt.setImage(UIImage(named: "communite_like"), for: .normal)
        likeBt.setImage(UIImage(named: "communite_like_sel"), for: .selected)
        likeBt.setTitleColor(.white, for: .normal)
        likeBt.titleLabel?.font = kFont(adaptW(13.0))
        likeBt.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
        addSubview(likeBt)
        self.likeBt = likeBt
        
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.top.equalToSuperview().offset(adaptW(8.0))
            make.bottom.equalToSuperview().offset(-adaptW(8.0) - kBottomH)
            make.height.greaterThanOrEqualTo(adaptW(34.0))
        }
        commentBt.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(15.0))
            make.left.equalTo(textView.snp.right).offset(adaptW(15.0))
            make.width.equalTo(adaptW(60.0))
            make.height.equalTo(adaptW(20.0))
        }
        likeBt.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(15.0))
            make.left.equalTo(commentBt.snp.right).offset(adaptW(15.0))
            make.height.equalTo(adaptW(20.0))
            make.width.equalTo(commentBt)
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
    }
    
    @objc func clickComment(_ sender: UIButton) {
        delegate?.bView(self, didClickComment: sender)
    }
    
    @objc func clickLike(_ sender: UIButton) {
        delegate?.bView(self, didClickLike: sender)
    }
}
