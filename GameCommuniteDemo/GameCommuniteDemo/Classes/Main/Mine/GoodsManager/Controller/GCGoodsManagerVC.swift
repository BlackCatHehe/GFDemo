//
//  GCGoodsManagerVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import TYPagerController
import ObjectMapper
fileprivate struct Metric{
    
    static let pagerBarNormalFontSize = kFont(15.0)
    static let pagerBarSelectedFontSize = kFont(16.0)
    static let pagerBarHeight: CGFloat = 44.0
    static let progressLineColor: UIColor = .white
    static let selectTitleColor: UIColor = .white
    
}

class GCGoodsManagerVC: GCBaseVC {

    
    private let titles = ["在售中", "已下架"]

    private let statusV: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = MetricGlobal.mainBarColor
        return view
    }()
    
    private let pageVC = TYTabPagerController().then{
        $0.view.backgroundColor = .white
        $0.pagerController.view.backgroundColor = MetricGlobal.mainBarColor
        $0.pagerController.scrollView?.backgroundColor = .white
        $0.pagerController.scrollView?.bounces = false
        $0.tabBar.layout.progressColor = Metric.progressLineColor
        $0.tabBar.layout.normalTextColor = Metric.selectTitleColor
        $0.tabBar.layout.selectedTextColor = Metric.selectTitleColor
        $0.tabBar.layout.progressHeight = 3.0
        $0.tabBar.layout.progressWidth = adaptW(15.0)
        $0.tabBar.layout.progressRadius = 2.0
        //$0.tabBar.layout.cellSpacing = adaptW(20.0)
        $0.tabBar.layout.cellEdging = adaptW(15.5)
        $0.tabBar.layout.normalTextFont = Metric.pagerBarNormalFontSize
        $0.tabBar.layout.selectedTextFont = Metric.pagerBarSelectedFontSize
        $0.tabBar.layout.adjustContentCellsCenter = true
        $0.tabBarHeight = Metric.pagerBarHeight
        $0.tabBar.backgroundColor = MetricGlobal.mainBarColor
    }
    
    private lazy var postBt: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: adaptW(70.0), height: adaptW(30.0)))
        button.setTitle("发布商品", for: .normal)
        button.titleLabel?.font = kFont(adaptW(14.0))
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MetricGlobal.mainBlue
        button.layer.cornerRadius = adaptW(15.0)
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "商品管理"
    
        initPostBt()
        initPageController()
    }
}

extension GCGoodsManagerVC {
    
    private func initPageController(){
        //1.添加pagevc为自控制器，并将其view添加到self
        //        pageVC.tabBar.layout.cellWidth = kScreenW / CGFloat(titles.count)
        addChild(pageVC)
        view.addSubview(pageVC.view)
        
        //2.设置pagevc代理
        pageVC.delegate = self
        pageVC.dataSource = self
        
        //3.设置pagevc视图的约束
        pageVC.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
        }
        
        //4.记得设置过视图后先刷新数据
        pageVC.reloadData()
        
        //5.设置pagevc的默认显示vc
        pageVC.pagerController.scrollToController(at: 0, animate: false)
    }
    
    private func initStatusMaskView() {
        view.addSubview(statusV)
        statusV.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kStatusBarheight)
        }
    }
    
    private func initPostBt(){
        
        let customItem = UIBarButtonItem(customView: postBt)
        self.navigationItem.rightBarButtonItem = customItem
        
        postBt.rx.tap
            .bind{[weak self] in
                let vc = GCPostNewGoodsVC()
                self?.push(vc)
        }.disposed(by: rx.disposeBag)
    }
}

extension GCGoodsManagerVC: TYTabPagerControllerDelegate, TYTabPagerControllerDataSource {
    
    func numberOfControllersInTabPagerController() -> Int {
        return titles.count
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, controllerFor index: Int, prefetching: Bool) -> UIViewController {
        let vc = GCGoodsManagerListVC()
        vc.isXia = index == 0 ? false : true
        return vc
    
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, titleFor index: Int) -> String {
        
        let title = titles[index]

        return title
    }
}

extension GCGoodsManagerVC {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if otherGestureRecognizer.view!.isKind(of: NSClassFromString("UIScrollView")!.self) {
            if otherGestureRecognizer.state == UIGestureRecognizer.State.began && pageVC.pagerController.scrollView!.contentOffset == .zero {
                return true
            }
        }
        return false
    }
}


