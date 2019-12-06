//
//  GCArticalDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCArticalDetailVC: GCBaseVC {
    
    var pageModel: GCTopicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "战略技巧"
       // requestTopicDetail()
        
        initUI()
        
    }
    
    private lazy var contentV: GCTieziDetailView = {
        let v = GCTieziDetailView()
        return v
    }()
    
    private lazy var bottomV: GCArticalBottomView = {
        let bView = GCArticalBottomView()
        return bView
    }()

}

extension GCArticalDetailVC {
    
    private func initUI(){
        
        self.componentInstall(with: JYNavigationComponents.share) { (model) in
            self.clickShare()
        }
        
        view.addSubview(contentV)
        contentV.setModel(self.pageModel!)
        contentV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
        
        bottomV.delegate = self
        bottomV.setModel(self.pageModel!)
        view.addSubview(bottomV)
        bottomV.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
    }
    
    private func clickShare() {
        let alertVC = GCAlertShareCenterVC()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(241.0) - kBottomH, width: kScreenW, height: adaptW(241.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC

        alertVC.clickChoosePlatForm = {[weak self] index in
            switch index {
            case 0:
                JYLog("weixin")
            case 1:
                JYLog("pengyouquan")
            case 2:
                JYLog("xinlang")
            default:
                JYLog("qq")
            }
        }
        var rootVC = kWindow?.rootViewController
        while rootVC?.presentedViewController != nil {
            if let vc = rootVC?.presentedViewController {
                if let nvc = vc as? UINavigationController{
                    rootVC = nvc.visibleViewController
                }else if let tvc = vc as? UITabBarController{
                    rootVC = tvc.selectedViewController
                }
            }
            
        }
        rootVC?.present(alertVC, animated: true, completion: nil)
    }
    
}


extension GCArticalDetailVC: GCArticalBottomViewDelegate {
    
    func bViewDidClickPost(_ bottomView: GCArticalBottomView, text: String) {
        guard text.isEmpty() == false else {
            showToast("输入不能为空")
            return
        }
        requestPostComment(content: text)
    }
    
    func bView(_ bottomView: GCArticalBottomView, didClickComment button: UIButton) {
        let alertVC = GCAlertCommentVC()
        guard let tId = pageModel?.id else {
            showToast("参数错误")
            return
        }
        alertVC.topicId = tId
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(477.0), width: kScreenW, height: adaptW(477.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC

        present(alertVC, animated: true, completion: nil)
    }
    
    func bView(_ bottomView: GCArticalBottomView, didClickLike button: UIButton) {

        if let isLike = pageModel?.isLike, let tId = pageModel?.id, let likeNum = pageModel?.likeCount {
            
            requestTopicZan(isZaned: isLike, tid: String(tId)) {[weak self] in
                self?.pageModel?.isLike = !isLike
                button.setTitle("\(isLike ? likeNum - 1 : likeNum + 1)", for: .normal)
                self?.pageModel?.likeCount = isLike ? likeNum - 1 : likeNum + 1
            }
        }
    }
    
    
}

extension GCArticalDetailVC {
    
    ///请求发起评论
    private func requestPostComment(content: String) {
        
        guard let topicId = pageModel?.id else {return}
        let prama: [String: Any] = [
            "topic_id": topicId,
            "content" : content
        ]
        GCNetTool.requestData(target: GCNetApi.postComment(prama: prama), controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            
            self.bottomV.clearMsg()
            
        }) { (error) in
            JYLog(error)
        }
    }
    
    ///话题(取消)点赞 isZaned表示点赞前是否已经是点赞的状态
    private func requestTopicZan(isZaned: Bool, tid: String, success: @escaping (()->())) {

        let target = isZaned ? GCNetApi.topicCancelZan(prama: tid) : GCNetApi.topicTapZan(prama: tid)
        
        GCNetTool.requestData(target: target, success: { (result) in
            success()
        }) { (error) in
            
        }
    }
    
//    //话题详情
//    private func requestTopicDetail() {
//
//        guard let tid = self.pageModel?.id else {return}
//        GCNetTool.requestData(target: GCNetApi.topicDetail(prama: String(tid)), success: { (result) in
//
//
//
//        }) { (error) in
//
//        }
//    }
}
