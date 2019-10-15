//
//  WRPGCommon.swift
//  TheWorld
//
//  Created by payTokens on 2019/1/25.
//  Copyright © 2019年 payTokens. All rights reserved.
//

import UIKit
import AVKit


// MARK: ===================================变量宏定义=========================================

// MARK: ========系统相关========
/// Info
public let kAppBundleInfoVersion = Bundle.main.infoDictionary ?? Dictionary()
/// plist:  AppStore 使用VersionCode 1.0.1
public let kAppBundleVersion = (kAppBundleInfoVersion["CFBundleShortVersionString" as String] as? String ) ?? ""
public let kAppBundleBuild = (kAppBundleInfoVersion["CFBundleVersion"] as? String ) ?? ""
public let kAppDisplayName = (kAppBundleInfoVersion["CFBundleDisplayName"] as? String ) ?? ""
public let kAppNamespace = (kAppBundleInfoVersion["CFBundleExecutable"] as? String ) ?? ""

// MARK: ========系统版本相关========
public let kiOSBase = 9.0
public let kOSGreaterOrEqualToiOS9 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 9.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS10 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 10.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS11 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 11.0 ) ? true : false;



// 设备宽高、机型
public let kWindow = UIApplication.shared.keyWindow
public let kScreenW : CGFloat = UIScreen.main.bounds.width
public let kScreenH : CGFloat = UIScreen.main.bounds.height
public let kStatusBarheight = UIApplication.shared.statusBarFrame.size.height
public let kNavBarHeight: CGFloat = 44.0
public let kTabBarHeight : CGFloat = isIPhoneX() ? (49.0 + 34.0) : 49.0
public let kBottomH: CGFloat = isIPhoneX() ? 34.0 : 0
public let kNavBarHeight_StatusHeight: ((UIViewController?)-> CGFloat) = {(vc : UIViewController? ) -> CGFloat in
    if vc != nil {
        weak var weakVC = vc;
        var navHeight = weakVC?.navigationController?.navigationBar.bounds.size.height ?? 0.0
        return (navHeight + kStatusBarheight)
    }else{
        return isIPhoneX() ? (44.0 + 44.0) : (44.0 + 20.0)
    }
}

// MARK: ========比例适配相关========
//屏幕分辨率比例
let screenScale:CGFloat = UIScreen.main.responds(to: #selector(getter: UIScreen.main.scale)) ? UIScreen.main.scale : 1.0

//不同屏幕尺寸字体适配（375，667是因为目前苹果开发一般用IPHONE6做中间层 如果不是则根据实际情况修改）
//相对于iPhone6的宽度比例
let screenWidthRatio:CGFloat =  kScreenW / 375;
let screenHeightRatio:CGFloat = kScreenH / 667;

//根据传入的值算出乘以比例之后的值
func adaptW(_ width:CGFloat) ->CGFloat {
    return  CGFloat(ceil(Float(width))) * screenWidthRatio
}

func adaptH(_ height:CGFloat) ->CGFloat {
    return CGFloat(ceil(Float(height))) * screenHeightRatio
}

// MARK: ========判断设备========

/*
 5  5s
 */
let isIPhone5 = kScreenH == 568.0 ? true : false

/*
 6  6s  7
 */
let isIPhone6 = kScreenH == 568.0 ? true : false

/*
 6plus  6splus  7plus
 */
let isIPhone6plus = kScreenH == 736.0 ? true : false

/*
 x
 */
func isIPhoneX() -> Bool{
    var isIPhoneX = false
    //判断是否是iphone
    //UIUserInterfaceIdiom 苹果的phone,pad,tv,carPlay
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone{
        return false
    }
    if #available(iOS 11.0, *) {
        isIPhoneX =  UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > CGFloat(0.0) ? true : false
    }
    return isIPhoneX
}


/// 过滤null的字典，当为nil时返回一个初始化的字典
public let kFilterNullOfDictionary:((Any) -> Dictionary<AnyHashable, Any>) = {( obj: Any) -> Dictionary<AnyHashable, Any> in
    if obj is Dictionary<AnyHashable, Any> {
        return obj as! Dictionary<AnyHashable, Any>
    }
    return Dictionary()
}



// MARK: ========设置颜色========
/// 设置颜色值
public let HexRGB:((Int) -> UIColor) = { (rgbValue : Int) -> UIColor in
    return HexRGBAlpha(rgbValue,1.0)
}

