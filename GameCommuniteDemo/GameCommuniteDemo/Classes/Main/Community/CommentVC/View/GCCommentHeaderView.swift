//
//  GCCommentHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

protocol GCCommentHeaderViewDelegate: class {
    func headerView(_ headerView: GCCommentHeaderView, didClickLike button: UIButton)
    func headerViewDidBeTaped(_ headerView: GCCommentHeaderView)
}

class GCCommentHeaderView: UITableViewHeaderFooterView, Reusable {
    
    var model: GCCommentModel?
    
    weak var delegate: GCCommentHeaderViewDelegate?
    
    private var iconImgView: UIImageView!
    private var titleLb: UILabel!
    private var timeLb: UILabel!
    private var contentLb: UILabel!
    var likeNumBt: UIButton!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: GCCommentModel) {
        self.model = model
        if let img = model.user?.avatar {
            iconImgView.kfSetImage(
                url: img,
                targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
                cornerRadius: adaptW(43.0/2)
            )
        }
        timeLb.text = model.createdAt
        titleLb.text = model.user?.name
        contentLb.text = model.content
        likeNumBt.setTitle("\(model.likeCount ?? 0)", for: .normal)
        likeNumBt.layoutButton(style: .Left, imageTitleSpace: 5.0)
        likeNumBt.isSelected = model.isLike ?? false
    }
    
}

extension GCCommentHeaderView {
    
    private func initUI(){

        backgroundColor = MetricGlobal.mainCellBgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapComment))
        addGestureRecognizer(tap)
        
        
        let iconImgV = UIImageView()
        iconImgV.contentMode = .scaleAspectFill
        addSubview(iconImgV)
        self.iconImgView = iconImgV
        
        let nameLb = UILabel()
        nameLb.textColor = .white
        nameLb.font = kFont(adaptW(14.0), MetricGlobal.mainMediumFamily)
        addSubview(nameLb)
        self.titleLb = nameLb
        
        let timeLb = UILabel()
        timeLb.textColor = kRGB(r: 165, g: 164, b: 192)
        timeLb.font = kFont(adaptW(11.0))
        addSubview(timeLb)
        self.timeLb = timeLb
        
        let contentLb = UILabel()
        contentLb.textColor = kRGB(r: 209, g: 208, b: 231)
        contentLb.font = kFont(adaptW(13.0))
        contentLb.numberOfLines = 0
        addSubview(contentLb)
        self.contentLb = contentLb

        let likeBt = UIButton()
        likeBt.setTitleColor(.white, for: .normal)
        likeBt.titleLabel?.font = kFont(11.0)
        likeBt.setImage(UIImage(named: "communite_like"), for: .normal)
        likeBt.setImage(UIImage(named: "communite_like_sel"), for: .selected)
        likeBt.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
        addSubview(likeBt)
        self.likeNumBt = likeBt
        
        iconImgV.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(adaptW(15.0))
            make.size.equalTo(CGSize(width: adaptW(43.0), height: adaptW(43.0)))
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(8.0))
            make.top.equalTo(iconImgV)
            make.height.equalTo(adaptW(15.0))
        }
        timeLb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb)
            make.top.equalTo(titleLb.snp.bottom).offset(adaptW(5.0))
            make.height.equalTo(adaptW(12.0))
        }
        likeBt.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.centerY.equalTo(titleLb)
            make.height.equalTo(adaptW(22.0))
        }
        contentLb.snp.makeConstraints { (make) in
            make.left.equalTo(timeLb)
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.top.equalTo(timeLb.snp.bottom).offset(adaptW(10.0))
            make.bottom.equalToSuperview().offset(-adaptW(5.0))
        }
    }
    
    @objc func clickLike(_ sender: UIButton) {
        delegate?.headerView(self, didClickLike: sender)
    
    }
    
    @objc func tapComment() {
        delegate?.headerViewDidBeTaped(self)
    }
}
