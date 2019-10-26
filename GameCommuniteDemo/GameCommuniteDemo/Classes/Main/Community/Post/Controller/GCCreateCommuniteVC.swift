//
//  GCCreateCommuniteVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/25.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import GrowingTextView
import Kingfisher
import HXPhotoPicker
class GCCreateCommuniteVC: GCBaseVC {

    private var selectedImg: UIImage?
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var contentTV: GrowingTextView!
    
    @IBOutlet weak var coyntNumLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "创建社区"
        initUI()
    
    }
    
    @IBAction func tapChoose(_ sender: UITapGestureRecognizer) {
        
        self.chooseImg()
    }
    
    
    private lazy var photoManager: HXPhotoManager? = {
        let manager = HXPhotoManager(type: .photo)
        manager?.configuration.openCamera = true
        manager?.configuration.saveSystemAblum = true
        manager?.configuration.themeColor = .blue
        manager?.configuration.singleSelected = true
        return manager
    }()
    
    private lazy var toolManager: HXDatePhotoToolManager = {
        let tool = HXDatePhotoToolManager()
        return tool
    }()
    
    
}

extension GCCreateCommuniteVC {
    
    private func initUI(){
        
        view.backgroundColor = MetricGlobal.mainBgColor
        lineView.backgroundColor = MetricGlobal.mainBgColor
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        nameTF.backgroundColor = MetricGlobal.mainCellBgColor
        contentTV.backgroundColor = MetricGlobal.mainCellBgColor
        
        nameTF.attributedPlaceholder = "社区名称".jys.add(UIColor.white).add(kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)).base
        nameTF.textColor = .white
        nameTF.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        
        contentTV.placeholder = "社区介绍"
        contentTV.placeholderColor = kRGB(r: 128, g: 126, b: 184)
        contentTV.font = kFont(adaptW(14.0))
        contentTV.textColor = kRGB(r: 128, g: 126, b: 184)
        contentTV.maxLength = 300
        contentTV.delegate = self
        
        coyntNumLb.text = "0/300"
        
        imageV.contentMode = .scaleAspectFill
        imageV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(14.0), targetSize: CGSize(width: adaptW(90.0), height: adaptW(90.0)), roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
    }
    
    private func chooseImg(){
        
        let alertVC = GCAlertController()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(58.0*3 + 1.0 + 7.0) - kBottomH, width: kScreenW, height: adaptW(58.0*3 + 1.0 + 7.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC

        alertVC.clickChoose = {[weak self] index in
            index == 0 ? self?.openCamera() : self?.openAlbum()
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
    
    private func openCamera() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.showToast("此设备不支持相机!")
                    return
                }
                let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
                if authStatus == .restricted || authStatus == .denied {
                    self.showToast("请在设置-隐私-相机中允许访问相机!")
                    return
                }
                
                self.hx_presentCustomCameraViewController(with: self.photoManager, done: { (photo, vc) in
                    JYLog("选择了")
                    if photo != nil {
                        self.toolManager.getSelectedImageList([photo!], success: { (images) in
                            self.selectedImg = images?.first
                            self.imageV.image = self.selectedImg
                            JYLog("获取到的图片为:\(images)")
                        }, failed: {
                            JYLog("得到图片失败了")
                        })
                    }
        
                }, cancel: { (vc) in
                    JYLog("取消了")
                })
    }
    
    private func openAlbum() {
        self.hx_presentSelectPhotoController(with: self.photoManager, didDone: { (models, _, photos, isOrign, vc, manager) in
            JYLog("选择了图片")
            self.toolManager.getSelectedImageList(models, success: { (images) in
                JYLog("获取到的图片为:\(images)")
                self.selectedImg = images?.first
                self.imageV.image = self.selectedImg

            }, failed: {
                JYLog("得到图片失败了")
            })
            
        }, cancel: { (vc, manager) in
            JYLog("ok")
        })
    }
}

extension GCCreateCommuniteVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.coyntNumLb.text = "\(textView.text.count)/300"
    }
}
