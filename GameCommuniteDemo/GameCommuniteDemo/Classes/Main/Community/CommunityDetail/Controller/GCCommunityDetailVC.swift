//
//  GCCommunityDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
class GCCommunityDetailVC: GCBaseVC {
    var communiteId: String?
    
    //社区的信息
    private var pageModel: GCCommuniteDetailModel?
    
    //MARK: --------cycleLife-----------
    override func viewDidLoad() {
        super.viewDidLoad()

        requestCommuniteDetail()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundColor(bgColor: .clear, shadowColor: .clear)
    }

    
    //MARK: --------lazyload-----------
    private lazy var headerV: GCCommunityHeaderView = {
        let v = GCCommunityHeaderView()
        return v
    }()
    
    private lazy var postBt: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "community_choosePicOrVideo"), for: .normal)
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
        vc.communiteId = String(self.pageModel!.id!)
        vc.tableHeaderV = headerV
        headerV.delegate = self
        headerV.setModel(self.pageModel!)
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
        vc.communiteId = String(self.pageModel!.id!)
        vc.title = index == 0 ? "发图文" : "发视频"
        push(vc)
    }
    
    func chooseView(_ view: GCSelectPicOrVideoView, didClickBack button: UIButton) {
        view.removeFromSuperview()
    }
    
}

//MARK: ------------request------------
extension GCCommunityDetailVC {
    
    private func requestCommuniteDetail() {
        
        /**

        */
        guard let communityId = communiteId else{return}
        GCNetTool.requestData(target: GCNetApi.communiteDetail(prama: String(communityId)), success: { (result) in
            
            let model = Mapper<GCCommuniteDetailModel>().map(JSON: result)
            self.pageModel = model
            
            self.initUI()
        }) { (error) in
            JYLog(error)
            
        }
        
    }
}
