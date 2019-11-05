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
import SwiftyJSON
class GCCreateCommuniteVC: GCBaseVC {

    private var imgPath: String?
    
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
    
    private lazy var createBt: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: adaptW(70.0), height: adaptW(30.0)))
        button.setTitle("创建", for: .normal)
        button.titleLabel?.font = kFont(adaptW(14.0))
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MetricGlobal.mainBlue
        button.layer.cornerRadius = adaptW(15.0)
        button.layer.masksToBounds = true
        return button
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
        
        imageV.kfSetImage(
            url: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
            targetSize: CGSize(width: adaptW(90.0), height: adaptW(90.0)),
            cornerRadius: adaptW(14.0)
        )
        
        let customItem = UIBarButtonItem(customView: createBt)
        self.navigationItem.rightBarButtonItem = customItem
        createBt.rx.tap
            .bind{[weak self] in
                
                self?.requestCreateCommunite()
        }.disposed(by: rx.disposeBag)
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
                            self.requestUpdateImage(image: images?.first)
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
                self.requestUpdateImage(image: images?.first)
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

extension GCCreateCommuniteVC {
    
    private func requestUpdateImage(image: UIImage?){
        guard let img = image else {return}
        
        let prama = ["type": "communities"]
        /**
         {
         "id" : 3,
         "user_id" : 2,
         "type" : "communities",
         "created_at" : "2019-10-30 05:39:30",
         "updated_at" : "2019-10-30 05:39:30",
         "path" : "http:\/\/res.uioj.com\/images\/apiUpload\/\/2019\/10\/e38UuOZ6oZMkD1LNc0ZeI1oXiBBHjBeL9dmGuZi8.jpeg"
         }
         */
        GCNetTool.requestData(target: GCNetApi.updateImg(prama: prama, images: [img]), showAcvitity: true, success: { (result) in
            
            let resultJson = JSON(result)
            if let path = resultJson["path"].string {
                self.imgPath = path
            }
            
            
        }) { (error) in
            JYLog(error)
        }
        
    }
    
    private func requestCreateCommunite(){
        
        guard let imgPath = self.imgPath else{
            showToast("请选择社区图标")
            return
        }
        guard let name = nameTF.text else{
            showToast("请输入社区名称")
            return
        }
        guard let introduce = contentTV.text else{
            showToast("请输入社区介绍")
            return
        }
        
        /**
        {
            "isJoin" : false,
            "id" : 1,
            "created_at" : "2019-10-30 05:40:13",
            "updated_at" : "2019-10-30 05:40:13",
            "name" : "老年活动中心",
            "member_count" : null,
            "topic_count" : null,
            "cover" : "http:\/\/res.uioj.com\/images\/apiUpload\/\/2019\/10\/e38UuOZ6oZMkD1LNc0ZeI1oXiBBHjBeL9dmGuZi8.jpeg",
            "introduce" : "欢迎年轻人来照顾老年程序员们"
        }
        */
        let prama = ["name": name,
                     "cover": imgPath,
                     "introduce": introduce
                    ]
        GCNetTool.requestData(target: GCNetApi.createCommunite(prama: prama), showAcvitity: true, success: { (result) in
            
            self.showToast("创建成功!")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismissOrPop()
            }
    
        }) { (error) in
            JYLog(error)
        }
    }
}
