//
//  GCFeedBackVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCFeedBackVC: GCBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "意见反馈"
        initUI()
        
    }
    
    private lazy var feedbackView: GCFeedBackView = {
        let v = GCFeedBackView()
        return v
    }()
    
}

extension GCFeedBackVC {
    
    private func initUI(){
        view.addSubview(feedbackView)
        feedbackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
        }
    }
}

extension GCFeedBackVC {
    
    private func requestPost() {
        
        guard let text = feedbackView.contentTV.text, !text.isEmpty() else {
            showToast("反馈内容不能为空")
            return
        }
        
        let prama = ["content" : text]
        
        GCNetTool.requestData(target: GCNetApi.feedback(prama: prama), controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            
            self.showToast("反馈成功")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.dismissOrPop()
            }
            
        }) { (error) in
            JYLog(error)
        }
    }
}
