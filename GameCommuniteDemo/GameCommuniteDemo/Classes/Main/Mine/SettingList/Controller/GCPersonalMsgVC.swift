//
//  GCPersonalMsgVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher

class GCPersonalMsgVC: GCBaseVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "个人信息"
        
        initUI()
        
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
    
}

extension GCPersonalMsgVC {
    
    private func initUI(){
        
        //placeholer
        nameTF.attributedPlaceholder = "请填写昵称".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        let placeHolder = "选填".jys.add(kFont(adaptW(15.0))).add(kRGB(r: 165, g: 164, b: 192)).base
        sexTF.attributedPlaceholder = placeHolder
        birthTF.attributedPlaceholder = placeHolder
        emailTF.attributedPlaceholder = placeHolder
        eduTF.attributedPlaceholder = placeHolder
        jobTF.attributedPlaceholder = placeHolder
        
        //保存按钮
        let rightbarItem = UIBarButtonItem(customView: okButton)
        self.navigationItem.rightBarButtonItem = rightbarItem
        okButton.rx.tap
            .bind{[weak self] in
                self?.dismissOrPop()
        }.disposed(by: rx.disposeBag)
        
        iconImgV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(20.0), targetSize: CGSize(width: adaptW(40.0), height: adaptW(40.0)), roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
    }
}
