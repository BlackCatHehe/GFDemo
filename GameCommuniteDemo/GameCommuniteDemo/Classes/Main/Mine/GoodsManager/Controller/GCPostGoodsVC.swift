//
//  GCPostGoodsVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPostGoodsVC: GCBaseVC {

    private var images: [UIImage] = []
    
    @IBOutlet weak var selectedPicBgView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var detailTextV: UITextView!
    
    @IBOutlet weak var goodsNameTF: UITextField!
    
    @IBOutlet weak var salePriceTF: UITextField!
    
    @IBOutlet weak var originPriceTF: UITextField!
    
    @IBOutlet weak var resNumTF: UITextField!
    
    @IBOutlet weak var typeLb: UILabel!
    
    private var picsView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "发布商品"
        initUI()
        initNotification()
    }
    
    @IBAction func clickChoosePic(_ sender: UIButton) {
        
        if let picV = picsView {
            
        }else {
            let vc = Demo2ViewController()
            addChild(vc)
            selectedPicBgView.addSubview(vc.view)
            vc.view.backgroundColor = MetricGlobal.mainCellBgColor
            vc.view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
    }
    
    @IBAction func clickChoosetype(_ sender: UITapGestureRecognizer) {
        
        
    }
    
}

extension GCPostGoodsVC {
    
    private func initUI(){
        addButton.contentEdgeInsets = UIEdgeInsets(top: adaptW(15.0), left: 0, bottom: adaptW(15.0), right: 0)
        addButton.layoutButton(style: .Top, imageTitleSpace: 5.0)
        
        //placeholer
        goodsNameTF.attributedPlaceholder = "请填写商品名称".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        salePriceTF.attributedPlaceholder = "请填写售价".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        originPriceTF.attributedPlaceholder = "请填写原价".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        resNumTF.attributedPlaceholder = "请填写库存".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        
        
        //选择图片后显示9图片view
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectedImage(_:)), name: NSNotification.Name(rawValue: "SelectedPics"), object: nil)
    }
    
    @objc func didSelectedImage(_ noti: Notification) {
        if let imageList = noti.object as? [UIImage] {
            images = imageList
            
//            if self.bgViewConstraintH.constant == adaptW(520.0) {
//                if self.images.count < 6 {
//                    self.bgViewConstraintH.constant = adaptW(400.0)
//                    view.layoutIfNeeded()
//                }
//            }else {
//                if self.images.count >= 6 {
//                    self.bgViewConstraintH.constant = adaptW(520.0)
//                    view.layoutIfNeeded()
//                }
//            }
//            
        }else {
            showToast("获取图片失败,请重试")
        }
    }
}
