//
//  GCPostCommentView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import GrowingTextView

class GCPostCommentView: UIView {
    
    var starLevel: Int = 0
    
    var images: [UIImage]?
    
    var clickPostButton: ClickClosure?
    
    private var goodsImageV: UIImageView!
    private var goodsNameLb: UILabel!
    private var goodsStars = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        goodsImageV.kf.setImage(with: URL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"))
        goodsNameLb.text = "暗影战神129加噬魂12匕首36洞满碎片 加猛攻爪和耀眼项链"

        
    }
}

extension GCPostCommentView {
    
    private func initUI() {
        
        let scrollview = UIScrollView()
        scrollview.backgroundColor = MetricGlobal.mainBgColor
        if #available(iOS 11.0, *) {
            scrollview.contentInsetAdjustmentBehavior = .never
        }
        addSubview(scrollview)
        scrollview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        //MARK: ------------topGoodsMsg------------
        let topBgview = UIView()
        topBgview.backgroundColor = MetricGlobal.mainBgColor
        topBgview.layer.cornerRadius = adaptW(5.0)
        topBgview.layer.masksToBounds = true
        scrollview.addSubview(topBgview)
        
        let goodsImgV = UIImageView()
        goodsImgV.contentMode = .scaleAspectFill
        goodsImgV.clipsToBounds = true
        goodsImgV.layer.cornerRadius = adaptW(5.0)
        goodsImgV.layer.borderColor = UIColor.white.cgColor
        goodsImgV.layer.borderWidth = 1.0
        topBgview.addSubview(goodsImgV)
        self.goodsImageV = goodsImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(15.0))
        nameLb.numberOfLines = 2
        topBgview.addSubview(nameLb)
        self.goodsNameLb = nameLb
        
        let goodsStarDesLb = UILabel()
        goodsStarDesLb.textColor = kRGB(r: 165, g: 164, b: 192)
        goodsStarDesLb.font = kFont(adaptW(13.0))
        topBgview.addSubview(goodsStarDesLb)
        
        topBgview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight + adaptW(12.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.width.equalTo(kScreenW - adaptW(15.0)*2)
        }
        goodsImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(8.0))
            make.top.equalToSuperview().offset(adaptW(12.0))
            make.size.equalTo(CGSize(width: adaptW(88.0), height: adaptW(88.0)))
            make.bottom.equalToSuperview().offset(adaptW(-12.0))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(goodsImgV).offset(adaptW(5.0))
            make.left.equalTo(goodsImgV.snp.right).offset(adaptW(10.0))
            make.right.equalToSuperview().offset(-adaptW(7.0))
        }
        goodsStarDesLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(goodsImgV).offset(-adaptW(5.0))
            make.left.equalTo(nameLb)
            make.height.equalTo(adaptW(12.0))
        }
        
        for i in 0..<5 {
            let starBt = UIButton()
            starBt.setImage(UIImage(named: "shop_jinbi"), for: .normal)
            starBt.setImage(UIImage(named: "pay_comment_star_sel"), for: .selected)
            starBt.tag = 100 + i
            starBt.addTarget(self, action: #selector(clickChooseStar(_:)), for: .touchUpInside)
            topBgview.addSubview(starBt)
            starBt.snp.makeConstraints { (make) in
                make.left.equalTo(goodsStarDesLb.snp.right).offset(adaptW(10.0 + (20.0 + 10.0) * CGFloat(i)))
                make.centerY.equalTo(goodsStarDesLb)
                make.size.equalTo(CGSize(width: adaptW(20.0), height: adaptW(20.0)))
   
            }
            goodsStars.append(starBt)
        }
        
        //MARK: ------------comment------------
        let contentTV = GrowingTextView()
        contentTV.backgroundColor = MetricGlobal.mainCellBgColor
        contentTV.placeholder = "跟大家分享您的宝贝吧"
        contentTV.placeholderColor = kRGB(r: 229, g: 229, b: 229)
        contentTV.textColor = .white
        contentTV.font = kFont(adaptW(13.0))
        scrollview.addSubview(contentTV)
        
        contentTV.snp.makeConstraints { (make) in
            make.top.equalTo(topBgview.snp.bottom).offset(adaptW(10.0))
            make.right.equalToSuperview().offset(-adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(10.0))
            make.height.equalTo(adaptW(100.0))
        }
        
        //MARK: ------------添加图片视频------------
        let videoBgView = UIView()
        videoBgView.backgroundColor = MetricGlobal.mainCellBgColor
        scrollview.addSubview(videoBgView)
        let tapG = UITapGestureRecognizer(target: self , action: #selector(tapChoose))
        videoBgView.addGestureRecognizer(tapG)
        
        let vImgV = UIImageView()
        vImgV.contentMode = .scaleAspectFill
        vImgV.clipsToBounds = true
        vImgV.image = UIImage(named: "comment_addVideo")
        videoBgView.addSubview(vImgV)
 
        let vTitle = UILabel()
        vTitle.text = "添加合规的图片/视频即可获得10ETH"
        vTitle.textColor = kRGB(r: 229, g: 229, b: 229)
        vTitle.font = kFont(adaptW(13.0))
        videoBgView.addSubview(vTitle)
        self.goodsNameLb = nameLb
        
        videoBgView.snp.makeConstraints { (make) in
            make.top.equalTo(contentTV.snp.bottom).offset(adaptW(10.0))
            make.right.equalToSuperview().offset(-adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(10.0))
            make.height.equalTo(adaptW(100.0))
        }
        vImgV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(25.0))
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(35.0), height: adaptW(35.0)))
        }
        vTitle.snp.makeConstraints { (make) in
            make.top.equalTo(vImgV.snp.bottom).offset(-adaptW(10.0))
            make.centerX.equalToSuperview()
            make.height.equalTo(adaptW(12.0))
        }
        
        //MARK: ------------发表评价button------------
        let postBt = UIButton()
        postBt.backgroundColor = MetricGlobal.mainBlue
        postBt.setTitle("发表评论", for: .normal)
        postBt.setTitleColor(.white, for: .normal)
        postBt.titleLabel?.font = kFont(adaptW(15.0))
        postBt.layer.cornerRadius = adaptW(22.0)
//        postBt.layer.masksToBounds = true
        postBt.addTarget(self, action: #selector(clickPost(_:)), for: .touchUpInside)
        scrollview.addSubview(postBt)
        postBt.snp.makeConstraints { (make) in
            make.top.equalTo(videoBgView.snp.bottom).offset(adaptW(60.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(44.0))
            make.bottom.equalToSuperview().offset(-kBottomH - adaptW(-20.0))
        }
    }
    
    
    @objc private func clickChooseStar(_ sender: UIButton) {
        
        let index = sender.tag - 100
        
        for bt in goodsStars {
            let tag = bt.tag - 100
            bt.isSelected = tag <= index ? true : false
            
        }
    }
    
    @objc private func tapChoose() {
        
    }
    
    @objc private func clickPost(_ sender: UIButton) {
        clickPostButton?()
        
    }
}
