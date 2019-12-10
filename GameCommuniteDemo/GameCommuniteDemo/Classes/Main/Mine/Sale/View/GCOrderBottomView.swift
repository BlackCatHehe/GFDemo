//
//  GCOrderBottomView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/9.
//  Copyright © 2019 kuroneko. All rights reserved.
//

protocol GCOrderBottomViewDelegate: class {
    
    func bottomViewDidClickKefu(bottomView: GCOrderBottomView)
    func bottomViewDidClickDelete(bottomView: GCOrderBottomView)
}

class GCOrderBottomView: UIView {
    
    weak var delegate: GCOrderBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GCOrderBottomView {
    
    private func initUI(){
        
        let bgview = UIView()
        bgview.backgroundColor = MetricGlobal.mainCellBgColor
        addSubview(bgview)
        
        let deleteBt = UIButton()
        deleteBt.tintColor = .white
        deleteBt.setTitle("删除订单", for: .normal)
        deleteBt.setTitleColor(.white, for: .normal)
        deleteBt.titleLabel?.font = kFont(adaptW(12.0))
        deleteBt.layer.cornerRadius = adaptW(27.0/2)
        deleteBt.layer.masksToBounds = true
        deleteBt.layer.borderColor = UIColor.white.cgColor
        deleteBt.layer.borderWidth = 1.0
        deleteBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        deleteBt.addTarget(self, action: #selector(clickDelete(_:)), for: .touchUpInside)
        bgview.addSubview(deleteBt)
        
        let kefuBt = UIButton()
        kefuBt.tintColor = .white
        kefuBt.setTitle("联系客服", for: .normal)
        kefuBt.setTitleColor(.white, for: .normal)
        kefuBt.titleLabel?.font = kFont(adaptW(12.0))
        kefuBt.layer.cornerRadius = adaptW(27.0/2)
        kefuBt.layer.masksToBounds = true
        kefuBt.layer.borderColor = UIColor.white.cgColor
        kefuBt.layer.borderWidth = 1.0
        kefuBt.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        kefuBt.addTarget(self, action: #selector(clickKefu(_:)), for: .touchUpInside)
        bgview.addSubview(kefuBt)
        
        bgview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        kefuBt.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-adaptW(20.0))
            make.top.equalToSuperview().offset(adaptW(13.0))
            make.height.equalTo(adaptW(27.0))
        }
        
        deleteBt.snp.makeConstraints { (make) in
            make.right.equalTo(kefuBt.snp.left).offset(-adaptW(10.0))
            make.top.equalToSuperview().offset(adaptW(13.0))
            make.height.equalTo(adaptW(27.0))
        }
        
    }
    
    @objc private func clickKefu(_ sender: UIButton) {
        delegate?.bottomViewDidClickKefu(bottomView: self)
    }
    
    @objc private func clickDelete(_ sender: UIButton) {
        delegate?.bottomViewDidClickDelete(bottomView: self)
    }
    
}
