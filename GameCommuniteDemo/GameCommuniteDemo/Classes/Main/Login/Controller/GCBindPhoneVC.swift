//
//  GCBindPhoneVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCBindPhoneVC: GCBaseVC {

    var phoneNum: String?
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var phoneBgV: UIView!
    
    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var tipLb: UILabel!
    
    @IBOutlet weak var prefixPhoneNumbt: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var sendCodeBt: UIButton!
    
    private var isHui: Bool = false {
        didSet {
            if isHui {
                sendCodeBt.backgroundColor = .gray
                
            }else {
                sendCodeBt.backgroundColor = MetricGlobal.mainBlue
                
            }
            sendCodeBt.isEnabled = !isHui
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "绑定手机号"
        initUI()
    }
    
    @IBAction func clickOk(_ sender: UIButton) {
        //requestInfo()
    }

}

extension GCBindPhoneVC {
    
    private func initUI() {
       
        bgView.backgroundColor = MetricGlobal.mainBgColor
        phoneBgV.backgroundColor = MetricGlobal.mainBgColor
        
        tipLb.textColor = kRGB(r: 253, g: 228, b: 63)
        tipLb.text = "绑定手机号，账号更安全哦~"
        
        prefixPhoneNumbt.setTitleColor(.white, for: .normal)
        prefixPhoneNumbt.setImage(UIImage(named: "shop_jiantou_xia"), for: .normal)
        prefixPhoneNumbt.layoutButton(style: .Right, imageTitleSpace: 10.0)
        
        sendCodeBt.layer.cornerRadius = adaptW(22.0)
        sendCodeBt.layer.masksToBounds = true
        sendCodeBt.setTitleColor(.white, for: .normal)
        sendCodeBt.backgroundColor = MetricGlobal.mainBlue
        sendCodeBt.setTitle("确定", for: .normal)
        
        phoneTF.text = phoneNum
        phoneTF.rightViewMode = .whileEditing
        phoneTF.textColor = .white
        phoneTF.attributedPlaceholder = "请输入手机号".jys.add(kFont(adaptW(17.0))).add(kRGB(r: 193, g: 191, b: 255)).base
        let input = phoneTF.rx.text.orEmpty.asDriver().throttle(0.3)
        
        input.map{RegularExpressionTool.isPhoneNumber(phoneNumber: $0)}
            .drive(onNext: {[weak self] (isPass) in
                self?.isHui = !isPass
            }).disposed(by: rx.disposeBag)
    }
    
    
}

//MARK: ------------request------------
extension GCBindPhoneVC {
//    
//    private func requestInfo() {
//        let prama = ["phone": self.phoneNum!]
//        GCNetTool.requestData(target: GCNetApi.getUserInfo(prama: prama), showAcvitity: true, success: { (result) in
//                   
//                   
//                   
//               }) { (error) in
//                   JYLog(error)
//               }
//    }
}
