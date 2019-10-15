//
//  UIView+Frame.swift
//  SwiftBaseDemo
//
//  Created by APP on 2019/9/2.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var jy_minX: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var jy_maxX: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.width
            self.frame = frame
        }
    }
    
    var jy_minY: CGFloat {
        get {
            return self.frame.minY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var jy_maxY: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue  - frame.height
            self.frame = frame
        }
    }
    
    var jy_width: CGFloat {
        get {
            return self.frame.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var jy_height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var jy_centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var jy_centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
