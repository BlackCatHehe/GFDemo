//
//  GCCommunityHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import YYText
import Kingfisher
protocol GCCommunityHeaderViewDelegate {
     func headerView(_ headerV: GCCommunityHeaderView, didClickJoin button: UIButton)
}

class GCCommunityHeaderView: UIView {

    var delegate: GCCommunityHeaderViewDelegate?
    
    var updateLayout: ClickClosure?
    
    private var bgImageView: UIImageView!
    private var iconImgView: UIImageView!
    private var titleLb: UILabel!
    private var contentLb: YYLabel!
    private var memberBgView: UIView!
    /// 是否折叠contentLb
    private var isFold: Bool = true {
        didSet {
            contentLb.numberOfLines = isFold ? 2 : 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        bgImageView.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2164478293,4167951289&fm=26&gp=0.jpg")!)
        iconImgView.kf.setImage(with: URL(string: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3916481728,2850933383&fm=26&gp=0.jpg")!)
        
        titleLb.text = "魔兽世界"
        
        let contentStr = "这里是属于热衷魔兽世界的朋友们的专属讨论小组， 大家可以在这里发起话题，畅所欲言.这里是属于热衷魔兽世界的朋友们的专属讨论小组， 大家可以在这里发起话题，畅所欲言"
        
        let pramaStyle = NSMutableParagraphStyle()
        pramaStyle.lineSpacing = adaptW(5.0)
        let content = NSMutableAttributedString(string: contentStr)
        content.addAttributes([NSAttributedString.Key.paragraphStyle: pramaStyle], range: NSMakeRange(0, contentStr.count))
        content.yy_lineSpacing = adaptW(9.0)
        content.yy_font = kFont(adaptW(11.0))
        content.yy_color = .white
        self.contentLabelAddExpand(content)
        
        let icons = ["https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3916481728,2850933383&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3916481728,2850933383&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3916481728,2850933383&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3916481728,2850933383&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3916481728,2850933383&fm=26&gp=0.jpg"]
        
        
        let count = icons.count > 5 ? 5 : icons.count
        guard count != 0 else {return}
        for i in 0..<count {
            let iconStr = icons[i]
            
            let iconImgV = UIImageView()
            iconImgV.contentMode = .scaleAspectFill
            self.memberBgView.addSubview(iconImgV)
            iconImgV.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(15.0 + (23.0 + 5)*CGFloat(i)))
                make.size.equalTo(CGSize(width: adaptW(23.0), height: adaptW(23.0)))
                make.top.equalToSuperview().offset(2.0)
                make.bottom.equalToSuperview().offset(-2.0)
            }
            iconImgV.kf.setImage(with: URL(string: iconStr), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(23.0/2), targetSize: CGSize(width: adaptW(23.0), height: adaptW(23.0)), roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
        }
        
        let memberNumLb = UILabel()
        memberNumLb.text = "\(count)已加入"
        memberNumLb.textColor = .white
        memberNumLb.font = kFont(adaptW(12.0))
        self.memberBgView.addSubview(memberNumLb)
        memberNumLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0 + (23.0 + 5)*CGFloat(count) + 10.0))
            make.centerY.equalToSuperview()
        }
    }
    
    //折叠状态label添加展开
    private func contentLabelAddExpand(_ str: NSMutableAttributedString) {
        contentLb.attributedText = str
        
        let truncationToken = "... 展开".jys.add(MetricGlobal.mainBlue, at: NSMakeRange(4, 2)).add(kFont(adaptW(13.0))).add(UIColor.white, at: NSMakeRange(0, 4)).base

        let hiTap = YYTextHighlight()
        truncationToken.yy_setTextHighlight(hiTap, range: NSMakeRange(4, 2))
        hiTap.tapAction = {(_, _, _, _) in
            self.isFold = false
            
            self.updateLayout?()
            
            self.contentLabelAddFolded(str)
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
            
            self.updateLayout?()
        }
        contentLb.attributedText = content
 
    }
    
}

extension GCCommunityHeaderView {
    
    private func initUI() {
        //背景图
        let bgImgV = UIImageView()
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.clipsToBounds = true
        addSubview(bgImgV)
        self.bgImageView = bgImgV
        bgImgV.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(adaptW(185.0))
        }
        
        //底部视图
        let bBgView = UIView()
        bBgView.backgroundColor = kRGBA(r: 0, g: 0, b: 0, a: 0.3)
        addSubview(bBgView)

        let iconImgV = UIImageView()
        iconImgV.contentMode = .scaleAspectFill
        iconImgV.layer.borderColor = UIColor.white.cgColor
        iconImgV.layer.cornerRadius = 5.0
        iconImgV.layer.borderWidth = 2.0
        bBgView.addSubview(iconImgV)
        self.iconImgView = iconImgV
        
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        bBgView.addSubview(titleLb)
        self.titleLb = titleLb
        
        let contentLb = YYLabel()
        contentLb.textColor = MetricGlobal.mainGray
        contentLb.font = kFont(adaptW(11.0))
        contentLb.numberOfLines = 2
        contentLb.preferredMaxLayoutWidth = adaptW(240.0)
        contentLb.isUserInteractionEnabled = true
        bBgView.addSubview(contentLb)
        self.contentLb = contentLb

        let addButton = UIButton()
        addButton.setTitle("加入", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = kFont(14.0)
        addButton.backgroundColor = MetricGlobal.mainBlue
        addButton.layer.cornerRadius = adaptW(14.0)
        addButton.layer.masksToBounds = true
        addButton.addTarget(self, action: #selector(clickJoin(_:)), for: .touchUpInside)
        bBgView.addSubview(addButton)
        
        bBgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(adaptW(90.0))
        }
        
        addButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalToSuperview().offset(adaptW(22.0))
            make.size.equalTo(CGSize(width: adaptW(75.0), height: adaptW(28.0)))
        }
        
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalTo(bBgView.snp.top)
            make.size.equalTo(CGSize(width: adaptW(43.0), height: adaptW(43.0)))
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(8.0))
            make.top.equalToSuperview().offset(adaptW(5.0))
            make.height.equalTo(adaptW(15.0))
        }
        
        contentLb.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgV)
            make.right.equalTo(addButton.snp.left).offset(-adaptW(25.0))
            make.top.equalTo(iconImgV.snp.bottom).offset(adaptW(10.0))
            make.bottom.equalToSuperview().offset(-adaptW(5.0))
        }
        
        //MARK: ------------成员------------
        let memberV = UIView()
        memberV.backgroundColor = kRGBA(r: 0, g: 0, b: 0, a: 0.3)
        self.addSubview(memberV)
        memberV.snp.makeConstraints { (make) in
            make.left.right.equalTo(bBgView)
            make.top.equalTo(bBgView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        self.memberBgView = memberV
    }

    @objc private func clickJoin(_ sender: UIButton) {
        self.delegate?.headerView(self, didClickJoin: sender)
    }
}
