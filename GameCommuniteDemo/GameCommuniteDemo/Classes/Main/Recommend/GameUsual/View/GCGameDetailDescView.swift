//
//  GCGameDetailDescView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import YYText
class GCGameDetailDescView: UIView {

    private var contentLb: YYLabel!
    
    /// 是否折叠contentLb
    private var isFold: Bool = true {
        didSet {
            contentLb.numberOfLines = isFold ? 4 : 0
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: GCGameModel) {
        //处理contentlb的折叠和展开
        let contentStr = model.descriptionField ?? ""
        let pramaStyle = NSMutableParagraphStyle()
        pramaStyle.lineSpacing = adaptW(5.0)
        let content = NSMutableAttributedString(string: contentStr)
        content.addAttributes([NSAttributedString.Key.paragraphStyle: pramaStyle], range: NSMakeRange(0, contentStr.count))
        content.yy_lineSpacing = adaptW(9.0)
        content.yy_font = kFont(adaptW(11.0))
        content.yy_color = .white
        self.contentLabelAddExpand(content)
    }
    
    //折叠状态label添加展开
       private func contentLabelAddExpand(_ str: NSMutableAttributedString) {
           contentLb.attributedText = str
           
           let truncationToken = "... 展开".jys.add(MetricGlobal.mainBlue, at: NSMakeRange(4, 2)).add(kFont(adaptW(13.0))).add(UIColor.white, at: NSMakeRange(0, 4)).base

           let hiTap = YYTextHighlight()
           truncationToken.yy_setTextHighlight(hiTap, range: NSMakeRange(4, 2))
           hiTap.tapAction = {(_, _, _, _) in
               self.contentLabelAddFolded(str)
               
               self.isFold = false
               
               //self.updateLayout?()

           }
           let moreLb = YYLabel()
           moreLb.attributedText = truncationToken
           moreLb.sizeToFit()
           let token = NSAttributedString.yy_attachmentString(withContent: moreLb, contentMode: .center, attachmentSize: moreLb.frame.size, alignTo: contentLb.font, alignment: .top)
           contentLb.truncationToken = token
       }
       
       //折叠状态label添加收起
       private func contentLabelAddFolded(_ str: NSMutableAttributedString) {
           let shouStr = "  收起".jys.add(MetricGlobal.mainBlue).add(kFont(adaptW(13.0))).base

           let content = NSMutableAttributedString(attributedString: str)
           content.append(shouStr)

           content.yy_setTextHighlight(NSMakeRange(content.length - 2, 2), color: MetricGlobal.mainBlue, backgroundColor: nil) { (_, _, _, _) in
               self.isFold = true
               
              // self.updateLayout?()
           }
           contentLb.attributedText = content
    
       }
    
}

extension GCGameDetailDescView {
    
    private func setupUI(){
        
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(18.0), MetricGlobal.mainMediumFamily)
        titleLb.text = "游戏简介"
        self.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(20.0))
        }
        
        let contentLb = YYLabel()
        contentLb.textColor = MetricGlobal.mainGray
        contentLb.font = kFont(adaptW(13.0))
        contentLb.numberOfLines = 4
        contentLb.preferredMaxLayoutWidth = adaptW(kScreenW - adaptW(30.0))
        self.addSubview(contentLb)
        contentLb.snp.makeConstraints { (make) in
            make.top.equalTo(titleLb.snp.bottom).offset(adaptW(15.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.bottom.equalToSuperview().offset(-adaptW(15.0))
        }
        self.contentLb = contentLb
    }
}
