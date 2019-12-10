//
//  GCValidateCodeVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SwiftyJSON
import KeychainAccess
import ObjectMapper
import NIMSDK

fileprivate struct Metric {
    static let codeTimeDown = "codeTimeDown"
    static let totalCount: Int = 60
}

class GCValidateCodeVC: GCBaseVC {

    var phoneNum: String?
    
    var verikey: String?
    
    private var timeCount: Int = Metric.totalCount
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var validateCodeView: GCValidateView!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var countDownLb: UILabel!
    
    @IBOutlet weak var tipLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        self.tipLb.text = nil

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startTimer()
    }
    
    deinit {
        JYLog("GCValidateCodeVC.deinit")
        JYGCDTimer.share.destoryTimer(withName: Metric.codeTimeDown)
    }
    
    //TODO: click
    
    @IBAction func clickOK(_ sender: Any) {
        
        requestValidateCode()
    }
}

extension GCValidateCodeVC {
    
    private func initUI() {
        bgView.backgroundColor = MetricGlobal.mainBgColor
        
        validateCodeView.backgroundColor = MetricGlobal.mainBgColor
        
        okButton.setTitle("确定", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius = adaptW(22.0)
        okButton.layer.masksToBounds = true
        okButton.backgroundColor = MetricGlobal.mainBlue
        
        countDownLb.textColor = .white
        countDownLb.font = kFont(13.0)
        
        tipLb.textColor = kRGB(r: 253, g: 228, b: 63)
        tipLb.font = kFont(13.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRePostCode))
        countDownLb.addGestureRecognizer(tap)
    }
    
    ///重新发送验证码
    @objc func tapRePostCode() {
        self.requestSendCode()
    }
    
    
    private func startTimer() {
        self.countDownLb.isUserInteractionEnabled = false
        
        JYGCDTimer.share.scheduledDispatchTimer(withName: Metric.codeTimeDown, timeInterval: 1, queue: .global(), repeats: true) {
            self.timeCount -= 1
            if self.timeCount <= 0 {
                self.timeCount = Metric.totalCount
                JYGCDTimer.share.destoryTimer(withName: Metric.codeTimeDown)
                DispatchQueue.main.async {
                    self.countDownLb.isUserInteractionEnabled = true
                    self.countDownLb.text = "重新获取"
                }
                return
            }
            DispatchQueue.main.async {
                self.countDownLb.text = "重新获取(\(self.timeCount)s)"
            }

        }
    }
}

extension GCValidateCodeVC {
    
    private func requestValidateCode() {
        
        guard let _ = Int(validateCodeView.validateCode), validateCodeView.validateCode.count == 4 else {
            showToast("请输入格式正确的验证码")
            return
        }
        
        let prama = [
            "verification_key": self.verikey!,
            "verification_code": validateCodeView.validateCode
        ]
        
        GCNetTool.requestData(target: GCNetApi.register(prama: prama), showAcvitity: true, success: { (result) in
            
        
            let userModel = Mapper<UserModel>().map(JSON: result)
            GCUserDefault.shareInstance.userInfo = userModel
        
            
            //云信自动登录
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.yunXinAutoLogin()
            }
            
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }) { (error) in
            JYLog(error)
        }
    }
    
    //重新发送验证码
    private func requestSendCode() {
        guard let phoneNum = phoneNum else {
            showToast("请输入正确的手机号")
            return
        }
        let prama = ["phone": phoneNum]
        
        GCNetTool.requestData(target: GCNetApi.sendCode(prama: prama), showAcvitity: true, success: { (result) in
            
            guard let veriKey = result["key"] as? String else {
                self.showToast("登录出错")
                return
            }
            
            self.verikey = veriKey
            self.startTimer()
            
        }) { (error) in
            JYLog(error)
        }
    }
}

