//
//  GCPersonalMsgVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import HXPhotoPicker
import ObjectMapper

class GCPersonalMsgVC: GCBaseVC {

    private var selectedImg: UIImage? {
        didSet {
            iconImgV.image = selectedImg
        }
    }
    
    private var sex: Int?
    
    private var userModel: UserModel? {
        didSet {
            setModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "个人信息"
        
        initUI()
        
        requestUserInfo()
    }
    
    deinit {
        print("GCPersonalMsgVC.deinit")
    }
    
    private func setModel() {
        if let avatar = userModel?.avatar {
            iconImgV.kfSetImage(
                url: avatar,
                targetSize: CGSize(width: adaptW(40.0), height: adaptW(40.0)),
                cornerRadius: adaptW(20.0)
            )
        }
        nameTF.text = userModel?.name
        sexTF.text = userModel?.sex
        sex = userModel?.sex == "男" ? 0 : 1
        birthTF.text = userModel?.birthday
        emailTF.text = userModel?.email
        eduTF.text = userModel?.education
        jobTF.text = userModel?.profession
        
        
    }
    
    //MARK: ------------xib------------
    @IBOutlet weak var iconImgV: UIImageView!

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var sexTF: UITextField!
    
    @IBOutlet weak var birthTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var eduTF: UITextField!
    
    @IBOutlet weak var jobTF: UITextField!
    
    //MARK: ------------lazyload------------
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("保存", for: .normal)
        button.titleLabel?.font = kFont(adaptW(15.0))
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
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
    
    
    @IBAction func tapChooseImg(_ sender: UITapGestureRecognizer) {
        chooseImg()
    }
    
    @IBAction func tapChooseSex(_ sender: UITapGestureRecognizer) {
        let alertVC = GCAlertController()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(58*3 + 7 + 1) - kBottomH, width: kScreenW, height: adaptW(58*3 + 7 + 1))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC
        alertVC.firstTitle = "男"
        alertVC.secondTitle = "女"
        alertVC.clickChoose = {[weak self]index in
            self?.sex = index
            if index == 0 {
                self?.sexTF.text = "男"
            }else if index == 1 {
                self?.sexTF.text = "女"
            }
        }
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func tapChooseBir(_ sender: UITapGestureRecognizer) {
        
        let datepicker = JYDatePicker()
        datepicker.tapChoose = {date in
            self.birthTF.text = date
        }
        view.addSubview(datepicker)
        datepicker.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(adaptW(300.0))
        }
        
    }
    
}

extension GCPersonalMsgVC {
    
    private func initUI(){
        
        //placeholer
        nameTF.attributedPlaceholder = "请填写昵称".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        let placeHolder = "选填".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        emailTF.attributedPlaceholder = placeHolder
        eduTF.attributedPlaceholder = placeHolder
        jobTF.attributedPlaceholder = placeHolder
        
        //保存按钮
        let rightbarItem = UIBarButtonItem(customView: okButton)
        self.navigationItem.rightBarButtonItem = rightbarItem
        okButton.rx.tap
            .bind{[weak self] in
                self?.saveUserInfo()
        }.disposed(by: rx.disposeBag)

        
    }
    
    
    //TODO:   click
    ///保存
    private func saveUserInfo() {
        updateUserInfo()
    }
    
    
    ///选择图片
    private func chooseImg(){
        
        let alertVC = GCAlertController()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(58.0*3 + 1.0 + 7.0) - kBottomH, width: kScreenW, height: adaptW(58.0*3 + 1.0 + 7.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC
        
        alertVC.clickChoose = {[weak self] index in
            index == 0 ? self?.openCamera() : self?.openAlbum()
        }
        present(alertVC, animated: true, completion: nil)
    }
    
    ///打开相机
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
                    JYLog("获取到的图片为:\(images)")
                }, failed: {
                    JYLog("得到图片失败了")
                })
            }
            
        }, cancel: { (vc) in
            JYLog("取消了")
        })
    }
    ///打开相册
    private func openAlbum() {
        self.hx_presentSelectPhotoController(with: self.photoManager, didDone: { (models, _, photos, isOrign, vc, manager) in
            JYLog("选择了图片")
            self.toolManager.getSelectedImageList(models, success: { (images) in
                JYLog("获取到的图片为:\(images)")
                self.selectedImg = images?.first
            }, failed: {
                JYLog("得到图片失败了")
            })
            
        }, cancel: { (vc, manager) in
            JYLog("ok")
        })
    }
}


//MARK: ------------request------------
extension GCPersonalMsgVC {
    
    ///获取登录用户信息
    private func requestUserInfo() {
        guard let uId = GCUserDefault.shareInstance.userInfo?.id else {
            return
        }
        GCNetTool.requestData(target: GCNetApi.getUserInfo(uId: uId), controller: self, showAcvitity: true, success: { (result) in
            
            let model = Mapper<UserModel>().map(JSON: result)
            self.userModel = model
  
        }) { (error) in
            JYLog(error)
        }
        
    }
    
    
    ///修改用户信息
    private func updateUserInfo() {

        guard let name = nameTF.text, !name.isEmpty() else {
            showToast("请输入昵称")
            return
        }
        guard let sex = self.sex else {
            showToast("请选择性别")
            return
        }
        guard let birth = birthTF.text, !birth.isEmpty() else {
            showToast("请选择生日")
            return
        }
        
        requestUpdateImage {[weak self] (str) in
            
            guard let imgPath = str else {return}
            
            var prama: [String: Any] = ["name": name,
                         "avatar": imgPath,
                         "sex": sex,
                         "birthday": birth
            ]
            //后台接口没有加
            if let email = self?.emailTF.text, !email.isEmpty() {
                prama["email"] = email
            }
            if let edu = self?.eduTF.text, !edu.isEmpty() {
                prama["edu"] = edu
            }
            if let profession = self?.jobTF.text, !profession.isEmpty() {
                prama["profession"] = profession
            }
            
            JYLog(prama)
            GCNetTool.requestData(target: GCNetApi.updateUserInfo(prama: prama), showAcvitity: true, success: { (result) in
                
                self?.showToast("保存成功")
                
                //这里没有返回用户的meta信息，需要先拿到之前的信息再保存
                let model = Mapper<UserModel>().map(JSON: result)
                let oldUser = GCUserDefault.shareInstance.userInfo
                model?.meta = oldUser?.meta
                GCUserDefault.shareInstance.userInfo = model

            }) { (error) in
                JYLog(error)
            }
        }
    }
    
    private func requestUpdateImage( complete: @escaping ((String?)->())){
        guard let img = self.selectedImg else {
            complete(nil)
            return
        }
        
        let prama = ["type": "user"]

        GCNetTool.requestData(target: GCNetApi.updateImg(prama: prama, images: [img]), showAcvitity: true, success: { (result) in
            
            let resultJson = JSON(result)
            if let path = resultJson["path"].string {
                complete(path)
            }
        }) { (error) in
            JYLog(error)
        }
        
    }
}
