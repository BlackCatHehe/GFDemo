//
//  JYTextfieldCustomProtocol.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/27.
//  Copyright © 2019 kuroneko. All rights reserved.
//


protocol JYTextfieldCustomProtocol {
    
}

extension JYTextfieldCustomProtocol where Self: UITextField {
    
    func customClearButton(imageNamed: String) {
        if let image = UIImage(named: imageNamed) {
            if let clearBt = value(forKey: "_clearButton") as? UIButton {
                let originImg = clearBt.imageView?.image
                clearBt.setImage(image, for: .normal)
                clearBt.setImage(image, for: .selected)
            }
        }
    }
}

extension UITextField: JYTextfieldCustomProtocol {}
