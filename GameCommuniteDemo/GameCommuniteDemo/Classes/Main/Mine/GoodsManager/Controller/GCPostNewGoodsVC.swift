//
//  GCPostNewGoodsVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPostNewGoodsVC: GCBaseVC {

    @IBOutlet var bgView: UIView!
    
    @IBOutlet var goodsImgV: UIImageView!
    
    @IBOutlet var goodsDescLb: UILabel!
    
    @IBOutlet var resNumLb: UILabel!
    
    @IBOutlet var saledLb: UILabel!
    
    @IBOutlet var bLineV: UIView!
    
    @IBOutlet var totalLb: UILabel!
    
    @IBOutlet weak var saleTF: UITextField!
    
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var sugesstionLb: UILabel!
    
    @IBOutlet weak var postBT: UIButton!
    
    @IBOutlet weak var pricebgView: UIView!
    
    @IBOutlet weak var sPriceBGView: UIView!
    
    private lazy var noOpenView: GCPostNoSteamView = {
        let v = GCPostNoSteamView(frame: .zero, title: "系统检测到您的steam未公开， 请前往公开后重新刷新此列表", buttonTitle: "前往公开")
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "发布商品"
        
        initUI()
        
        view.addSubview(self.noOpenView)
        noOpenView.tapOpen = {[weak self] in
            self?.setModel()
            self?.noOpenView.removeFromSuperview()
        }
        noOpenView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    
    @IBAction func clickPost(_ sender: UIButton) {
        
        
    }
    
    func setModel() {
        
        goodsImgV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"))
        
        goodsDescLb.text = "暗影战神129加噬魂12匕首 36洞满碎片加猛攻爪和耀眼 项链"
        resNumLb.text = "库存: 2370"
        saledLb.text = "已售: 32"
        totalLb.text = "¥230.00"
        
        sugesstionLb.text = "¥1200.00"
    }
    
}

extension GCPostNewGoodsVC {
    
    private func initUI(){
        
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.layer.cornerRadius = adaptW(5.0)
        bgView.layer.masksToBounds = true
        
        bLineV.backgroundColor = MetricGlobal.mainBgColor
        bottomLine.backgroundColor = MetricGlobal.mainBgColor
        
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.masksToBounds = true
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        goodsImgV.layer.borderWidth = 1.0
        goodsImgV.contentMode = .scaleAspectFill
        
        goodsDescLb.textColor = .white
        goodsDescLb.font = kFont(adaptW(14.0))
        goodsDescLb.numberOfLines = 2
        
        resNumLb.textColor = MetricGlobal.mainGray
        resNumLb.font = kFont(adaptW(13.0))
        
        saledLb.textColor = MetricGlobal.mainGray
        saledLb.font = kFont(adaptW(13.0))
        
        totalLb.textColor = .white
        totalLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        
        pricebgView.backgroundColor = MetricGlobal.mainCellBgColor
        sPriceBGView.backgroundColor = MetricGlobal.mainCellBgColor
        
        saleTF.attributedPlaceholder = "请填写售价".jys.add(UIColor.white).add(kFont(adaptW(15.0))).base
        saleTF.textColor = .white
        saleTF.textAlignment = .right
        saleTF.font = kFont(adaptW(15.0))
        
        sugesstionLb.textColor = MetricGlobal.mainGray
        resNumLb.font = kFont(adaptW(15.0))
        
        postBT.backgroundColor = MetricGlobal.mainBlue
        postBT.layer.cornerRadius = adaptW(22.0)
        postBT.layer.masksToBounds = true
    }
}
