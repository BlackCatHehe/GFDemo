//
//  NFBaseVC.swift
//  NationalFace
//
//  Created by APP on 2019/7/26.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SnapKit
import Toast_Swift
import Kingfisher
class GCBaseVC: UIViewController {
    
    //没有数据view
    lazy var noDataView: GCNoDataView = {
        let cView = GCNoDataView()
        cView.imageStr = "noData"
        cView.title = "暂无数据"
        return cView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        
        setBackItem()
        setBackgroundColor(bgColor: kRGB(r: 24, g: 23, b: 40), shadowColor: .clear)
        setTitleAttri(color: .white, font: kFont(adaptW(18.0), "HelveticaNeue-Medium"))
        view.backgroundColor = MetricGlobal.mainBgColor
    }
    
    //展示无数据view
    func showNoData() {
        view.addSubview(noDataView)
        noDataView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    //隐藏无数据view
    func hiddenNoData() {
        if view.subviews.contains(noDataView) {
            noDataView.removeFromSuperview()
        }
    }
    
    ///弹出信息
    func showToast(_ msg: String, position: ToastPosition = .center) {

        view.showToast(msg, position)
    }
    
    ///快速push
    func push(_ vc: UIViewController, animated: Bool = true) {
        
        vc.hidesBottomBarWhenPushed = true//push时隐藏tabbar
        
        navigationController?.pushViewController(vc, animated: animated)
        
    }
    
    ///快速返回，无论是push进来的还是present进来的
    func dismissOrPop(_ animated: Bool = true) {
        
        if self.presentingViewController != nil {
            self.dismiss(animated: animated, completion: nil)
        }else {

            navigationController?.popViewController(animated: animated)
        }
    }
    
    ///设置返回按钮
    func setBackItem(title: String = "", tintColor: UIColor = kRGB(r: 4, g: 4, b: 4)) {
        
        //        let backItem = UIBarButtonItem(title: title, style: .done, target: nil, action: nil)
        
        let backItem = UIBarButtonItem(image: UIImage(named: "navigation_back")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickPop))
        backItem.tintColor = tintColor
        navigationItem.leftBarButtonItem = backItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
    }
    
    @objc private func clickPop() {
        navigationController?.popViewController(animated: true)
    }

}

extension GCBaseVC: UIGestureRecognizerDelegate {}
extension GCBaseVC: JYNavigationComponentProtocol {}
