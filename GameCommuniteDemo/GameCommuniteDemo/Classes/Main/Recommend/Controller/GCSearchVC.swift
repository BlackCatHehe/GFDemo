//
//  GCSearchVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import JYTagView
class GCSearchVC: GCBaseVC {

    private let tagView: JYTagView = {
        let tagV = JYTagView()
        tagV.itemHeight = adaptW(28.0)
        tagV.itemSpacing = adaptW(12.0)
        tagV.itemInsetPadding = adaptW(25.0)
        tagV.itemBuilder = {index -> UIView in
            let bt = UIButton()
            bt.setTitle("热搜", for: .normal)
            bt.backgroundColor = kRGB(r: CGFloat(arc4random()%255), g: CGFloat(arc4random()%255), b: CGFloat(arc4random()%255))
            bt.titleLabel?.font = kFont(14.0)
            bt.layer.cornerRadius = adaptW(14.0)
            bt.layer.masksToBounds = true
            return bt
        }
        return tagV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }

}

//MARK: ------------createUI------------
extension GCSearchVC {
    
    private func initUI() {
        view.backgroundColor = MetricGlobal.mainBgColor
        initNaviSearchBar()
        initSearchHistory()
       // initCollectionView()
    }
    
    private func initNaviSearchBar() {
        //0.隐藏返回按钮
        navigationItem.setHidesBackButton(true, animated: true)
        
        //1.搜索
        let naviView = GCRecommendSearchHeaderBar(frame: CGRect(x: 0, y: kStatusBarheight, width: kScreenW - 2*15 - 44*2 - 10, height: kNavBarHeight), delegate: self)
        naviView.beFirstResponder()
        maskNavigationBar(with: naviView)
        
        //2.cancel
        self.componentInstall(with: JYNavigationComponents.searchCancel) { (model) in
            
            self.dismissOrPop()
        }
    }
    
    private func initSearchHistory() {
        let titleSectionV = UIButton()
        titleSectionV.setTitle("热搜", for: .normal)
        titleSectionV.setImage(UIImage(named: "navigation_sao"), for: .normal)
        titleSectionV.titleLabel?.font = kFont(16.0)
        titleSectionV.layoutButton(style: .Left, imageTitleSpace: 5.0)
        view.addSubview(titleSectionV)
        titleSectionV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.top.equalToSuperview().offset(20.0)
            make.width.equalTo(adaptW(60.0))
            make.height.equalTo(adaptW(15.0))
        }
        
        let titles = ["道具", "游戏", "帖子"]
        view.addSubview(self.tagView)
        tagView.snp.makeConstraints { (make) in
            make.top.equalTo(titleSectionV.snp.bottom).offset(adaptW(20.0))
            make.left.equalTo(titleSectionV)
            make.right.equalToSuperview().offset(-15.0)
        }
        tagView.titles = titles
        tagView.reloadData()
    }
}

//MARK: ------------searchbarDelegate------------
extension GCSearchVC: GCRecommendSearchHeaderBarDelegate {
    
    func headerViewDidTapRightButton(_ headerView: GCRecommendSearchHeaderBar) {
        
        
    }
    
}
