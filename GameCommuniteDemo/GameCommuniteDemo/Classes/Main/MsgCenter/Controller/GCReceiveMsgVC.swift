//
//  GCReceiveMsgVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import TYPagerController

fileprivate struct Metric{
    
    static let pagerBarNormalFontSize = kFont(15.0)
    static let pagerBarSelectedFontSize = kFont(16.0)
    static let pagerBarHeight: CGFloat = 44.0
    static let progressLineColor: UIColor = .white
    static let selectTitleColor: UIColor = .white
    
}

class GCReceiveMsgVC: GCBaseVC {

    private let titles = ["获赞", "评论"]
    

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
        $0.tabBar.layout.cellSpacing = adaptW(20.0)
       // $0.tabBar.layout.cellEdging = adaptW(15.5)
        $0.tabBar.layout.normalTextFont = Metric.pagerBarNormalFontSize
        $0.tabBar.layout.selectedTextFont = Metric.pagerBarSelectedFontSize
        $0.tabBar.layout.adjustContentCellsCenter = true
        $0.tabBarHeight = Metric.pagerBarHeight
        $0.tabBar.backgroundColor = MetricGlobal.mainBarColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "赞和评论"
    
        initPageController()
    }
}

extension GCReceiveMsgVC {
    
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

}


extension GCReceiveMsgVC: TYTabPagerControllerDelegate, TYTabPagerControllerDataSource {
    
    func numberOfControllersInTabPagerController() -> Int {
        return titles.count
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, controllerFor index: Int, prefetching: Bool) -> UIViewController {
        switch index {
        case 0:
            return GCReceiveMsgListVC()
            
        default:
            return GCReceiveMsgListVC()
        }
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, titleFor index: Int) -> String {
        
        let title = titles[index]

        return title
    }
}
