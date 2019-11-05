//
//  GCArticalDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCArticalDetailVC: GCBaseVC {

    var topicId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "战略技巧"
        requestTopicDetail()
        
        initUI()
        
    }
    
    private lazy var bottomV: GCArticalBottomView = {
        let bView = GCArticalBottomView()
        bView.setModel()
        return bView
    }()

}

extension GCArticalDetailVC {
    
    private func initUI(){
        
        self.componentInstall(with: JYNavigationComponents.share) { (model) in
            self.clickShare()
        }
        
        bottomV.delegate = self
        view.addSubview(bottomV)
        bottomV.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
    }
    
    private func clickShare() {
        let alertVC = GCAlertShareCenterVC()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(210.0) - kBottomH, width: kScreenW, height: adaptW(210.0))
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
    
    func bView(_ bottomView: GCArticalBottomView, didClickComment button: UIButton) {
        let alertVC = GCAlertCommentVC()
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(477.0) - kBottomH, width: kScreenW, height: adaptW(477.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC

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
    
    func bView(_ bottomView: GCArticalBottomView, didClickLike button: UIButton) {
        
    }
}

extension GCArticalDetailVC {
    
    //话题详情
    private func requestTopicDetail() {

        guard let tid = self.topicId else {return}
        GCNetTool.requestData(target: GCNetApi.topicDetail(prama: tid), success: { (result) in
            
        }) { (error) in
            
        }
    }
}
