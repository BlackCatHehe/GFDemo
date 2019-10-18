//
//  GCCommunityDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCCommunityDetailVC: GCBaseVC {

    //MARK: --------cycleLife-----------
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    //MARK: --------lazyload-----------
    private lazy var headerV: GCCommunityHeaderView = {
        let v = GCCommunityHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: adaptW(185.0)))
        return v
    }()
}

extension GCCommunityDetailVC {
    
    private func initUI() {
        
        initContentView()
    }
    
    private func initContentView() {
        
        let vc = GCTieziVC()
        vc.tableHeaderV = headerV
        headerV.delegate = self
        headerV.setModel()
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension GCCommunityDetailVC: GCCommunityHeaderViewDelegate {
    
    func headerView(_ headerV: GCCommunityHeaderView, didClickBack button: UIButton) {
        self.dismissOrPop()
    }
}