/// 通过 十六进制与alpha来设置颜色值  （ 样式： 0xff00ff ）
public let HexRGBAlpha:((Int,Float) -> UIColor) = { (rgbValue : Int, alpha : Float) -> UIColor in
    return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
}


/// 通过 red 、 green 、blue 、alpha 颜色数值
func kRGB (r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}



// MARK: - ========时间格式========
enum TimeFormat:String
{
    case format_default            = "yyyy-MM-dd HH:mm:ss"
    case format_yyMdHm             = "yy-MM-dd HH:mm"
    case format_yyyyMdHm           = "yyyy-MM-dd HH:mm"
    case format_yMd                = "yyyy-MM-dd"
    case format_MdHms              = "MM-dd HH:mm:ss"
    case format_MdHm               = "MM-dd HH:mm"
    case format_Hms                = "HH:mm:ss"
    case format_Hm                 = "HH:mm"
    case format_Md                 = "MM-dd"
    case format_yyMd               = "yy-MM-dd"
    case format_YYMMdd             = "yyyyMMdd"
    case format_yyyyMdHms          = "yyyyMMddHHmmss"
    case format_yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
    case format_yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
    case format_yMdWithSlash       = "yyyy/MM/dd"
    case format_yM                 = "yyyy-MM"
    case format_yMdChangeSeparator = "yyyy.MM.dd"
}


// MARK: - ========常用的回调闭包========
typealias ClickClosure = () ->()


// MARK: - ========当前横竖屏========
func changeScreenOrientationToLandscape(_ isLandscape : Bool){
    //设置横屏
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.isLandscape = isLandscape
    
    let unknowValue = UIInterfaceOrientation.unknown.rawValue
    UIDevice.current.setValue(unknowValue, forKey: "orientation")
    
    if isLandscape{
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }else{
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
}

// MARK:- Font
func kFont(_ size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}

// MARK:- ---快速获取沙盒路径---
func getCachesPath() -> String{
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true)
    return paths.first!
}

func getDocumentPath() -> String{
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
    return paths.first!
}

func getHomePath() ->String{
    return NSHomeDirectory()
}

// MARK:- ---判断url是AVMediaType的哪种类型---
func kMediaTypeType(for url: URL, is mediaType: AVMediaType, compeletion: ((Bool)->())){
    
    let asset = AVAsset(url: url)
    let tracks = asset.tracks(withMediaType: mediaType)
    if tracks.count > 0{
        compeletion(true)
    }else{
        compeletion(false)
    }
}


// MARK:- 自定义打印方法
func JYLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
    
    print("------------------\n[file]: \(fileName)\n[line]: \(lineNum)\n[message]:\(message)]\n------------------")
    
    #endif
}


// MARK:- 等比缩放大法
public func kScaleSize(width: CGFloat, height: CGFloat, limiteSize: CGSize) -> CGSize {
    let imageW = width
    let imageH = height
    
    let limiteW = limiteSize.width
    let limiteH = limiteSize.height
    
    
    var endHeight: CGFloat = 0
    var endwidth: CGFloat = 0
    
    if imageW < imageH{
        
        if imageH < limiteH{
            endHeight = imageH
            endwidth = imageW
            
        }else{
            endHeight = limiteH
            endwidth  = imageW * (limiteH/imageH)
            
        }
        
        if endwidth > limiteW{
            
            endHeight = endHeight * (limiteW/endwidth)
            endwidth = limiteW
        }
        
    }else{
        if imageW < limiteW{
            endwidth = imageW
            endHeight = imageH
        }else{
            endwidth = limiteW
            endHeight = imageH * (limiteW/imageW)
        }
        
        if endHeight > limiteH{
            endwidth  = endwidth * (limiteH/endHeight)
            endHeight = limiteH
        }
    }
    
    return CGSize(width: endwidth, height: endHeight)
}



//range转换为NSRange

func nsRange(from range: Range<String.Index>) -> NSRange? {
    let utf16view = "".utf16
    if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
        return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
    }
    return nil
}


// MARK:- dismiss到根试图
func rootVC(vc: UIViewController) -> UIViewController?{
    var parentVc = vc.presentingViewController
    while parentVc != nil {
        parentVc = parentVc?.presentingViewController
    }
    return parentVc
    
}

// MARK:- 安全线程
func dispatch_async_safe(_ clourse: @escaping ()->()) {
    if Thread.current != .main {
        DispatchQueue.main.async {
            clourse()
        }
    } else{
        clourse()
    }
}
