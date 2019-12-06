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
import ObjectMapper
import NIMSDK
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
    
    ///userModel 绝对不能为nil
    var userModel: UserModel?
    
    private var titles: [String] = ["发帖"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskNavigationBar(with: titleLb)

        self.componentInstall(with: JYNavigationComponents.more) {[weak self] (model) in
            self?.alertMore()
        }
        initUI()
        initData()
        
        reqeustUserMsg()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundColor(bgColor: .clear, shadowColor: .clear)
    }

    
    //MARK: -------------lazyload--------------
    private lazy var titleLb: UILabel = {
        let label = UILabel()
        label.text = "个人主页"
        label.textColor = .white
        label.font = kFont(adaptW(18.0), MetricGlobal.mainMediumFamily)
        label.backgroundColor = nil
        label.alpha = 0
        return label
    }()
    
    private lazy var headerV: GCPeopleHeaderView = {
        let headerView = GCPeopleHeaderView(frame: .zero)
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
        headerV.delegate = self
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
    
    ///设置header用户信息
    private func initData() {
        guard let model = userModel else{
            return
        }
        headerV.setModel(isFollowed: false, model: model)
    }
    
    ///弹出更多（黑名单，举报）
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
    
        present(alertVC, animated: true, completion: nil)
    }
    
    ///弹出取消关注
    private func alertCancelFollow(){
        let alertVC = GCAlertController()
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
        preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(58.0*2 + 1.0 + 7.0) - kBottomH, width: kScreenW, height: adaptW(58.0*2 + 1.0 + 7.0))
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = preAniVC
        alertVC.secondTitle = "取消关注"
        alertVC.isSingle = true
        alertVC.clickChoose = {[weak self] index in
            if index == 1 {
                self?.requestFollow(isFollow: false)
            }
        }
        
        present(alertVC, animated: true, completion: nil)
    }
    
    ///添加黑明单
    private func addBlackMember() {
        
    }
    
    ///举报
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
        
        let vc = GCTieziVC()
        vc.isPeople = true
        vc.communiteId = String(userModel!.id!)
        return vc
     
    }
}
//MARK: ------------GCPeopleHeaderViewDelegate------------
extension GCPeopleMainPageVC: GCPeopleHeaderViewDelegate {
    func headerViewDidClickFollow(headerView: GCPeopleHeaderView) {
        
        if headerView.isFollowed == true {
            alertCancelFollow()
        }else {
            requestFollow(isFollow: true)
        }
    }
    
    func headerViewDidClickFollowMsgTo(headerView: GCPeopleHeaderView) {
        
        if let yxacc = userModel?.neteasyAccid {
            JYLog("云信accountID：\(yxacc)")
            let chatSession = NIMSession(yxacc, type: .P2P)
            
            let chatVC = GCChatVC(chat: chatSession)
            push(chatVC)
            
        }
    }
}

//MARK: ------------滑动导航栏透明度------------
extension GCPeopleMainPageVC {
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let scrollDirection = scrollView.panGestureRecognizer.velocity(in: scrollView)
        print(scrollDirection.y, offsetY, self.pagingView.pinSectionHeaderVerticalOffset)
        if offsetY >= kStatusBarheight + kNavBarHeight {
            self.pagingView.pinSectionHeaderVerticalOffset = Int(kStatusBarheight + kNavBarHeight)
        }else {
            self.pagingView.pinSectionHeaderVerticalOffset = 0
            scrollView.contentInset = .zero
        }
        
        let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var percent = offsetY/(height-(kStatusBarheight + kNavBarHeight))
        percent = max(0, min(percent, 1))
        self.setBackgroundColor(bgColor: kRGBA(r: 24, g: 23, b: 40, a: percent), shadowColor: .clear)
        self.titleLb.alpha = percent
    }
}

//MARK: ------------pop手势和分页的冲突处理------------
extension GCPeopleMainPageVC {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if otherGestureRecognizer.view!.isKind(of: NSClassFromString("UIScrollView")!.self) {
            if otherGestureRecognizer.state == UIGestureRecognizer.State.began && pagingView.mainTableView.contentOffset == .zero {
                return true
            }
        }
        return false
    }
}

//MARK: ------------请求------------
extension GCPeopleMainPageVC {
    
    private func requestFollow(isFollow: Bool) {
        
        guard let uId = userModel?.id else {
            showToast("获取用户信息失败,请重试")
            return
        }
        let target = isFollow ? GCNetApi.follow(userId: uId) : GCNetApi.cancelFollow(prama: uId)
        
        GCNetTool.requestData(target: target, controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            if let msg = result["message"] as? String {
                self.showToast(msg)
            }
            self.headerV.isFollowed = isFollow
        }) { (error) in
            
        }
        
    }
    
    private func reqeustUserMsg() {
        guard let uid = userModel?.id else {
            showToast("获取用户信息失败,请重试")
            return
        }
        GCNetTool.requestData(target: GCNetApi.getUserInfo(uId: uid), controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            
            if let model = Mapper<UserModel>().map(JSON: result) {
                self.userModel = model
            }
        }) { (error) in
            
        }
    }
}
