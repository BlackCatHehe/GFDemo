//
//  GCPostCommentVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPostCommentVC: GCBaseVC {

    private lazy var commentView: GCPostCommentView = {
        let cView = GCPostCommentView()
        return cView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        
        initUI()
    }
}

extension GCPostCommentVC {
    
    private func initUI(){
        
        commentView.setModel()
        view.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        commentView.clickPostButton = {
            
        }
    }
}
