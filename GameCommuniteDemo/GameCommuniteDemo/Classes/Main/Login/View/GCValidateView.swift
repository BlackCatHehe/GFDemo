//
//  GCValidateView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCValidateView: UIView {

    var count: Int = 4
    var validateCode: String = ""
    
    private var nums: [String] = []
    private var numLbs: [UILabel] = []
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initUI()
    }
    
}

extension GCValidateView {
    
    private func initUI() {
        
        let textfield = UITextField()
        textfield.keyboardType = .numberPad
        textfield.borderStyle = .none
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        self.addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let maskView = UIView()
        maskView.isUserInteractionEnabled = false
        maskView.backgroundColor = MetricGlobal.mainBgColor
        self.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        let margin = (kScreenW - 15.0 * 2 - adaptW(25.0)*2 - adaptW(49.0)*CGFloat(count))/(CGFloat(count) - 1)
        for i in 0..<count {
            let lb = UILabel()
            lb.textColor = .white
            lb.font = kFont(adaptW(30.0), MetricGlobal.mainMediumFamily)
            lb.textAlignment = .center
            lb.layer.borderColor = MetricGlobal.mainBlue.cgColor
            lb.layer.borderWidth = 1.0
            lb.layer.cornerRadius = adaptW(5.0)
            maskView.addSubview(lb)
            lb.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(25.0 + (49.0+margin) * CGFloat(i)))
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: adaptW(49.0), height: adaptW(49.0)))
            }
            
            numLbs.append(lb)
        }
    }
}

extension GCValidateView: UITextFieldDelegate {
    
    @objc private func textFieldChanged(_ textfield: UITextField) {
        
        if let text = textfield.text {
            
            JYLog(text)
            
            if text.count >= count, textfield.canResignFirstResponder {
                textfield.resignFirstResponder()
            }
            
            
            self.validateCode = text
            
            let arr = text.map{String($0)}
            self.nums = arr
            self.reloadData()
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //长度大于验证码长度，则无效输入
        guard range.location < count else {return false}
        
        //string == "" 表示退格,有效
        if string == "" {return true}
        
        //输入非数字，则无效输入
        guard let _ = Int(string) else {return false}

        return true
    }
    
    private func reloadData() {
        
        for i in 0..<4 {
            guard  i <= count else {
                return
            }
            
            let lb = numLbs[i]
            
            if i > nums.count - 1 {
                lb.text = nil
            }else {
                let num = nums[i]
                lb.text = num
            }
            
            
            
            
        }
    }
}
