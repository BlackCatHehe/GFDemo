//
//  GCRecommendSearchHeaderBar.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

protocol GCRecommendSearchHeaderBarDelegate: UITextFieldDelegate {
    func headerViewDidTapRightButton(_ headerView: GCRecommendSearchHeaderBar)
}

class GCRecommendSearchHeaderBar: UIView {
    
    var text: String? {
        return searchTF?.text
    }
    
    var delegate: GCRecommendSearchHeaderBarDelegate?
    
    private var searchTF: UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    init(frame: CGRect, delegate: GCRecommendSearchHeaderBarDelegate? = nil) {
        self.delegate = delegate
        
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    
    func beFirstResponder() {
        if searchTF!.canBecomeFirstResponder {
            searchTF?.becomeFirstResponder()
        }
    }
    
    func reFirstResponder() {
        if searchTF!.canResignFirstResponder {
            searchTF?.resignFirstResponder()
        }
    }
    
}

extension GCRecommendSearchHeaderBar: JYNavigationComponentProtocol{
    
    private func initUI() {

        let searchViews = self.searchComponentInstall(with: JYNavigationComponents.search, textFieldDelegate: delegate) { (model) in
            self.delegate?.headerViewDidTapRightButton(self)
        }
        guard let searchView = searchViews.first else {return}
        guard let searchTF = searchViews.last as? UITextField else {return}
        searchTF.backgroundColor = MetricGlobal.mainBgColor
        searchView.backgroundColor = MetricGlobal.mainBgColor
        self.searchTF = searchTF
        
        searchView.layer.cornerRadius = 15.0
        self.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-7)
        }
    }
    
}