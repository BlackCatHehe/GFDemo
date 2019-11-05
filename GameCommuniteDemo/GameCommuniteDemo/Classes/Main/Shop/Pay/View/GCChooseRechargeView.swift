//
//  GCChooseRechargeView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCChooseRechargeView: UIView {
    
    private var choosedCell: GCRechargeMoneyCell!
    
    private var moneyBgView: JYTagView!
    
    private var descriptLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        moneyBgView.titles = ["", "", "", ""]
        moneyBgView.itemBuilder = {[weak self] index -> UIView in
            let cell = GCRechargeMoneyCell()
            cell.isChoosed = index == 0 ? true : false
            cell.tag = index + 100
            cell.setModel()
            cell.clickChoose = {[weak self] index in
                self?.choose(at: cell)
            }
            if index == 0 {
                self?.choosedCell = cell
            }
            return cell
        }
        moneyBgView.reloadData()
        
        descriptLb.text =
        """
        温馨提示
        1.iOS充值月不能再安卓使用
        2.兑换比例：1元=100ETH
        3.购买后若长时间无变化，请致电0871-77867734
        """
    }
    
    private func choose(at view: GCRechargeMoneyCell){
        if choosedCell == view {
            return
        }
        
        choosedCell.isChoosed = false
        
        view.isChoosed = true
        
        choosedCell = view
        
    }
}

extension GCChooseRechargeView {
    
    private func initUI(){
        
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        let titleLb = UILabel()
        titleLb.text = "选择充值金额"
        titleLb.font = kFont(adaptW(15.0))
        titleLb.textColor = .white
        addSubview(titleLb)
        
        let rechargeView = JYTagView()
        rechargeView.itemHeight = adaptW(70.0)
        rechargeView.itemWidth = adaptW(166.0)
        rechargeView.itemSpacing = adaptW(12.0)
        rechargeView.itemInsetPadding = adaptW(15.5)
        addSubview(rechargeView)
        self.moneyBgView = rechargeView
        
        let descriptLb = UILabel()
        descriptLb.font = kFont(adaptW(12.0))
        descriptLb.textColor = .white
        descriptLb.numberOfLines = 0
        addSubview(descriptLb)
        self.descriptLb = descriptLb
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalToSuperview().offset(adaptW(12.0))
            make.height.equalTo(adaptW(15.0))
        }
        rechargeView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalTo(titleLb.snp.bottom).offset(adaptW(20.0))
        }
        
        descriptLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalTo(rechargeView.snp.bottom).offset(adaptW(20.0))
            make.bottom.equalToSuperview().offset(adaptW(-20.0))
        }
    }
}
