//
//  GCMakeSureOrderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    static let cTitle = "购买数量"
    static let bTitles = ["交易安全险", "角色分离", "阵营转移", "钱数(随便起的用来占位)"]
}

class GCMakeSureOrderView: UIView {

    var selecteds: [Bool] = [false, false, false, false]
    
    private var goodsImageV: UIImageView!
    private var goodsNameLb: UILabel!
    private var goodsQuLb: UILabel!
    private var goodsMoneyBt: UIButton!
    var numTF: UITextField!
    
    private var goodsNum: Int = 1
    
    private var selectedIndex: Int = 0
    
    private var bBts: [UIButton] = []
    private var selectedBts: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: GCGoodsModel) {
        goodsImageV.kf.setImage(with: URL(string:model.cover!))
        goodsNameLb.text = model.name
        goodsQuLb.text = "所在区/服：魔兽世界(国服）/一区"
        goodsMoneyBt.setTitle("\(model.price!)ETH", for: .normal)
        
    }
}

extension GCMakeSureOrderView {
    
    private func initUI() {
        
        let scrollview = UIScrollView()
        if #available(iOS 11.0, *) {
            scrollview.contentInsetAdjustmentBehavior = .never
        }
        addSubview(scrollview)
        scrollview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        
        //MARK: ------------topGoodsMsg------------
        let topBgview = UIView()
        topBgview.backgroundColor = MetricGlobal.mainCellBgColor
        topBgview.layer.cornerRadius = adaptW(5.0)
        topBgview.layer.masksToBounds = true
        scrollview.addSubview(topBgview)
        
