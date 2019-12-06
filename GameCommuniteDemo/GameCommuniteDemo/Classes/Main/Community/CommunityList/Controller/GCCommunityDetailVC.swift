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

    deinit {
        if JYGCDTimer.share.isExistTimer(withName: "scrollBanner") {
            JYGCDTimer.share.destoryTimer(withName: "scrollBanner")
        }
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
        if let isJoin = self.pageModel?.isJoin {
            postBt.isHidden = !isJoin
        }
        
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
    
    ///弹出退出社区
     private func tapExitCommunite(){
         let alertVC = GCAlertController()
         
         let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
         preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(58.0*2 + 1.0 + 7.0) - kBottomH, width: kScreenW, height: adaptW(58.0*2 + 1.0 + 7.0))
         alertVC.modalPresentationStyle = .custom
         alertVC.transitioningDelegate = preAniVC
         alertVC.secondTitle = "退出社区"
         alertVC.isSingle = true
         alertVC.clickChoose = {[weak self] index in
             if index == 1 {
                self?.requestExitCommunite()
             }
         }
         
         present(alertVC, animated: true, completion: nil)
     }
}

extension GCCommunityDetailVC: GCCommunityHeaderViewDelegate {
    
    func headerViewDidTapEnterMemberList(_ headerV: GCCommunityHeaderView) {
        let vc = GCCommuniteMemberListVC()
        vc.communityId = communiteId
        push(vc)
    }
    
    func headerView(_ headerV: GCCommunityHeaderView, didClickJoin button: UIButton) {
        let isJoin = pageModel?.isJoin ?? false
        
        isJoin == true ? tapExitCommunite() : requestAddCommunite()
        
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
    
    ///请求社区详情和置顶信息
    private func requestCommuniteDetail() {
        
        guard let communityId = communiteId else{return}
        GCNetTool.requestData(target: GCNetApi.communiteDetail(prama: String(communityId)), success: { (result) in
            
            let model = Mapper<GCCommuniteDetailModel>().map(JSON: result)
            self.pageModel = model
            
            self.initUI()
        }) { (error) in
            JYLog(error)
            
        }
    }
    
    
    ///请求加入社团
    private func requestAddCommunite() {

        guard let cId = self.communiteId else{return}
        GCNetTool.requestData(target: GCNetApi.joinCommunite(prama: cId), success: { (result) in
            
            if let msg = result["message"] as? String {
                self.showToast(msg)
   
            }

        }) { (error) in
            JYLog(error)
            
        }
    }
    ///请求退出社团
     private func requestExitCommunite() {

         guard let cId = self.communiteId else{return}
         GCNetTool.requestData(target: GCNetApi.exitCommunite(prama: cId), success: { (result) in
             
             if let msg = result["message"] as? String {
                 self.showToast(msg)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.dismissOrPop()
                }
             }

         }) { (error) in
             JYLog(error)
             
         }
     }
}
