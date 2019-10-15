//
//  UIBarButtonItem+Badge.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/11.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

fileprivate let Badge_badgeValue = "Badge_badgeValueKey"
fileprivate let Badge_badgeLabel = "Badge_badgeLabelKey"
fileprivate let Badge_backgroundColor = "Badge_backgroundColorKey"


public extension UIBarButtonItem {
    
    var badgeValue: Int  {
        get {
            return objc_getAssociatedObject(self, Badge_badgeValue) as! Int
        }
        set {
            objc_setAssociatedObject(self, Badge_badgeValue, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var badgeLabel: UILabel  {
        get {
            return objc_getAssociatedObject(self, Badge_badgeLabel) as! UILabel
        }
        set {
            objc_setAssociatedObject(self, Badge_badgeLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            initBadge()
        }
        
        
    }
    
    var badgeBackgroundColor: UIColor  {
        get {
            return objc_getAssociatedObject(self, Badge_backgroundColor) as! UIColor
        }
        set {
            objc_setAssociatedObject(self, Badge_backgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    private func initBadge() {
        
    }
}
