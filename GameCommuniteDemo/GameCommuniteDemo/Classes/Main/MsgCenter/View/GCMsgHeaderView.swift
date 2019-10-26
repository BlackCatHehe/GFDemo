//
//  GCMsgHeaderView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCMsgHeaderView: UIView {

    var clickCateButton: ((Int)->())?
    
    var bgImgView: UIImageView!
    
    var cateBgView: UIView!
    
    var leftCate: UIImageView!
    var centerCate: UIImageView!
    var rightCate: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel() {
        bgImgView.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2164478293,4167951289&fm=26&gp=0.jpg")!)
        leftCate.showBadgeDot()
        centerCate.showBadge(num: "22")
    }

}

extension GCMsgHeaderView {
    
    private func initUI(){
        self.backgroundColor = MetricGlobal.mainBgColor
        
        
        let bgImgV = UIImageView()
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.clipsToBounds = true
        self.addSubview(bgImgV)
        self.bgImgView = bgImgV
        bgImgV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(adaptW(170.0))
            make.bottom.equalToSuperview().offset(-adaptW(50.0))
        }
        
        let bgCateView = UIView()
        bgCateView.backgroundColor = MetricGlobal.mainCellBgColor
        bgCateView.layer.cornerRadius = adaptW(10.0)
        bgCateView.layer.masksToBounds = true
        bgCateView.backgroundColor = MetricGlobal.mainCellBgColor
        self.addSubview(bgCateView)
        self.cateBgView = bgCateView
        bgCateView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
        }
        
        let cates = ["优惠活动", "通知消息", "互动消息"]
        let imgs = ["msg_youhui", "msg_noti", "msg_youhui"]
        for i in 0...2 {
            let subBgV = UIView()
            subBgV.tag = 100 + i
            bgCateView.addSubview(subBgV)
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCate(_:)))
            subBgV.addGestureRecognizer(tap)
            
            let imgV = UIImageView()
            imgV.image = UIImage(named: imgs[i]) 
            if i == 0 {
                self.leftCate = imgV
            }else if i == 1 {
                self.centerCate = imgV
            }else {
                self.rightCate = imgV
            }
            subBgV.addSubview(imgV)
            
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            label.font = kFont(adaptW(13.0))
            label.text = cates[i]
            subBgV.addSubview(label)
            
            subBgV.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(32.0 + (45.0 + 65.0)*CGFloat(i)))
                make.top.bottom.equalToSuperview()
            }
            imgV.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(adaptW(12.0))
                make.size.equalTo(CGSize(width: adaptW(52.0), height: adaptW(52.0)))
                make.centerX.equalToSuperview()
            }
            label.snp.makeConstraints { (make) in
                make.top.equalTo(imgV.snp.bottom).offset(adaptW(10.0))
                make.left.right.equalToSuperview()
                make.height.equalTo(adaptW(13.0))
                make.bottom.equalToSuperview().offset(-adaptW(10.0))
            }
        }
    }
    
    
    @objc private func tapCate(_ ges: UITapGestureRecognizer){
        
        if let tag = ges.view?.tag {
            clickCateButton?(tag)
        }
    }
}
