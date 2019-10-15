////
////  MXTEmojiLabel.swift
////  mingxint
////
////  Created by payTokens on 2019/4/16.
////  Copyright © 2019 放. All rights reserved.
////
//
//import UIKit
//import YYText
//
//fileprivate struct Metric {
//    static let truncationTokenColor: UIColor = kRGBA(r: 221, g: 82, b: 82, a: 1)
//}
//
//class MXTEmojiLabel: YYLabel {
//    
//    @IBInspectable var autoFont: CGFloat {
//        set{
//            font = kFont(adaptW(newValue))
//        }
//        get{
//            return font.pointSize
//        }
//    }
//    
//    var lineSpaceAttrText: NSAttributedString? {
//        set{
//            guard newValue != nil else {return}
//            let attrStr = NSMutableAttributedString(attributedString: newValue!)
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 5.0
//            attrStr.addAttributes([.paragraphStyle : style, .font: kFont(adaptW(13.0))], range: NSRange(location: 0, length: newValue!.string.count))
//            attributedText = attrStr
//            
//        }
//        get{
//            return attributedText
//        }
//    }
//    var lineSpaceText: String? {
//        set{
//            guard newValue != nil else {return}
//            let attrStr = NSMutableAttributedString(string: newValue!)
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 5.0
//            attrStr.addAttributes([.paragraphStyle : style, .font: kFont(adaptW(13.0))], range: NSRange(location: 0, length: newValue!.count))
//            attributedText = attrStr
//            
//        }
//        get{
//            return text
//        }
//    }
//    
//    
//    var tapMore: (()->())?
//    var tapClose: (()->())?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setupConfig()
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        setupConfig()
//
//    }
//    
//}
//
//extension MXTEmojiLabel {
//    private func setupConfig() {
//        self.textParser = MXTYYTextEmotionParser.defaultParser
//       
//    }
//    
//    //1.展开和收起
//    func setOpenConfig(tapAction:(()->())?){
//        let zhankaiStr = "  ...展开 "
//        let string = NSMutableAttributedString(string: zhankaiStr)
//        
//        guard self.text != nil else {return}
//        string.addAttributes([.foregroundColor : Metric.truncationTokenColor], range: NSRange(location: 0, length: zhankaiStr.count))
//        
//        let highlight =  YYTextHighlight()
//        string.yy_setTextHighlight(highlight, range: NSRange(location: 0, length: zhankaiStr.count))
//        highlight.tapAction = {_,_,_,_ in
//            print("展开")
// 
//            if tapAction != nil {
//                tapAction!()
//            }
//            
//        }
//        
//        let yylabel = YYLabel()
//        yylabel.attributedText = string
//        yylabel.sizeToFit()
//        
//        let token = NSAttributedString.yy_attachmentString(withContent: yylabel, contentMode: .center, attachmentSize: yylabel.bounds.size, alignTo: self.font, alignment: .top)
//        
//        self.truncationToken = token
//    }
//    
//    func setCloseConfig(content: String?, tapAction:(()->())?){
//        let text = content ?? ""
//        let shouqiStr = "  收起"
//        let attrStr = NSMutableAttributedString(string: text + shouqiStr)
//        let range = NSRange(location: attrStr.string.count - shouqiStr.count, length: shouqiStr.count)
//        attrStr.yy_setTextHighlight(range, color: Metric.truncationTokenColor, backgroundColor: .clear) { (_, _, _, _) in
//
//            print("收起")
//            if tapAction != nil {
//                tapAction!()
//            }
//   
//        }
//        self.lineSpaceAttrText = attrStr
//    }
//}
