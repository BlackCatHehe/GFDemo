//
//  GCPayResultVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPayResultVC: GCBaseVC {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var leftbt: UIButton!
    @IBOutlet weak var rightBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        let okItem = JYNavigationComponentss.title(title: "完成").type
        self.componentInstall(with: okItem) { (model) in
            self.dismissOrPop()
        }
    }
    
    @IBAction func clickLeftBt(_ sender: UIButton) {
        let vc = GCPostCommentVC()
        push(vc)
    }
    
    @IBAction func clickRightBt(_ sender: UIButton) {
        
    }
    
}

extension GCPayResultVC {
    
    private func initUI() {
        
        bgView.backgroundColor = MetricGlobal.mainBgColor
        
        titleLb.font = kFont(adaptW(20.0), MetricGlobal.mainMediumFamily)
        titleLb.textAlignment = .center
        
        subTitle.font = kFont(adaptW(14.0))
        subTitle.numberOfLines = 2
        subTitle.textAlignment = .center
        subTitle.preferredMaxLayoutWidth = adaptW(200.0)
        
        leftbt.backgroundColor = MetricGlobal.mainBlue
        leftbt.setTitle("查看订单", for: .normal)
        
        rightBt.backgroundColor = kRGB(r: 255, g: 45, b: 90)
        rightBt.setTitle("继续逛逛", for: .normal)
        
        
        titleLb.text = "¥100.0"
        subTitle.text = "恭喜本次交易获得0.50ETH，下次交易可以直接抵扣"
        
    }
    
    
    
}
