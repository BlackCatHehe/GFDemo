//
//  GCPeopleMainPageVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import JXSegmentedView
import JXPagingView

fileprivate struct Metric{
    
    static let pagerBarNormalFontSize = kFont(adaptW(16.0))
    static let pagerBarSelectedFontSize = kFont(adaptW(16.0), MetricGlobal.mainMediumFamily)
    static let pagerBarHeight: CGFloat = adaptW(49.0)
    static let progressLineColor: UIColor = .white
    static let selectTitleColor: UIColor = .white
    static let normalTitleColor: UIColor = .white
    static let headerH: CGFloat = adaptW(180.0)
    static let pageTopX: CGFloat = isIPhoneX() ? 22 + kStatusBarheight : kStatusBarheight
}
class GCPeopleMainPageVC: GCBaseVC {
    
    private var titles: [String] = ["发帖", "评论", "回帖"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor(bgColor: .clear, shadowColor: .clear)
        
        self.componentInstall(with: JYNavigationComponents.more) {[weak self] (model) in
            self?.alertMore()
        }
        
        initUI()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//
//    }
    
    //MARK: -------------lazyload--------------
    private lazy var headerV: GCPeopleHeaderView = {
        let headerView = GCPeopleHeaderView(frame: .zero)
        headerView.setModel()
        return headerView
    }()
    private lazy var segmentView: JXSegmentedView = {[weak self] in
        let view = JXSegmentedView()
        view.backgroundColor = MetricGlobal.mainCellBgColor
        view.delegate = self
        return view
    }()
    
    private lazy var segmentDataSource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titleNormalFont = Metric.pagerBarNormalFontSize
        dataSource.titleSelectedFont = Metric.pagerBarSelectedFontSize
        dataSource.titleSelectedColor = Metric.selectTitleColor
        dataSource.titleNormalColor = Metric.normalTitleColor
        dataSource.itemContentWidth = JXSegmentedViewAutomaticDimension
        dataSource.itemSpacing = 20.0
        //dataSource.isItemSpacingAverageEnabled = true
        
        return dataSource
    }()
    
    private var pagingView: JXPagingView!
    
    private lazy var lineView: JXSegmentedIndicatorLineView = {
        let lineV = JXSegmentedIndicatorLineView()
        lineV.indicatorColor = Metric.progressLineColor
        lineV.indicatorCornerRadius = 1
        lineV.indicatorWidth = JXSegmentedViewAutomaticDimension
        lineV.indicatorHeight = 2.0
        return lineV
    }()
}

extension GCPeopleMainPageVC {
    
    private func initUI() {
        view.addSubview(headerV)
        
        pagingView = JXPagingView(delegate: self)
        
        view.addSubview(segmentView)
        segmentView.frame = CGRect(x: 0, y: kStatusBarheight, width: kScreenW, height: adaptW(49.0))
        
        segmentDataSource.titles = self.titles
        segmentDataSource.reloadData(selectedIndex: 0)
        segmentView.dataSource = self.segmentDataSource
        segmentView.indicators = [lineView]

        view.addSubview(pagingView)
        pagingView.mainTableView.bounces = false
        
        segmentView.contentScrollView = pagingView.listContainerView.collectionView
        
        pagingView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func alertMore(){
        
        let alertVC = GCAlertController()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(58.0*3 + 1.0 + 7.0) - kBottomH, width: kScreenW, height: adaptW(58.0*3 + 1.0 + 7.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC

        alertVC.firstTitle = "加入黑名单"
        alertVC.secondTitle = "举报该用户"
        alertVC.clickChoose = {[weak self] index in
            index == 0 ? self?.addBlackMember() : self?.clickJubao()
        }
        var rootVC = kWindow?.rootViewController
        while rootVC?.presentedViewController != nil {
            if let vc = rootVC?.presentedViewController {
                if let nvc = vc as? UINavigationController{
                    rootVC = nvc.visibleViewController
                }else if let tvc = vc as? UITabBarController{
                    rootVC = tvc.selectedViewController
                }
            }
            
        }
        rootVC?.present(alertVC, animated: true, completion: nil)
    }
    
    private func addBlackMember() {
        
    }
    private func clickJubao() {
        
    }
}

extension GCPeopleMainPageVC: JXSegmentedViewDelegate, JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return Int(height)
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return headerV
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return Int(adaptW(49.0))
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        
        return GCTieziVC()
    }
}
