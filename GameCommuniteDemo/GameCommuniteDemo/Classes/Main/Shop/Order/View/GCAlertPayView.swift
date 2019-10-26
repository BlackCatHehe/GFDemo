//
//  GCAlertPayView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCAlertPayView: UIView {
    
    private var selectedButton: UIButton!
    
    var paySelectClick: ((Int)->())?
    var clickPay: ClickClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GCAlertPayView {
    
    private func initUI(){
        self.backgroundColor = MetricGlobal.mainBgColor
        
        let imgs = ["pay_way", "pay_weixin", "pay_zhifu"]
        let titles = ["订单支付", "支付方式", "微信", "支付宝"]
        
        for i in 0...3 {
    
            let bgView = UIView()
            bgView.backgroundColor = MetricGlobal.mainCellBgColor
            self.addSubview(bgView)
            
            let imgV = UIImageView()
            imgV.contentMode = .scaleAspectFit
            imgV.image = i == 0 ? nil : UIImage(named: imgs[i-1])
            imgV.isHidden = i == 0 ? true : false
            bgView.addSubview(imgV)
            
            let label = UILabel()
            label.textColor = .white
            label.text = titles[i]
            label.font = kFont(adaptW(16.0))
            bgView.addSubview(label)
            
            let button = UIButton()
            if i == 0 {
                selectedButton = button
            }
            button.isSelected = i == 0 ? true : false
            button.setImage(UIImage(named: i == 0 ? "chahao" : "shop_jiantou_shang"), for: .normal)
            button.setImage(UIImage(named: i == 0 ? "chahao" : "shop_jiantou_xia"), for: .selected)
            button.addTarget(self, action: #selector(clickChoose(_:)), for: .touchUpInside)
            button.tag = i + 100
            bgView.addSubview(button)
            
            let lineV = UIView()
            lineV.backgroundColor = MetricGlobal.mainBgColor
            bgView.addSubview(lineV)
            
            bgView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(adaptW(61.0 * CGFloat(i)))
                make.left.right.equalToSuperview()
                make.height.equalTo(adaptW(61.0))
            }
            
            imgV.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(15.0))
                make.top.equalToSuperview().offset(adaptW(23.0))
                make.size.equalTo(CGSize(width: 20.0, height: adaptW(20.0)))
            }
            label.snp.makeConstraints { (make) in
                if i == 0 {
                    make.centerX.equalToSuperview()
                }else {
                    make.left.equalTo(imgV.snp.right).offset(adaptW(10.0))
                }
                make.centerY.equalTo(imgV)
                make.height.equalTo(adaptW(20.0))
            }
            button.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-adaptW(15.0))
                make.centerY.equalTo(imgV)
                make.size.equalTo(CGSize(width: 20.0, height: adaptW(20.0)))
            }
            
            lineV.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(adaptW(15.0))
                make.right.equalToSuperview()
                make.height.equalTo(1.0)
            }
        }
        
        let payButton = UIButton()
        payButton.backgroundColor = MetricGlobal.mainBlue
        payButton.setTitle("立即付款", for: .normal)
        payButton.setTitleColor(.white, for: .normal)
        payButton.layer.cornerRadius = adaptW(22.0)
        payButton.layer.masksToBounds = true
        payButton.addTarget(self, action: #selector(clickPayButton(_:)), for: .touchUpInside)
        self.addSubview(payButton)
        payButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(44.0))
            make.bottom.equalTo(-adaptW(44.0)-kBottomH)
        }
    }
    
    @objc private func clickChoose(_ sender: UIButton) {
        
        guard selectedButton != sender else {return}
        
        let tag = sender.tag - 100
        
        sender.isSelected = !sender.isSelected
        
        selectedButton.isSelected = false

        selectedButton = sender
        
        paySelectClick?(tag)
    }
    
    @objc private func clickPayButton(_ sender: UIButton) {
        
        clickPay?()
    }
}
