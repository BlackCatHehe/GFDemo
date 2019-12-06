//
//  GCTieziDetailView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCTieziDetailView: UIView {

    private var iconImgV: UIImageView!
    private var nameLb: UILabel!
    private var timeLb: UILabel!
    private var titleLb: UILabel!
    private var contentLb: UILabel!
    private var picsView: UIView!
    private var goodsView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: GCTopicModel) {
        if let img = model.user?.avatar {
            iconImgV.kfSetImage(url: img, targetSize: .zero, cornerRadius: adaptW(24.0))
        }
        
        nameLb.text = model.user?.name
        timeLb.text = "上架时间:\(model.createdAt!)"
        titleLb.text = model.title
        contentLb.text = model.body
        
        //TODO:------setModel =====  图片列表
         let imgs = model.images ?? []
        
        //设置图片
        var imgvs: [UIImageView] = []
        for _ in imgs {
            let imgV = UIImageView()
            imgV.contentMode = .scaleAspectFit
            picsView.addSubview(imgV)
            imgvs.append(imgV)
        }
        if !imgvs.isEmpty {
           _ = imgvs.reduce(imgvs.first!) { (beforeImgV, currentImgV) -> UIImageView in
                currentImgV.snp.makeConstraints { (make) in
                    if beforeImgV === currentImgV {//第一个头部和superview对齐
                        make.top.equalToSuperview().offset(adaptW(10.0))
                    }else {
                        make.top.equalTo(beforeImgV.snp.bottom).offset(adaptW(10.0))
                    }
                    make.height.equalTo(0)
                    make.left.right.equalToSuperview()
                    if currentImgV == imgvs.last! {//最后一个底部和superview对齐
                        make.bottom.equalToSuperview()
                    }
                }
                return currentImgV
            }
        }
        //设置完imgview约束后再设置图片来更新高度
        //（先设置图片有可能会存在约束没有设置的情况下直接更新而报错）
        for (img, imgV) in zip(imgs, imgvs) {
            imgV.kf.setImage(with: URL(string: img)!, placeholder: nil, options: nil, progressBlock: nil) {[weak imgV] (img, _, _, _) in
                guard let imageV = imgV else {return}
                guard let image = img else {return}
                imageV.snp.updateConstraints({ (make) in
                    make.height.equalTo(image.getImageHeight(width: kScreenW - adaptW(15.0*2)))
                })
                imageV.image = image
            }
        }
        
        //TODO:------setModel =====  关联商品列表
        
        guard let associaGoodsNum = model.ornamentId, associaGoodsNum != 0 else {return}
        guard let goodsModel = model.ornament else {return}
        let goodsV = GCAssociateGoodsView()
        goodsV.setModel(goodsModel)
        goodsView.addSubview(goodsV)
        goodsV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(10))
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
  
        }
    }
}

extension GCTieziDetailView {
    
    private func initUI() {
        
        let scrollView = UIScrollView()
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //TODO: ----------user视图-----------
        let userBgView = UIView()
        userBgView.backgroundColor = MetricGlobal.mainBgColor
        scrollView.addSubview(userBgView)
        
        let iconImgV = UIImageView()
        iconImgV.contentMode = .scaleAspectFill
        userBgView.addSubview(iconImgV)
        self.iconImgV = iconImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        userBgView.addSubview(nameLb)
        self.nameLb = nameLb
        
        let timeLb = UILabel()
        timeLb.textColor = MetricGlobal.mainGray
        timeLb.font = kFont(adaptW(12.0), MetricGlobal.mainMediumFamily)
        userBgView.addSubview(timeLb)
        self.timeLb = timeLb
        
        userBgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(10.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(73.0))
            make.width.equalTo(kScreenW)
        }
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(49.0), height: adaptW(49.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgV.snp.top).offset(adaptW(6.0))
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(7.0))
            make.right.greaterThanOrEqualToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(14.0))
        }
        timeLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconImgV.snp.bottom).offset(-adaptW(6.0))
            make.left.equalTo(nameLb)
            make.right.greaterThanOrEqualToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(12.0))
        }
        
        
        //TODO: ----------文字内容-----------
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(16.0), MetricGlobal.mainMediumFamily)
        scrollView.addSubview(titleLb)
        self.titleLb = titleLb
        
        let contentLb = UILabel()
        contentLb.textColor = MetricGlobal.mainGray
        contentLb.font = kFont(adaptW(13.0))
        contentLb.numberOfLines = 0
        scrollView.addSubview(contentLb)
        self.contentLb = contentLb
        
        titleLb.snp.makeConstraints { (make) in
            make.top.equalTo(userBgView.snp.bottom).offset(adaptW(15.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(14.0))
        }
        contentLb.snp.makeConstraints { (make) in
            make.top.equalTo(titleLb.snp.bottom).offset(adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        
        //TODO: ----------图片内容-----------
        let picBgView = UIView()
        scrollView.addSubview(picBgView)
        picsView = picBgView
        picBgView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLb.snp.bottom)
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        
        //TODO: ----------商品内容-----------
        let goodsBgView = UIView()
        scrollView.addSubview(goodsBgView)
        goodsView = goodsBgView
        goodsBgView.snp.makeConstraints { (make) in
            make.top.equalTo(picBgView.snp.bottom)
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.bottom.equalToSuperview().offset(-kBottomH - adaptW(70.0))
        }
    }
}

class GCAssociateGoodsView: UIView {
    
    private var goodsImgV: UIImageView!
    
    private var goodsNameLb: UILabel!
    
    private var subTitleLb: UILabel!
    
    private var moneyBt: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: GCGoodsModel) {
        if let img = model.cover  {
            goodsImgV.kfSetImage(
                url: img,
                targetSize: CGSize(width: adaptW(70.0), height: adaptW(70.0)),
                cornerRadius: adaptW(5.0)
            )
        }
        
        goodsNameLb.text = model.name
        subTitleLb.text = model.content
        moneyBt.setTitle("\(model.price ?? "0.00")ETC", for: .normal)
        
    }
    
}

extension GCAssociateGoodsView {
    
    private func initUI(){
        layer.cornerRadius = adaptW(3.0)
        layer.masksToBounds = true
        
        backgroundColor = MetricGlobal.mainCellBgColor
        
        let iconImgV = UIImageView()
        addSubview(iconImgV)
        goodsImgV = iconImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(15.0), MetricGlobal.mainMediumFamily)
        addSubview(nameLb)
        goodsNameLb = nameLb
        
        let subLabel = UILabel()
        subLabel.textColor = MetricGlobal.mainGray
        subLabel.font = kFont(adaptW(12.0), MetricGlobal.mainMediumFamily)
        addSubview(subLabel)
        subTitleLb = subLabel
        
        let moneyBt = UIButton()
        moneyBt.setImage(UIImage(named: "icon_silver"), for: .normal)
        moneyBt.setTitleColor(.white, for: .normal)
        moneyBt.titleLabel?.font = kFont(adaptW(12.0))
        addSubview(moneyBt)
        self.moneyBt = moneyBt
        
        iconImgV.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(adaptW(5.0))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(70.0), height: adaptW(70.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgV)
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(8.0))
            make.right.greaterThanOrEqualToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(14.0))
        }
        subLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLb.snp.bottom).offset(adaptW(6.0))
            make.left.equalTo(nameLb)
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(14.0))
        }
        moneyBt.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconImgV)
            make.left.equalTo(nameLb)
            make.height.equalTo(adaptW(17.0))
        }
    }
}
