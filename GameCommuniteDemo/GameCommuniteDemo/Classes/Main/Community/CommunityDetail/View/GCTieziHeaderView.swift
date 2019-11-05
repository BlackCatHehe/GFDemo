//
//  GCTieziHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable
import SnapKit

fileprivate struct Metric {
    static let buttomButtonImages = ["communite_share", "communite_comment", "communite_like"]
    static let imageW = (kScreenW - adaptW(15.0*2 + 10.0))/2
}

protocol GCTieziHeaderViewDelegate {
    func headerView(_ headerV: GCTieziHeaderView, didSelectItemAt index: Int)
}

class GCTieziHeaderView: UITableViewHeaderFooterView, Reusable {

    var delegate: GCTieziHeaderViewDelegate?

    var model: GCTopicModel?
    
    private var iconImgV: UIImageView!
    private var nameLb: UILabel!
    private var timeLb: UILabel!
    
    private var titleLb: UILabel!
    private var contentLb: UILabel!
    
    private var centerContentBgView: UIView!
    
    private var shareBt: UIButton!
    private var commentBt: UIButton!
    private var likeBt: UIButton!
    
    private var subGoodsDetailV: GCTieziSubGoodsView = {
        let goodsV = GCTieziSubGoodsView()
        goodsV.setModel()
        return goodsV
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func setModel(_ model: GCTopicModel) {
        self.model = model
        
        for v in centerContentBgView.subviews {
            v.removeFromSuperview()
        }
 
        iconImgV.kfSetImage(
            url: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
            targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
            cornerRadius: adaptW(43.0)/2
        )
        
        nameLb.text = model.user?.name
        timeLb.text = model.createdAt
        titleLb.text = model.title
        contentLb.text = model.body
        
        shareBt.setTitle(String(model.viewCount!), for: .normal)
        shareBt.layoutButton(style: .Left, imageTitleSpace: 8.0)
        
        commentBt.setTitle(String(model.commentCount!), for: .normal)
        commentBt.layoutButton(style: .Left, imageTitleSpace: 8.0)
        
        likeBt.setTitle(String(model.likeCount!), for: .normal)
        likeBt.layoutButton(style: .Left, imageTitleSpace: 8.0)
        
        for i in 0..<2 {
            let imageV = UIImageView()
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            centerContentBgView.addSubview(imageV)
            imageV.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset((Metric.imageW + adaptW(10.0))*CGFloat(i))
                make.top.bottom.equalToSuperview()
                make.height.equalTo(Metric.imageW * 129.0/167.0)
            }
            
            imageV.kfSetImage(
                url: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
                targetSize: CGSize(width: Metric.imageW, height: Metric.imageW * 129.0/167.0),
                cornerRadius: adaptW(5.0)
            )

        }
        
//    centerContentBgView.addSubview(subGoodsDetailV)
//    subGoodsDetailV.snp.makeConstraints { (make) in
//    make.edges.equalToSuperview()
//    }
    }

}

extension GCTieziHeaderView {
    
    private func initUI() {
        
        self.backgroundColor = MetricGlobal.mainBgColor
        
        //TODO: ----------bg视图-----------
        let bgView = UIView()
        bgView.backgroundColor = MetricGlobal.mainCellBgColor
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        //TODO: ----------user视图-----------
        let userBgView = UIView()
        userBgView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.addSubview(userBgView)
        
        let iconImgV = UIImageView()
        iconImgV.contentMode = .scaleAspectFill
        userBgView.addSubview(iconImgV)
        self.iconImgV = iconImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(14.0), MetricGlobal.mainMediumFamily)
        userBgView.addSubview(nameLb)
        self.nameLb = nameLb
        
        let timeLb = UILabel()
        timeLb.textColor = kRGB(r: 165, g: 164, b: 192)
        timeLb.font = kFont(adaptW(12.0), MetricGlobal.mainMediumFamily)
        userBgView.addSubview(timeLb)
        self.timeLb = timeLb
        
        userBgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(10.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(adaptW(63.0))
        }
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(43.0), height: adaptW(43.0)))
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
        
        //TODO: ----------title-----------
        let tLb = UILabel()
        tLb.font = kFont(adaptW(14.0))
        tLb.textColor = .white
        tLb.preferredMaxLayoutWidth = kScreenW - adaptW(15.0)*2
        bgView.addSubview(tLb)
        self.titleLb = tLb
        tLb.snp.makeConstraints { (make) in
            make.top.equalTo(userBgView.snp.bottom).offset(10.0)
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(15.0))
        }
        
        //TODO: ----------content-----------
        let stLb = UILabel()
        stLb.font = kFont(adaptW(14.0))
        stLb.textColor = MetricGlobal.mainGray
        stLb.preferredMaxLayoutWidth = kScreenW - adaptW(15.0)*2
        stLb.numberOfLines = 0
        bgView.addSubview(stLb)
        self.contentLb = stLb
        stLb.snp.makeConstraints { (make) in
            make.top.equalTo(tLb.snp.bottom).offset(adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.greaterThanOrEqualTo(adaptW(15.0))
        }
        
        //TODO: ----------中间内容（图片，视频，商品）-----------
        let cConView = UIView()
        cConView.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.addSubview(cConView)
        cConView.snp.makeConstraints { (make) in
            make.top.equalTo(stLb.snp.bottom).offset(adaptW(5.0))
            make.left.right.equalTo(stLb)
        }
        self.centerContentBgView = cConView
        
        //TODO: ----------底部(分享，评论，喜欢)-----------
        let bottomButtomsBgV = UIView()
        bottomButtomsBgV.backgroundColor = MetricGlobal.mainCellBgColor
        bgView.addSubview(bottomButtomsBgV)
        bottomButtomsBgV.snp.makeConstraints { (make) in
            make.top.equalTo(cConView.snp.bottom).offset(adaptW(15.0))
            make.left.right.equalTo(stLb)
            make.bottom.equalToSuperview()
        }
        let lineView = UIView()
        lineView.backgroundColor = kRGB(r: 56, g: 54, b: 86)
        bottomButtomsBgV.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1.0)
        }
        for i in 0..<3 {
            let imageStr = Metric.buttomButtonImages[i]
            let button = UIButton()
            button.setImage(UIImage(named: imageStr), for: .normal)
            if i == 2 {
                button.setImage(UIImage(named: "communite_like_sel"), for: .selected)
            }
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = kFont(adaptW(11.0))
            button.tag = 100 + i
            button.addTarget(self, action: #selector(clickButtonButtons(_:)), for: .touchUpInside)
            bottomButtomsBgV.addSubview(button)
            switch i {
            case 0:
                button.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(adaptW(5.0))
                    make.bottom.equalToSuperview().offset(-adaptW(5.0))
                    make.left.equalToSuperview().offset(adaptW(15.0))
                    make.height.equalTo(adaptW(40.0))
                }
                self.shareBt = button
            case 1:
                button.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(adaptW(5.0))
                    make.centerX.equalToSuperview()
                    make.height.equalTo(adaptW(40.0))
                }
                self.commentBt = button
            case 2:
                button.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(adaptW(5.0))
                    make.right.equalToSuperview().offset(-adaptW(15.0))
                    make.height.equalTo(adaptW(40.0))
                }
                self.likeBt = button
            default:
                break
            }
        }
    }

    
    @objc func clickButtonButtons(_ sender: UIButton) {
        
        delegate?.headerView(self, didSelectItemAt: sender.tag - 100)
        
        switch sender.tag - 100 {
        case 0://分享
            JYLog("点击了分享")
        case 1://评论
            JYLog("点击了评论")
        case 2://喜欢
            JYLog("点击了喜欢")
            sender.isSelected = !sender.isSelected
        default:
            break
        }
        
    }
}
