//
//  GCPostGoodsVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import HXPhotoPicker
import GrowingTextView
import SwiftyJSON


//*************** 根据设计图 该页面已弃用   使用GCPostNewGoodsVC代替**********
 




fileprivate struct Metric {
    static let imgMargin: CGFloat = (kScreenW - adaptW(80.0)*3)/3
    static let placeholderColor: UIColor = kRGB(r: 164, g: 164, b: 192)
}

class GCPostGoodsVC: GCBaseVC {

    private var selectedImages: [UIImage]?
    
    //MARK: ------------cycleLife------------
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "发布商品"
        initUI()
        initPicView()
        initNotification()
    }
    
    //MARK: ------------lazyload------------
    private lazy var photoManager: HXPhotoManager? = {
        let manager = HXPhotoManager(type: .photo)
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
        pV?.addImageName = "post_camera"
        pV?.backgroundColor = MetricGlobal.mainCellBgColor
        pV?.delegate = self
        return pV
        }()
    
    //MARK: ------------xib click------------
    @IBAction func clickChoosetype(_ sender: UITapGestureRecognizer) {
        
        
    }
    
    @IBAction func clickPost(_ sender: UIButton) {
        
        self.requestPost()
        
    }
    
    //MARK: ------------xib views------------
    @IBOutlet weak var topBgView: UIView!
    
    @IBOutlet weak var selectedPicBgView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var detailTextV: GrowingTextView!
    
    @IBOutlet weak var goodsDetailBgView: UIView!
    
    @IBOutlet weak var optionsBgView: UIView!
    
    @IBOutlet weak var goodsNameTF: UITextField!
    
    @IBOutlet weak var salePriceTF: UITextField!
    
    @IBOutlet weak var originPriceTF: UITextField!
    
    @IBOutlet weak var resNumTF: UITextField!
    
    @IBOutlet weak var typeLb: UILabel!
    
    @IBOutlet weak var postbt: UIButton!
    
    @IBOutlet weak var selPicViewHConstrait: NSLayoutConstraint!
}

extension GCPostGoodsVC {
    
    private func initUI(){
        
        topBgView.backgroundColor = MetricGlobal.mainCellBgColor
        goodsDetailBgView.backgroundColor = MetricGlobal.mainCellBgColor
        optionsBgView.backgroundColor = MetricGlobal.mainCellBgColor
        
        detailTextV.backgroundColor = MetricGlobal.mainCellBgColor
        detailTextV.placeholder = "请输入商品详情，如装备参数、射速等用途"
        detailTextV.placeholderColor = Metric.placeholderColor
        detailTextV.textColor = .white
        detailTextV.minHeight = adaptW(72.0)
        
        addButton.contentEdgeInsets = UIEdgeInsets(top: adaptW(15.0), left: 0, bottom: adaptW(15.0), right: 0)
        addButton.layoutButton(style: .Top, imageTitleSpace: 5.0)
        
        //placeholer
        goodsNameTF.attributedPlaceholder = "请填写商品名称".jys.add(kFont(adaptW(15.0))).add(Metric.placeholderColor).base
        salePriceTF.attributedPlaceholder = "请填写售价".jys.add(kFont(adaptW(15.0))).add(Metric.placeholderColor).base
        originPriceTF.attributedPlaceholder = "请填写原价".jys.add(kFont(adaptW(15.0))).add(Metric.placeholderColor).base
        resNumTF.attributedPlaceholder = "请填写库存".jys.add(kFont(adaptW(15.0))).add(Metric.placeholderColor).base
        
        postbt.layer.cornerRadius = adaptW(22.0)
        postbt.layer.masksToBounds = true
        
        
    }
    
    private func initPicView() {
        //选择图片视频
        guard let photoV = self.photoView else {return}
        
        selectedPicBgView.addSubview(photoV)
        photoV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(5.0))
            make.left.equalToSuperview().offset(Metric.imgMargin)
            make.right.equalToSuperview().offset(-Metric.imgMargin)
            make.bottom.equalToSuperview()
        }
        photoV.collectionView.reloadData()
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectedImage(_:)), name: NSNotification.Name(rawValue: "ChooseItemNoti"), object: nil)
    }
    
    @objc func didSelectedImage(_ noti: Notification) {
        
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

//MARK: ------------HXPhotoViewDelegate------------
extension GCPostGoodsVC: HXPhotoViewDelegate {
    
    func photoView(_ photoView: HXPhotoView!, updateFrame frame: CGRect) {
        
        selPicViewHConstrait.constant = frame.size.height + adaptW(5.0)
    }
    
    func photoListViewControllerDidDone(_ photoView: HXPhotoView!, allList: [HXPhotoModel]!, photos: [HXPhotoModel]!, videos: [HXPhotoModel]!, original isOriginal: Bool) {
        
        self.toolManager.getSelectedImageList(photos, success: { (imgs) in
            self.selectedImages = imgs
        }) {
            JYLog("得到图片失败了")
        }
        
    }
}

//MARK: ------------request------------
extension GCPostGoodsVC {
    
    private func requestPost() {
        
        guard let images = selectedImages, images.count > 0 else {
            showToast("请选择选择图片")
            return
        }
        guard let goodsDetail = detailTextV.text, !goodsDetail.isEmpty() else {
            showToast("请输入商品详情")
            return
        }
        guard let goodsName = goodsNameTF.text, !goodsName.isEmpty() else {
            showToast("请输入商品名称")
            return
        }
        guard let goodsPrice = salePriceTF.text, !goodsPrice.isEmpty() else {
            showToast("请输入商品售价")
            return
        }
        guard let originPrice = originPriceTF.text, !originPrice.isEmpty() else {
            showToast("请输入商品原价")
            return
        }
        guard let repoNum = resNumTF.text, !repoNum.isEmpty() else {
            showToast("请输入商品库存")
            return
        }
        guard let num = Int(repoNum) else {
            showToast("库存必须为数字")
            return
        }
        guard num > 0 else {
            showToast("库存不能小于1")
            return
        }
        
        requestUpdateImage(image: images) { (str) in

            let prama = ["category_id": 1,
                         "name": goodsName,
                         "cover": str,
                         "content": goodsDetail,
                         "original_price": originPrice,
                         "price": goodsPrice,
                         "stock": num,
                         "images": str,
                ] as [String : Any]
            JYLog(JSON(prama).description)
            GCNetTool.requestData(target: GCNetApi.goodsPost(prama: prama), showAcvitity: true, success: { (result) in
                

            }) { (error) in
                JYLog(error)
            }
        }
    }
    
    private func requestUpdateImage(image: [UIImage], complete: @escaping ((String)->())){
        
        let prama = ["type": "ornaments"]
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
        GCNetTool.requestData(target: GCNetApi.updateImg(prama: prama, images: image), showAcvitity: true, success: { (result) in
            
            let resultJson = JSON(result)
            if let path = resultJson["path"].string {
                complete(path)
            }
        }) { (error) in
            JYLog(error)
        }
        
    }
    
}
