//
//  Constraint+Xib.swift
//  SwiftBaseDemo
//
//  Created by kuroneko on 2019/7/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

//xib中约束的适配
import UIKit

extension NSLayoutConstraint {
    @IBInspectable var adapter: Bool {
        get {
            return true
        }
        set {
            if newValue {
                self.constant = adaptW(self.constant)
            }
        }
    }
}
