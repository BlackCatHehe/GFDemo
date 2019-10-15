//
//  NFBaseTabbarController.swift
//  NationalFace
//
//  Created by APP on 2019/7/25.
//  Copyright © 2019 kuroneko. All rights reserved.
//


fileprivate struct Metric {

    static let prefix = "GC"
    static let titles = ["推荐", "社区", "商城", "我的"]
    static let cate = ["Recommend", "Community", "Shop", "Mine"]
}

class GCBaseTabbarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
}

extension GCBaseTabbarController {
    private func setupUI() {
        
        self.tabBar.tintColor = kRGB(r: 0, g: 122, b: 255)
        self.tabBar.barTintColor = MetricGlobal.mainBarColor
        
        for i in 0..<Metric.titles.count {
            let title = Metric.titles[i]
            let imgStr = "tabbar_" + Metric.cate[i]
            let vcStr = kAppNamespace + "." + Metric.prefix + Metric.cate[i] + "VC"
            JYLog(vcStr)
            if let vcClass = NSClassFromString(vcStr) as? GCBaseVC.Type {
                let vc = vcClass.init()
                addTabbarBar(with: vc, title: title, normalImg: UIImage(named: imgStr), selectImg: nil)
            }
        }
    }
    
    /// 快速设置navcontroller的子控制器
    private func addTabbarBar(with controller: UIViewController, title: String, normalImg: UIImage?, selectImg: UIImage?) {
        controller.tabBarItem.title = title
        controller.tabBarItem.image = normalImg
        //controller.hidesBottomBarWhenPushed = true
        controller.tabBarItem.selectedImage = selectImg
        let navVC = UINavigationController(rootViewController: controller)
        navVC.navigationBar.barTintColor = .white
       // navVC.navigationBar.barStyle = .default
        self.addChild(navVC)
    }
}

