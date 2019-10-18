//
//  GCCommunityHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

protocol GCCommunityHeaderViewDelegate {
    func headerView(_ headerV: GCCommunityHeaderView, didClickBack button: UIButton)
}

class GCCommunityHeaderView: UIView {

    var delegate: GCCommunityHeaderViewDelegate?
    
    private var bgImageView: UIImageView!
    private var iconImgView: UIImageView!
    private var titleLb: UILabel!
    private var contentLb: UILabel!
    
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
        contentLb.text = "这里是属于热衷魔兽世界的朋友们的专属讨论小组， 大家可以在这里发起话题，畅所欲言.这里是属于热衷魔兽世界的朋友们的专属讨论小组， 大家可以在这里发起话题，畅所欲言"
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
            make.bottom.equalToSuperview().offset(-adaptW(10.0))
        }
        
        //返回按钮
        let bButton = UIButton()
        bButton.setImage(UIImage(named: "recommend_search"), for: .normal)
        bButton.addTarget(self, action: #selector(clickBack(_:)), for: .touchUpInside)
        addSubview(bButton)
        bButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.top.equalToSuperview().offset(kStatusBarheight + adaptW(10.0))
            make.size.equalTo(CGSize(width: adaptW(20.0), height: adaptW(20.0)))
           
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
        
        let contentLb = UILabel()
        contentLb.textColor = kRGB(r: 209, g: 208, b: 231)
        contentLb.font = kFont(adaptW(11.0))
        contentLb.numberOfLines = 2
        bBgView.addSubview(contentLb)
        self.contentLb = contentLb

        let addButton = UIButton()
        addButton.setTitle("加入", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = kFont(14.0)
        addButton.backgroundColor = MetricGlobal.mainButtonBgColor
        addButton.layer.cornerRadius = adaptW(14.0)
        addButton.layer.masksToBounds = true
        addButton.addTarget(self, action: #selector(clickBack(_:)), for: .touchUpInside)
        bBgView.addSubview(addButton)
        
        bBgView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(adaptW(72.0))
        }
        
        addButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.centerY.equalToSuperview()
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
            make.top.equalTo(iconImgV.snp.bottom).offset(-adaptW(10.0))
            make.bottom.equalToSuperview().offset(-adaptW(10.0))
        }
 
    }
    
    @objc private func clickBack(_ sender: UIButton) {
        self.delegate?.headerView(self, didClickBack: sender)
    }
}
