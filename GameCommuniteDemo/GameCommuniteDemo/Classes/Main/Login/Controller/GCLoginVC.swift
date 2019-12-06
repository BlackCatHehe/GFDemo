//
//  GCLoginVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCLoginVC: GCBaseVC {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var phoneBgV: UIView!
    
    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var prefixPhoneNumbt: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var sendCodeBt: UIButton!
    
    @IBOutlet weak var weixinLoginBt: UIButton!
    
    @IBOutlet weak var protocolBt: UIButton!
    
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

        initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    //MARK: -----------click------------
    
    @IBAction func clickChoosePrefixPhoneNum(_ sender: Any) {
        
        let vc = GCQuHaoVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func clickSendCode(_ sender: UIButton) {
        requestSendCode()
    }
    
    @IBAction func clickWeixinLogin(_ sender: UIButton) {
        
    }
    
    @IBAction func clickLookForProtocol(_ sender: UIButton) {
        
    }
    
    @IBAction func clickBack(_ sender: UIButton) {
        
        self.dismissOrPop()
    }
    
}

extension GCLoginVC {
    
    private func initUI() {
       
        bgView.backgroundColor = MetricGlobal.mainBgColor
        phoneBgV.backgroundColor = MetricGlobal.mainBgColor
        
        prefixPhoneNumbt.setTitleColor(.white, for: .normal)
        prefixPhoneNumbt.setImage(UIImage(named: "shop_jiantou_xia"), for: .normal)
        prefixPhoneNumbt.layoutButton(style: .Right, imageTitleSpace: 10.0)
        
        sendCodeBt.layer.cornerRadius = adaptW(22.0)
        sendCodeBt.layer.masksToBounds = true
        sendCodeBt.setTitleColor(.white, for: .normal)
        sendCodeBt.backgroundColor = MetricGlobal.mainBlue
        sendCodeBt.setTitle("发送验证码", for: .normal)
        
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
extension GCLoginVC {
    
    private func requestSendCode() {
        guard let phoneNum = phoneTF.text else {
            showToast("请输入正确的手机号")
            return
        }
        let prama = ["phone": phoneNum]
        
        GCNetTool.requestData(target: GCNetApi.sendCode(prama: prama), showAcvitity: true, success: { (result) in
            
            guard let veriKey = result["key"] as? String else {
                self.showToast("登录出错")
                return
            }
            
            let vc = GCValidateCodeVC()
            vc.verikey = veriKey
            vc.phoneNum = phoneNum
            self.push(vc)
            
        }) { (error) in
            JYLog(error)
        }
    }
    
}
