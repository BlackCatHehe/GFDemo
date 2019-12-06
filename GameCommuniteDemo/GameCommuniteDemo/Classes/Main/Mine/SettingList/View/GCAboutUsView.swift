//
//  GCAboutUsView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
class GCAboutUsView: UIView {
 
    private let titles = ["客服电话", "工作日", "客服邮箱"]
    
    private var versionLb: UILabel!
    private var phoneLb: UILabel!
    private var timeLb: UILabel!
    private var emailLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(){
        
        self.versionLb.text = "1.0.0"
        
        self.phoneLb.text = "101-0000000"
        self.timeLb.text = "9：00-18：00"
        self.emailLb.text = "XXXX@XXXX.com"
    }
}

extension GCAboutUsView {
    
    private func initUI() {
        self.backgroundColor = MetricGlobal.mainCellBgColor
        
        //TODO: ------------图标-------------
        let iconImgV = UIImageView()
        iconImgV.contentMode = .scaleAspectFit
        iconImgV.image = UIImage(named: "pay_result")
        self.addSubview(iconImgV)
        
        let titleLb = UILabel()
        titleLb.textColor = .white
        titleLb.font = kFont(adaptW(15.0))
        titleLb.textAlignment = .center
        self.addSubview(titleLb)
        self.versionLb = titleLb
        
        iconImgV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: adaptW(92.0), height: adaptW(92.0)))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(adaptW(47.0))
        }
        titleLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImgV.snp.bottom).offset(adaptW(16.5))
            make.height.equalTo(adaptW(14.0))
        }
        
        //TODO: ------------图标-------------
        for i in 0..<3 {
            let bgView = UIView()
            self.addSubview(bgView)
            
            let nameLb = UILabel()
            nameLb.textColor = .white
            nameLb.font = kFont(adaptW(15.0))
            nameLb.textAlignment = .center
            nameLb.text = titles[i]
            bgView.addSubview(nameLb)
            
            let contentLb = UILabel()
            contentLb.textColor = .white
            contentLb.font = kFont(adaptW(15.0))
            contentLb.textAlignment = .center
            bgView.addSubview(contentLb)
            switch i {
            case 0:
                self.phoneLb = contentLb
            case 1:
                self.timeLb = contentLb
            default:
                self.emailLb = contentLb
            }
            
            bgView.snp.makeConstraints { (make) in
                make.top.equalTo(titleLb.snp.bottom).offset(adaptW(40.0 + 46.0*CGFloat(i)))
                make.left.right.equalToSuperview()
                make.height.equalTo(adaptW(46.0))
                if i == 2 {
                    make.bottom.equalToSuperview()
                }
            }
            nameLb.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(adaptW(15.5))
                make.centerY.equalToSuperview()
                make.height.equalTo(adaptW(14.0))
            }
            contentLb.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-adaptW(15.5))
                make.left.greaterThanOrEqualTo(nameLb.snp.right).offset(10.0)
                make.centerY.equalToSuperview()
                make.height.equalTo(adaptW(14.0))
            }
            
            if i != 2 {
                let lineV = UIView()
                lineV.backgroundColor = kRGB(r: 56, g: 54, b: 86)
                bgView.addSubview(lineV)
                lineV.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(adaptW(15.5))
                    make.right.bottom.equalToSuperview()
                    make.height.equalTo(1.0)
                }
            }

        }
    }
    
}
