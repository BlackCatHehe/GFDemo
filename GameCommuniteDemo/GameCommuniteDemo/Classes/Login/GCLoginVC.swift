//
//  GCLoginVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCLoginVC: GCBaseVC {

    
    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var prefixPhoneNumbt: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var sendCodeBt: UIButton!
    
    @IBOutlet weak var weixinLoginBt: UIButton!
    
    @IBOutlet weak var protocolBt: UIButton!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    //MARK: -----------click------------
    
    @IBAction func clickChoosePrefixPhoneNum(_ sender: Any) {
        
        
    }
    
    @IBAction func clickSendCode(_ sender: UIButton) {
        
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
        prefixPhoneNumbt.setTitleColor(.white, for: .normal)
        
        phoneTF.clearButtonMode = .whileEditing
        phoneTF.attributedPlaceholder = "请输入手机号".jys.add(kFont(adaptW(17.0))).add(kRGB(r: 193, g: 191, b: 255)).base
        let input = phoneTF.rx.text.orEmpty.asDriver().throttle(0.3)
        
        input.map{RegularExpressionTool.isPhoneNumber(phoneNumber: $0)}
            .drive(sendCodeBt.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
    }
}
