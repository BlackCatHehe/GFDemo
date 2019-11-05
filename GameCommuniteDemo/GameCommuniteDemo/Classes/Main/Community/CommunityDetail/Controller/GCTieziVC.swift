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
class GCTieziVC: GCBaseVC {
    
    var communiteId: String?
    
    private var dataList: [GCTopicModel] = []
    
    var tableHeaderV: UIView?
    
    private var scrollBlock: ((UIScrollView)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        
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
            self.requestTopics()
        })

    }
}

extension GCTieziVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return section == 2 ? 2 : 0
        }
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

extension GCTieziVC: GCTieziHeaderViewDelegate {
    
    func headerView(_ headerV: GCTieziHeaderView, didSelectItemAt index: Int) {
        if index == 0 {
            guard let tId = headerV.model?.id else {
                return
            }
            let vc = GCArticalDetailVC()
            vc.topicId = String(tId)
            push(vc)
        }else if index == 2 {
            
            if let tId = headerV.model?.id {
                requestTopicZan(isZaned: true, tid: String(tId))
            }
            
        }
        return
        
        let alertVC = GCAlertShareVC()
               
               let preAniVC = JYWPrestentCustomVC(presentedViewController: alertVC, presenting: self)
               preAniVC.toFrame = CGRect(x: 0, y: kScreenH - adaptW(230.0) - kBottomH, width: kScreenW, height: adaptW(230.0))
               alertVC.modalPresentationStyle = .custom
               alertVC.transitioningDelegate = preAniVC

               alertVC.clickChoosePlatForm = {[weak self] index in
                   switch index {
                   case 0:
                       JYLog("weixin")
                   case 1:
                       JYLog("pengyouquan")
                   case 2:
                       JYLog("xinlang")
                   default:
                       JYLog("qq")
                   }
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
        let prama = ["community_id": communityId]
        GCNetTool.requestData(target: GCNetApi.topicList(prama: prama), success: { (result) in
            
            self.tableview.mj_header.endRefreshing()
            
            let models = Mapper<GCTopicModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
            self.dataList = models
            
            self.tableview.reloadData()
        }) { (error) in
            self.tableview.mj_header.endRefreshing()
            JYLog(error)
        }
    }
    
    //话题(取消)点赞
    private func requestTopicZan(isZaned: Bool, tid: String) {

        let target = isZaned ? GCNetApi.topicCancelZan(prama: tid) : GCNetApi.topicTapZan(prama: tid)
        
        GCNetTool.requestData(target: target, success: { (result) in
            
        }) { (error) in
            
        }
    }
    
}

