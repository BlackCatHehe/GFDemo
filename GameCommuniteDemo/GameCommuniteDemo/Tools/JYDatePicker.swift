//
//  JYDatePicker.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

final class JYDatePicker: UIView {
    
    var tapChoose: ((String)->())?
    
    private var headerView: UIView!
    private var datePicker: UIDatePicker!
    
    private var chooseDate: Date?
    
    private var chooseDateStr: String {
        get {
            let str = JYDateFormatter.dateFormatter.string(from: chooseDate!)
            return str
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JYDatePicker {
    
    private func initUI(){
        //MARK: ------------header------------
        let headerV = UIView()
        headerV.backgroundColor = MetricGlobal.mainCellBgColor
        self.addSubview(headerV)
        self.headerView = headerV
        
        let lBt = UIButton()
        lBt.setTitle("取消", for: .normal)
        lBt.setTitleColor(MetricGlobal.mainGray, for: .normal)
        lBt.addTarget(self, action: #selector(clickLeftBt), for: .touchUpInside)
        headerV.addSubview(lBt)
        
        let rBt = UIButton()
        rBt.setTitle("确定", for: .normal)
        rBt.setTitleColor(.white, for: .normal)
        rBt.addTarget(self, action: #selector(clickRightBt), for: .touchUpInside)
        headerV.addSubview(rBt)
        
        headerView.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(adaptW(50.0))
        }
        lBt.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.height.equalTo(adaptW(44.0))
        }
        rBt.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.centerY.equalToSuperview()
            make.height.equalTo(adaptW(44.0))
        }
        
        //MARK: ------------DatePicker------------
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date(timeIntervalSinceNow: 0)
        datePicker.locale = Locale(identifier: "zh_CN")
        self.addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomH)
        }
        self.datePicker = datePicker
        self.chooseDate = datePicker.date
    }
    
    @objc func clickLeftBt() {
        removeFromSuperview()
    }
    
    @objc func clickRightBt() {
        self.chooseDate = datePicker.date
        removeFromSuperview()
        
        tapChoose?(chooseDateStr)
    }
}