        let goodsImgV = UIImageView()
        goodsImgV.contentMode = .scaleAspectFill
        goodsImgV.clipsToBounds = true
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        goodsImgV.layer.borderWidth = 1.0
        topBgview.addSubview(goodsImgV)
        self.goodsImageV = goodsImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(15.0))
        nameLb.numberOfLines = 2
        topBgview.addSubview(nameLb)
        self.goodsNameLb = nameLb
        
        let quLb = UILabel()
        quLb.textColor = kRGB(r: 165, g: 164, b: 192)
        quLb.font = kFont(adaptW(13.0))
        topBgview.addSubview(quLb)
        self.goodsQuLb = quLb
        
        let moneyBt = UIButton()
        moneyBt.tintColor = .white
        moneyBt.setImage(UIImage(named: "icon_silver"), for: .normal)
        moneyBt.setTitleColor(.white, for: .normal)
        moneyBt.titleLabel?.font = kFont(adaptW(14.0))
        topBgview.addSubview(moneyBt)
        self.goodsMoneyBt = moneyBt
        
        topBgview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight + adaptW(12.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.width.equalTo(kScreenW - adaptW(15.0)*2)
        }
        goodsImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(8))
            make.top.equalToSuperview().offset(adaptW(12.0))
            make.size.equalTo(CGSize(width: adaptW(60.0), height: adaptW(60.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(goodsImgV)
            make.left.equalTo(goodsImgV.snp.right).offset(adaptW(10.0))
            make.right.equalToSuperview().offset(-adaptW(7.0))
        }
        quLb.snp.makeConstraints { (make) in
            make.top.equalTo(nameLb.snp.bottom).offset(adaptW(10.0))
            make.left.right.equalTo(nameLb)
            make.height.equalTo(adaptW(12.0))
        }
        moneyBt.snp.makeConstraints { (make) in
            make.top.equalTo(quLb.snp.bottom).offset(adaptW(10.0))
            make.left.equalTo(quLb)
            make.height.equalTo(adaptW(15.0))
            make.bottom.equalToSuperview().offset(-adaptW(12.0))
        }
        
        //MARK: ------------centerView(购买数量)------------
        let cBgview = UIView()
        cBgview.backgroundColor = MetricGlobal.mainCellBgColor
        cBgview.layer.cornerRadius = adaptW(5.0)
        cBgview.layer.masksToBounds = true
        scrollview.addSubview(cBgview)
        
        let ctitleLb  = UILabel()
        ctitleLb.textColor = .white
        ctitleLb.font = kFont(adaptW(15.0))
        ctitleLb.text = Metric.cTitle
        cBgview.addSubview(ctitleLb)
        
        let stepperBgView = UIView()
        stepperBgView.backgroundColor = MetricGlobal.mainCellBgColor
        stepperBgView.layer.cornerRadius = 2.0
        stepperBgView.layer.masksToBounds = true
        stepperBgView.layer.borderColor = MetricGlobal.mainBlue.cgColor
        stepperBgView.layer.borderWidth = 0.5
        cBgview.addSubview(stepperBgView)
        
        let jianBt = UIButton()
        jianBt.setTitle("-", for: .normal)
        jianBt.setTitleColor(.white, for: .normal)
        jianBt.titleLabel?.font = kFont(adaptW(12.0))
        jianBt.addTarget(self, action: #selector(clickJian), for: .touchUpInside)
        stepperBgView.addSubview(jianBt)
        
        let lineV1 = UIView()
        lineV1.backgroundColor = MetricGlobal.mainBlue
        stepperBgView.addSubview(lineV1)

        let textfield = UITextField()
        textfield.text = "1"
        textfield.textColor = .white
        textfield.font = kFont(adaptW(12.0))
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        stepperBgView.addSubview(textfield)
        self.numTF = textfield
        
        let lineV2 = UIView()
        lineV2.backgroundColor = MetricGlobal.mainBlue
        stepperBgView.addSubview(lineV2)
        
        let plusBt = UIButton()
        plusBt.setTitle("+", for: .normal)
        plusBt.setTitleColor(.white, for: .normal)
        plusBt.titleLabel?.font = kFont(adaptW(12.0))
        jianBt.addTarget(self, action: #selector(clickPlus), for: .touchUpInside)
        stepperBgView.addSubview(plusBt)
        
        cBgview.snp.makeConstraints { (make) in
            make.top.equalTo(topBgview.snp.bottom).offset(adaptW(10.0))
            make.left.right.equalTo(topBgview)
            make.height.equalTo(adaptW(58.0))
        }
        ctitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(10.0))
            make.centerY.equalToSuperview()
        }
        stepperBgView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(12.0))
            make.centerY.equalTo(ctitleLb)
            make.height.equalTo(adaptW(24.0))
        }
        jianBt.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(adaptW(30.0))
        }
        lineV1.snp.makeConstraints { (make) in
            make.left.equalTo(jianBt.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1.0)
        }
        textfield.snp.makeConstraints { (make) in
            make.left.equalTo(lineV1.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(adaptW(36.0))
        }
        lineV2.snp.makeConstraints { (make) in
            make.left.equalTo(textfield.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1.0)
        }
        plusBt.snp.makeConstraints { (make) in
            make.left.equalTo(lineV2.snp.right)
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(adaptW(30.0))
        }
        
        
        //MARK: ------------bottom 4项------------
        let bBgview = UIView()
        bBgview.backgroundColor = MetricGlobal.mainCellBgColor
        bBgview.layer.cornerRadius = adaptW(5.0)
        bBgview.layer.masksToBounds = true
        scrollview.addSubview(bBgview)
        bBgview.snp.makeConstraints { (make) in
            make.top.equalTo(cBgview.snp.bottom).offset(adaptW(12.0))
            make.left.right.equalTo(cBgview)
            make.bottom.equalToSuperview()
        }
        
        let titles = Metric.bTitles
        for i in 0..<titles.count {
            
            let title = titles[i]
            let subBgView = UIView()
            bBgview.addSubview(subBgView)
            subBgView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(i == titles.count-1 ? adaptW(65.0) : adaptW(54.0))
                make.top.equalToSuperview().offset(adaptW(55.0*CGFloat(i)))
                if i == titles.count-1 {
                    make.bottom.equalToSuperview()
                }
            }
            
            
            let btitleLb  = UILabel()
            let bMoneyBt = UIButton()
            let moneyRateLb = UILabel()
            //第四行单独处理
            if i == titles.count - 1 {
                bMoneyBt.tintColor = .white
                bMoneyBt.setImage(UIImage(named: "icon_silver"), for: .normal)
                bMoneyBt.setTitleColor(.white, for: .normal)
                bMoneyBt.titleLabel?.font = kFont(adaptW(14.0))
                bMoneyBt.setTitle("ETH800", for: .normal)
                bMoneyBt.layoutButton(style: .Left, imageTitleSpace: adaptW(5.0))
                subBgView.addSubview(bMoneyBt)
                
                moneyRateLb.textColor = MetricGlobal.mainGray
                moneyRateLb.font = kFont(adaptW(11.0))
                moneyRateLb.text = "50ETH=$1元"
                subBgView.addSubview(moneyRateLb)
                
                
                bMoneyBt.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(adaptW(15.0))
                    make.left.equalToSuperview().offset(adaptW(10.0))
                    make.height.equalTo(adaptW(18.0))
                }
                moneyRateLb.snp.makeConstraints { (make) in
                    make.top.equalTo(bMoneyBt.snp.bottom).offset(adaptW(2.0))
                    make.left.equalTo(bMoneyBt)
                    make.height.equalTo(adaptW(11.0))
                }
            }else {

                btitleLb.textColor = .white
                btitleLb.font = kFont(adaptW(15.0))
                btitleLb.text = title
                subBgView.addSubview(btitleLb)
                btitleLb.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(adaptW(10.0))
                    make.centerY.equalToSuperview()
                }
            }
            
            let bBt = UIButton()
                            bBt.setImage(UIImage(named: "check_noSel"), for: .normal)
                            bBt.setImage(UIImage(named: "check_sel"), for: .selected)
            bBt.tag = 100+i
            bBt.addTarget(self, action: #selector(clickSelected(_:)), for: .touchUpInside)
            subBgView.addSubview(bBt)
            bBt.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-adaptW(12.0))
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: adaptW(20.0), height: adaptW(20.0)))
            }
            bBts.append(bBt)
            
        }
    }
    
    @objc private func clickJian() {
        if let text = numTF.text, let num = Int(text), num > 1 {
            numTF.text = String(format: "%i", num - 1)
        }
    }
    
    @objc private func clickPlus() {
        if let text = numTF.text, let num = Int(text) {
            numTF.text = String(format: "%i", num + 1)
        }
    }
}

extension GCMakeSureOrderView {
    
    @objc private func clickSelected(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
//        if sender.isSelected == true, !selectedBts.contains(sender) {
//            selectedBts.append(sender)
//        }
//        if sender.isSelected == false, selectedBts.contains(sender) {
//            selectedBts.remove(at: selectedBts.firstIndex(of: sender)!)
//        }
//
//        print("------")
//        for bt in selectedBts {
//            print("选择的bt为:\(bt.tag-100)")
//        }
//        print("------")
        
        let selecteds = bBts.map{$0.isSelected}
        self.selecteds = selecteds
    }
}
