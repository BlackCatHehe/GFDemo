//
//  UILabel+AutoFont.swift
//  TestDemo
//
//  Created by APP on 2019/7/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

//xib中字体大小的适配

import Foundation
import UIKit

extension UILabel {
    @IBInspectable var autoFont: CGFloat {
        get {
            return 0
        }
        set {
             self.font = UIFont.systemFont(ofSize: newValue)
        }
    }
}
