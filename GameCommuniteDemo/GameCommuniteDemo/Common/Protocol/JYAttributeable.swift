//
//  JYAttributeable.swift
//  GameCommunity
//
//  Created by APP on 2019/9/30.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Foundation


final class JyString<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol JYStringAttributeable {
    associatedtype T
    
    var jys: T { get }
    
}

extension JYStringAttributeable {
    
    var jys: JyString<Self> {
        return JyString(self)
    }
}

extension String: JYStringAttributeable {}
extension NSAttributedString: JYStringAttributeable {}

extension JyString where Base == String {
    
    func add<T>(_ prama: T, at range: NSRange? = nil) ->JyString<NSMutableAttributedString> {
        
        let mAttrStr = NSMutableAttributedString(string: base)
        
        let resultRange = NSRange(location: 0, length: base.count)

        switch prama.self {
        case is UIFont:
            mAttrStr.addAttribute(NSAttributedString.Key.font, value: prama, range: range ?? resultRange)
        case is UIColor:
            mAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: prama, range: range ?? resultRange)
        case is CGFloat:
            let attriPraStyle = NSMutableParagraphStyle()
            attriPraStyle.lineSpacing = prama as! CGFloat
            mAttrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: attriPraStyle, range: range ?? resultRange)
        default:
            fatalError("prama can only be UIFont or UIColor")
        }
        return mAttrStr.jys
    }
}

extension JyString where Base == NSAttributedString {
    
    func add<T>(_ prama: T, at range: NSRange? = nil) ->JyString<NSMutableAttributedString> {
        
        let mAttrStr = NSMutableAttributedString(attributedString: base)

        let resultRange = NSRange(location: 0, length: base.length)

        switch prama.self {
        case is UIFont:
            mAttrStr.addAttribute(NSAttributedString.Key.font, value: prama, range: range ?? resultRange)
        case is UIColor:
            mAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: prama, range: range ?? resultRange)
        case is CGFloat:
            let attriPraStyle = NSMutableParagraphStyle()
            attriPraStyle.lineSpacing = prama as! CGFloat
            mAttrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: attriPraStyle, range: range ?? resultRange)
        default:
            fatalError("prama can only be UIFont or UIColor")
        }
        return mAttrStr.jys
    }
}

extension JyString where Base == NSMutableAttributedString {
    
    func add<T>(_ prama: T, at range: NSRange? = nil) ->JyString<NSMutableAttributedString> {
        
        let mAttrStr = base

        let resultRange = NSRange(location: 0, length: base.length)

        switch prama.self {
        case is UIFont:
            mAttrStr.addAttribute(NSAttributedString.Key.font, value: prama, range: range ?? resultRange)
        case is UIColor:
            mAttrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: prama, range: range ?? resultRange)
        case is CGFloat:
            let attriPraStyle = NSMutableParagraphStyle()
            attriPraStyle.lineSpacing = prama as! CGFloat
            mAttrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: attriPraStyle, range: range ?? resultRange)
        default:
            fatalError("prama can only be UIFont or UIColor")
        }
        return mAttrStr.jys
    }
}
//public enum ParagraphStyle {
//    case lineSpacing(spacing: CGFloat)
//    case lineSpacing(spacing: CGFloat)
//}
