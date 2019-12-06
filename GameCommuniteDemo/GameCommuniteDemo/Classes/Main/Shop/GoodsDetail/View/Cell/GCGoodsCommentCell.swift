//
//  GCGoodsCommentCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/3.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
class GCGoodsCommentCell: UITableViewCell, Reusable {

    private var iconImgV: UIImageView!
    private var nameLb: UILabel!
    private var timeLb: UILabel!
    private var contentLb: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func setModel(_ model: GCCommentModel) {
        if let img = model.user?.avatar {
            iconImgV.kfSetImage(
                url: img,
                targetSize: CGSize(width: adaptW(43.0), height: adaptW(43.0)),
                cornerRadius: adaptW(43.0/2)
            )
        }
        timeLb.text = model.createdAt
        nameLb.text = model.user?.name
        contentLb.text = model.content
    }

}

extension GCGoodsCommentCell {
    
    private func initUI() {
        selectionStyle = .none
        contentView.backgroundColor = MetricGlobal.mainCellBgColor
        
        let userBgView = UIView()
        userBgView.backgroundColor = MetricGlobal.mainCellBgColor
        self.addSubview(userBgView)
        
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
        timeLb.font = kFont(adaptW(12.0))
        timeLb.textAlignment = .right
        userBgView.addSubview(timeLb)
        self.timeLb = timeLb
        
        let contentLb = UILabel()
        contentLb.textColor = MetricGlobal.mainGray
        contentLb.font = kFont(adaptW(13.0))
        contentLb.numberOfLines = 0
        userBgView.addSubview(contentLb)
        self.contentLb = contentLb
        
        userBgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptW(10.0))
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: adaptW(43.0), height: adaptW(43.0)))
        }
        nameLb.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgV.snp.top).offset(adaptW(6.0))
            make.left.equalTo(iconImgV.snp.right).offset(adaptW(7.0))
            make.right.equalTo(timeLb.snp.left).offset(-adaptW(5.0))
            make.height.equalTo(adaptW(16.0))
        }
        timeLb.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLb)
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(adaptW(16.0))
        }
        contentLb.snp.makeConstraints { (make) in
            make.top.equalTo(nameLb.snp.bottom).offset(adaptW(6.0))
            make.left.equalTo(nameLb)
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.bottom.equalToSuperview().offset(adaptW(-10.0))
        }
    }
}
