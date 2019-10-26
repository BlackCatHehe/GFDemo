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

        setBackgroundColor(bgColor: .clear, shadowColor: .clear)
        initUI()
    }
    
    //MARK: --------lazyload-----------
    private lazy var headerV: GCCommunityHeaderView = {
        let v = GCCommunityHeaderView()
        return v
    }()
    
    private lazy var postBt: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "community_choosePicOrVideo"), for: .normal)
        button.backgroundColor = MetricGlobal.mainBlue
        return button
    }()
    
    private lazy var chooseView: GCSelectPicOrVideoView = {
        let cView = GCSelectPicOrVideoView.loadFromNib()
        return cView
    }()
}

extension GCCommunityDetailVC {
    
    private func initUI() {
        
        initContentView()
        initPostBt()
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
    
    private func initPostBt() {
        view.addSubview(postBt)
        postBt.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-kBottomH - adaptW(50.0))
            make.right.equalToSuperview().offset(adaptW(-15.0))
            make.size.equalTo(CGSize(width: adaptW(48.0), height: adaptW(48.0)))
        }
        postBt.addTarget(self, action: #selector(clickPost), for: .touchUpInside)
    }
    
    @objc private func clickPost() {
        
        view.addSubview(chooseView)
        chooseView.delegate = self
        chooseView.frame = view.bounds
    }
}

extension GCCommunityDetailVC: GCCommunityHeaderViewDelegate {
    
    func headerView(_ headerV: GCCommunityHeaderView, didClickJoin button: UIButton) {
        let vc = GCCommuniteMemberListVC()
        push(vc)
    }
    
    func headerView(_ headerV: GCCommunityHeaderView, didClickBack button: UIButton) {
        self.dismissOrPop()
    }
}

extension GCCommunityDetailVC: GCSelectPicOrVideoViewDelegate {
    
    func chooseView(_ view: GCSelectPicOrVideoView, didSelectAt index: Int) {
        view.removeFromSuperview()
        
        let vc = GCPostTieziVC()
        vc.title = index == 0 ? "发图文" : "发视频"
        push(vc)
    }
    
    func chooseView(_ view: GCSelectPicOrVideoView, didClickBack button: UIButton) {
        view.removeFromSuperview()
    }
    
}
