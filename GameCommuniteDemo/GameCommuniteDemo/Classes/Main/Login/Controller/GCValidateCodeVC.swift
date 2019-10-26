//
//  GCValidateCodeVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SwiftyJSON
fileprivate struct Metric {
    static let codeTimeDown = "codeTimeDown"
}

class GCValidateCodeVC: GCBaseVC {

    var phoneNum: String?
    
    var verikey: String?
    
    private var timeCount: Int = 10
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var validateCodeView: GCValidateView!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var countDownLb: UILabel!
    
    @IBOutlet weak var tipLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        startTimer()
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
        tipLb.text = "验证码错误，请重新输入！"
    }
    
    private func startTimer() {
        JYGCDTimer.share.scheduledDispatchTimer(withName: Metric.codeTimeDown, timeInterval: 10, queue: .main, repeats: true) {
            self.timeCount -= 1
            if self.timeCount <= 0 {
                self.timeCount = 10
                JYGCDTimer.share.destoryTimer(withName: Metric.codeTimeDown)
            }
            self.countDownLb.text = "重新获取(\(self.timeCount)s)"
        }
    }
}

extension GCValidateCodeVC {
    
    private func requestValidateCode() {
        
        guard let _ = Int(validateCodeView.validateCode), validateCodeView.validateCode.count == 4 else {
            showToast("请输入正确的验证码")
            return
        }
        
        let prama = [
            "verification_key": self.verikey!,
            "verification_code": validateCodeView.validateCode,
            "name": "test_2",
            "password": "123456"
        ]
        
        GCNetTool.requestData(target: GCNetApi.register(prama: prama), showAcvitity: true, success: { (result) in
            
            if let meta = result["meta"] as? [String:String], let token = meta["access_token"], let tokenType = meta["token_type"] {
                UserDefaults.standard.setValue(tokenType + "." + token, forKey: "access_token")
            }
            
            let vc = GCBindPhoneVC()
            vc.phoneNum = self.phoneNum
            self.push(vc)
            
        }) { (error) in
            JYLog(error)
        }
    }
    
}
