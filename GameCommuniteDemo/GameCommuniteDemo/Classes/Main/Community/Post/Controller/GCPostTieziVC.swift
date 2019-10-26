//
//  GCPostTieziVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import GrowingTextView
import HXPhotoPicker
class GCPostTieziVC: GCBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initPostBt()
        initNotification()
    }
    
    @IBAction func addAssoGoods(_ sender: UIButton) {
        let vc = GCAssociationGoodsList()
        push(vc)
    }
    
    
    @IBOutlet weak var titleBgView: UIView!
    
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var contentBgView: UIView!
    
    @IBOutlet weak var contentTV: GrowingTextView!
    
    @IBOutlet weak var picBgView: UIView!
    
    @IBOutlet weak var assBgView: UIView!
    
    @IBOutlet weak var assGoodsBt: UIButton!
    
    @IBOutlet weak var picHeight: NSLayoutConstraint!
    
    private lazy var photoManager: HXPhotoManager? = {
        let manager = HXPhotoManager(type: .photoAndVideo)
        manager?.configuration.openCamera = true
        manager?.configuration.saveSystemAblum = true
        manager?.configuration.themeColor = .blue
        manager?.configuration.singleSelected = false
        manager?.configuration.photoMaxNum = 9
        manager?.configuration.videoMaxNum = 1
        manager?.configuration.rowCount = 3
        return manager
    }()
    
    private lazy var toolManager: HXDatePhotoToolManager = {
        let tool = HXDatePhotoToolManager()
        return tool
    }()
    
    private lazy var photoView: HXPhotoView? = {[weak self] in
        let pV = HXPhotoView(manager: self?.photoManager)
        pV?.hideDeleteButton = true
        pV?.outerCamera = true
        pV?.previewShowDeleteButton = true
        pV?.showAddCell = true
        pV?.backgroundColor = MetricGlobal.mainCellBgColor
        pV?.delegate = self
        return pV
        }()
    
    private lazy var postBt: UIButton = {
           let button = UIButton(frame: CGRect(x: 0, y: 0, width: adaptW(70.0), height: adaptW(30.0)))
           button.setTitle("发表", for: .normal)
           button.titleLabel?.font = kFont(adaptW(14.0))
           button.setTitleColor(.white, for: .normal)
           button.backgroundColor = MetricGlobal.mainBlue
           button.layer.cornerRadius = adaptW(15.0)
           button.layer.masksToBounds = true
           return button
       }()
}

extension GCPostTieziVC {
    
    private func initUI(){
        //XibUI
        titleBgView.backgroundColor = MetricGlobal.mainCellBgColor
        contentBgView.backgroundColor = MetricGlobal.mainCellBgColor
        picBgView.backgroundColor = MetricGlobal.mainCellBgColor
        assBgView.backgroundColor = MetricGlobal.mainCellBgColor
        contentTV.backgroundColor = MetricGlobal.mainCellBgColor
        
        titleTF.attributedPlaceholder = "为你的帖子写个标题(必填)".jys.add(kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)).add(UIColor.white).base
        titleTF.textColor = .white
        titleTF.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        
        contentTV.placeholder = "分享你的内容"
        contentTV.placeholderColor = kRGB(r: 128, g: 126, b: 184)
        contentTV.textColor = .white
        contentTV.font = kFont(adaptW(14.0))
        
        
        //选择图片视频
        guard let photoV = self.photoView else {return}
        
        picBgView.addSubview(photoV)
        photoV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(5.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(56.0))
            make.bottom.equalToSuperview()
        }
        photoV.collectionView.reloadData()
    }
    
    private func initPostBt(){
        
        let customItem = UIBarButtonItem(customView: postBt)
        self.navigationItem.rightBarButtonItem = customItem
        
        postBt.rx.tap
            .bind{[weak self] in
                
        }.disposed(by: rx.disposeBag)
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(chooseItemNoti(_:)), name: NSNotification.Name(rawValue: "ChooseItemNoti"), object: nil)
    }
    
    @objc private func chooseItemNoti(_ noti: Notification) {
        
        let alertVC = GCAlertController()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(58.0*3 + 1.0 + 7.0) - kBottomH, width: kScreenW, height: adaptW(58.0*3 + 1.0 + 7.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC

        alertVC.clickChoose = {[weak self] index in
            index == 0 ? self?.photoView?.goCameraViewController() : self?.photoView?.directGoController()
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

extension GCPostTieziVC: HXPhotoViewDelegate {
    
    func photoView(_ photoView: HXPhotoView!, updateFrame frame: CGRect) {
        
        picHeight.constant = frame.size.height + adaptW(5.0)
    }
    
    
}
