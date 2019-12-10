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
import SwiftyJSON

class GCPostTieziVC: GCBaseVC {
    
    var communiteId: String!
    
    private var selectedGoods: GCGoodsModel?
    private var selectedImgs: [UIImage]?
    private var selectedVideo: String?
    
    private var associaGoodsListVC: GCAssociationGoodsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initPostBt()
        initNotification()
    }
    
    @IBAction func addAssoGoods(_ sender: UIButton) {
        let vc = GCAssociationGoodsList()
        
        associaGoodsListVC = vc
        
        vc.clickChoose = {[weak self]goods in
            self?.selectedGoods = goods
            
            self?.assGoodsView.isHidden = goods == nil
            self?.assGoodsBt.isHidden = goods != nil
            self?.assGoodsView.goodsTitle = goods?.name
        }
        
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
    
    private lazy var assGoodsView: GCAssociaGoodsView = {
       let v = GCAssociaGoodsView()
        v.layer.cornerRadius = adaptW(15.0)
        v.layer.masksToBounds = true
        v.isHidden = true
        return v
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
        contentTV.minHeight = adaptW(150.0)
        contentTV.maxHeight = adaptW(300.0)
        
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
        
        //关联商品视图
        view.addSubview(assGoodsView)
        assGoodsView.clickTag = {[unowned self] in
            self.push(self.associaGoodsListVC!)
        }
        assGoodsView.snp.makeConstraints { (make) in
            make.left.equalTo(assGoodsBt)
            make.height.equalTo(adaptW(30.0))
            make.width.lessThanOrEqualTo(adaptW(150.0))
            make.centerY.equalTo(assGoodsBt)
        }
    }
    
    private func initPostBt(){
        
        let customItem = UIBarButtonItem(customView: postBt)
        self.navigationItem.rightBarButtonItem = customItem
        
        postBt.rx.tap
            .bind{[weak self] in
                self?.requestPost()
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
        present(alertVC, animated: true, completion: nil)
    }
    
}

extension GCPostTieziVC: HXPhotoViewDelegate {
    
    func photoView(_ photoView: HXPhotoView!, updateFrame frame: CGRect) {
        
        picHeight.constant = frame.size.height + adaptW(5.0)
    }
    
    func photoListViewControllerDidDone(_ photoView: HXPhotoView!, allList: [HXPhotoModel]!, photos: [HXPhotoModel]!, videos: [HXPhotoModel]!, original isOriginal: Bool) {
        
        self.toolManager.getSelectedImageList(photos, success: { (imgs) in
            self.selectedImgs = imgs
        }) {
            JYLog("得到图片失败了")
        }
        
    }
}

//MARK: ------------request------------

extension GCPostTieziVC {
    
    private func requestPost() {
        
        guard let title = titleTF.text, !title.isEmpty() else {
            showToast("请输入标题")
            return
        }
        guard let content = contentTV.text, !content.isEmpty() else {
            showToast("请输入内容")
            return
        }
        
        requestUpdateImage { (str) in
            
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
            var prama: [String: Any] = ["title": title,
                         "community_id": self.communiteId!,
                         "body": content
            ]
            if let imgPath = str {
                prama["cover"] = imgPath
                prama["images"] = imgPath
            }
            if let assGoodId = self.selectedGoods?.id {
                prama["ornament_id"] = assGoodId
            }
            
            GCNetTool.requestData(target: GCNetApi.postTopic(prama: prama), showAcvitity: true, success: { (result) in
                self.showToast("发布成功")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.dismissOrPop()
                }
            }) { (error) in
                JYLog(error)
            }
        }
    }
    
    private func requestUpdateImage( complete: @escaping ((String?)->())){
        guard let imgs = self.selectedImgs else {
            showToast("至少上传一张图片作为封面")
            complete(nil)
            return
        }
        
        let prama = ["type": "topics"]

        GCNetTool.requestData(target: GCNetApi.updateImg(prama: prama, images: imgs), showAcvitity: true, success: { (result) in
            
            let resultJson = JSON(result)
            if let path = resultJson["path"].string {
                complete(path)
            }
        }) { (error) in
            JYLog(error)
        }
        
    }
}
