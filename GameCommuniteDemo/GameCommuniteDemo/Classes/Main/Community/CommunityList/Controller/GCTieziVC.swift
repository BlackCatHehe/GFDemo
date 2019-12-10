//
//  GCTieziVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import JXPagingView
import ObjectMapper
import MJRefresh
import SwiftyJSON
class GCTieziVC: GCBaseVC {
    ///页面上级对应的类型,true为个人页面，所有帖子都是自己发的，无法点击帖子头像跳转。默认为false
    var isPeople: Bool = false
    ///对应的社区id
    var communiteId: String?
    
    ///数据源
    private var dataList: [GCTopicModel] = []
    
    var tableHeaderV: UIView?
    
    private var currentPage: Int = 1
    
    ///第三方JXPagingView需要遵循的协议必须的回调
    private var scrollBlock: ((UIScrollView)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        requestTopics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundColor(bgColor: .clear, shadowColor: .clear)
    }
    
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .grouped)
        tableV.backgroundColor = MetricGlobal.mainBgColor
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        tableV.estimatedRowHeight = adaptW(30.0)
        tableV.estimatedSectionHeaderHeight = kScreenH
        self?.automaticallyAdjustsScrollViewInsets = false
        self?.extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        }
        return tableV
        }()
    
}

extension GCTieziVC {
    
    private func initTableView() {
        
        if let headerV = tableHeaderV as? GCCommunityHeaderView {
            let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            headerV.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
            tableview.tableHeaderView = headerV
            
            headerV.updateLayout = {[weak self] in
                let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
                headerV.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
                self?.tableview.tableHeaderView = headerV
            }
        }
        tableview.register(headerFooterViewType: GCTieziHeaderView.self)
        tableview.register(cellType: GCSwiftCommentCell.self)
        tableview.register(cellType: GCTagCell.self)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestTopics()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.requestTopics()
        })
    }
}

extension GCTieziVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataList[section]
        return model.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model = self.dataList[section]
        
        let headerV = tableView.dequeueReusableHeaderFooterView(GCTieziHeaderView.self)
        headerV?.setModel(model)
        headerV?.delegate = self
        return headerV
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: GCTagCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCTagCell.self)
            cell.setModel()
            return cell
        }else {
            let cell: GCSwiftCommentCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCSwiftCommentCell.self)
            cell.setModel()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GCPeopleMainPageVC()
        push(vc)
    }
    
}
//MARK: ------------帖子内容，包括分享事件------------
extension GCTieziVC: GCTieziHeaderViewDelegate, JYYouMengShareAble {
    
    func headerViewDidTapUserIcon(_ headerV: GCTieziHeaderView) {
        guard isPeople != true else {return}
        guard let model = headerV.model?.user else {
            return
        }
        let vc = GCPeopleMainPageVC()
        vc.userModel = model
        push(vc)
    }
    
    func headerViewDidBeSelected(_ headerV: GCTieziHeaderView) {
        guard let model = headerV.model else {
            return
        }
        let vc = GCArticalDetailVC()
        vc.pageModel = model
        push(vc)
    }
    
    func headerView(_ headerV: GCTieziHeaderView, didSelectItemAt index: Int, sender: UIButton) {
        if index == 0 {
            
            let alertVC = GCAlertShareVC()
            
            let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
            preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(230.0) - kBottomH, width: kScreenW, height: adaptW(230.0))
            alertVC.modalPresentationStyle = .custom
            alertVC.transitioningDelegate = preAniVC
            
            alertVC.clickChoosePlatForm = {[weak self] index in
                switch index {
                case 0:
                    self?.share(title: "test", description: "testDescription", thrumb: "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4014971929,2584146558&fm=26&gp=0.jpg", url: "https://www.baidu.com", to: .weixinFriend)
                case 1:
                    JYLog("pengyouquan")
                case 2:
                    JYLog("xinlang")
                case 3:
                    self?.share(title: "test", description: "testDescription", thrumb: "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4014971929,2584146558&fm=26&gp=0.jpg", url: "https://www.uioj.com", to: .QQ)
                default:
                    break
                }
            }
            present(alertVC, animated: true, completion: nil)
            
        }else if index == 2 {
            
            if let isLike = headerV.model?.isLike, let tId = headerV.model?.id, let likeNum = headerV.model?.likeCount {
                
                requestTopicZan(isZaned: isLike, tid: String(tId)) {
                    headerV.model?.isLike = !isLike
                    sender.setTitle("\(isLike ? likeNum - 1 : likeNum + 1)", for: .normal)
                    headerV.model?.likeCount = isLike ? likeNum - 1 : likeNum + 1
                }
            }
            
        }
    }
}

extension GCTieziVC: JXPagingViewListViewDelegate, UIScrollViewDelegate {
    
    func listView() -> UIView {
        return view
    }
    
    func listScrollView() -> UIScrollView {
        return self.tableview
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.scrollBlock = callback
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.scrollBlock != nil {
            self.scrollBlock!(scrollView)
        }
    }
}

extension GCTieziVC {
    //话题列表
    private func requestTopics() {
        
        guard let communityId = communiteId else{return}
        
        let prama: [String: Any] = ["page" : currentPage,
                     "include" : "user,ornament"]
        
        GCNetTool.requestData(target: GCNetApi.topicList(tid: communityId, prama: prama), success: { (result) in
            self.tableview.mj_header.endRefreshing()
            
            let data = JSON(result)
            if let totalPage = data["meta"]["pagination"]["total_pages"].int {
                if self.currentPage >= totalPage, self.currentPage != 1{
                    self.currentPage = totalPage
                    self.tableview.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
            }
            
            let models = Mapper<GCTopicModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
            if self.currentPage == 1 {
                self.dataList = models
            }else {
                self.dataList.append(contentsOf: models)
            }
            
            
            self.tableview.reloadData()
            self.tableview.mj_footer.endRefreshing()
        }) { (error) in
            self.tableview.mj_header.endRefreshing()
            JYLog(error)
        }
    }
    
    //话题(取消)点赞
    private func requestTopicZan(isZaned: Bool, tid: String, success: @escaping (()->())) {

        let target = isZaned ? GCNetApi.topicCancelZan(prama: tid) : GCNetApi.topicTapZan(prama: tid)
        
        GCNetTool.requestData(target: target, success: { (result) in
            success()
        }) { (error) in
            
        }
    }
    
}

