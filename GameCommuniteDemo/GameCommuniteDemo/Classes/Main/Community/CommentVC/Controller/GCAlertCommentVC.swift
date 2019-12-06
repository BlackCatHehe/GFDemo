//
//  GCAlertCommentVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import MJRefresh

class GCAlertCommentVC: GCBaseVC {
    
    var topicId: Int?
    private var currentPage = 1
    private var commentModels: [GCCommentModel] = []
    
    private var commentId: Int?
    private var beCommentUid: Int?
    ///用来手动更新新的二级评论
    private var addedSection: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        requestCommentList()
    }
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .grouped)
        tableV.backgroundColor = MetricGlobal.mainCellBgColor
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        tableV.estimatedRowHeight = adaptW(30.0)
        tableV.estimatedSectionHeaderHeight = kScreenH
        self?.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        }
        return tableV
        }()
    
    private lazy var headTitleV: GCCommentTitleView = {
        let v = GCCommentTitleView()
        return v
    }()
    
    private lazy var bCommentV: GCCommentInputView = {
        let v = GCCommentInputView()
        return v
    }()
    
}

extension GCAlertCommentVC {
    
    private func initTableView() {
        //1.header
        view.addSubview(headTitleV)
        headTitleV.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(adaptW(59.0))
        }
        headTitleV.clickBack = {[weak self] in
            self?.dismissOrPop()
        }
        
        //2.tableview
        tableview.register(headerFooterViewType: GCCommentHeaderView.self)
        tableview.register(cellType: GCCommentCell.self)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalTo(headTitleV.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestCommentList()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.requestCommentList()
        })
        tableview.mj_header.beginRefreshing()
        
        //3.bottom comment
        view.addSubview(bCommentV)
        bCommentV.delegate = self
        bCommentV.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.top.equalTo(tableview.snp.bottom).offset(adaptW(5.0))
            make.right.left.equalToSuperview()
        }
        
    }
}

extension GCAlertCommentVC: GCCommentInputViewDelegate {
    
    func inputViewDidClickEmoji(inputView: GCCommentInputView) {
        
    }
    
    func inputView(inputView: GCCommentInputView, didClickPost text: String) {
        guard !text.isEmpty() else {
            showToast("请输入评论的内容")
            return
        }
        
        bCommentV.isFirstClassComment ? requestPostComment(content: text) : requestPostCommentReply(content: text)
    }
  
}

extension GCAlertCommentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return commentModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = commentModels[section]
        if let replyCount = commentModels[section].replies?.count, replyCount > 0 {
            
            if model.isFolded == true {//折叠评论最多显示3条，否则全部展开
                return replyCount > 3 ? 4 : replyCount
            }else {
                return replyCount > 3 ? replyCount + 1 : replyCount
            }
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let model = commentModels[section]
        let headerV = tableView.dequeueReusableHeaderFooterView(GCCommentHeaderView.self)
        headerV?.delegate = self
        headerV?.setModel(model)
        return headerV
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = commentModels[indexPath.section]
        
        let cell: GCCommentCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCCommentCell.self)
        //展开
        if model.isFolded == true, indexPath.row == 3 {
            cell.contentLb.text = "查看\(model.replies?.count ?? 0)条回复 >"
            cell.contentLb.textColor = .white
            return cell
        }else {
            //收起
            if indexPath.row >= 3, indexPath.row == model.replies!.count {
                cell.contentLb.text = "收起⌃"
                cell.contentLb.textColor = .white
                return cell
            }
            let reModel = model.replies![indexPath.row]
            cell.setModel(reModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = commentModels[indexPath.section]
        
        if model.isFolded == true, indexPath.row == 3 {
            model.isFolded = false
            
            tableView.beginUpdates()
            tableView.reloadSections([indexPath.section], with: .bottom)
            tableView.endUpdates()
            return
        }else {
            //收起
            if indexPath.row >= 3, indexPath.row == model.replies!.count {
                model.isFolded = true
                
                tableView.beginUpdates()
                tableView.reloadSections([indexPath.section], with: .top)
                tableView.endUpdates()
                return
            }
        }
        
        let reModel = model.replies?[indexPath.row]
        if let commentId = model.id, let name = reModel?.user?.name, let beCommentId = reModel?.id {
            self.commentId = commentId
            self.beCommentUid = beCommentId
            
            self.addedSection = indexPath.section
            
            bCommentV.isFirstClassComment = false
            bCommentV.alert(with: "回复 \(name)")
        }
    }
    
}

extension GCAlertCommentVC: GCCommentHeaderViewDelegate {
    
    func headerView(_ headerView: GCCommentHeaderView, didClickLike button: UIButton) {
        if let isLike = headerView.model?.isLike, let likeNum = headerView.model?.likeCount, let commentId = headerView.model?.id {
            requestTapZan(isZan: isLike, commentId: commentId) {[weak self] in
                headerView.model?.isLike = !isLike
                headerView.likeNumBt.isSelected = !isLike
                headerView.likeNumBt.setTitle("\(isLike ? likeNum - 1 : likeNum + 1)", for: .normal)
                headerView.model?.likeCount! = isLike ? likeNum - 1 : likeNum + 1
            }
        }
    }
    
    func headerViewDidBeTaped(_ headerView: GCCommentHeaderView) {
        if let commentId = headerView.model?.id, let name = headerView.model?.user?.name {
            self.commentId = commentId
            self.beCommentUid = nil
            
            bCommentV.isFirstClassComment = false
            bCommentV.alert(with: "回复 \(name)")
        }
    }
}

extension GCAlertCommentVC {
    
    //请求评论列表
    private func requestCommentList() {
    
        guard let communityId = self.topicId else{return}
        GCNetTool.requestData(target: GCNetApi.commentList(prama: ["topic_id" : communityId]), success: { (result) in
            
            self.tableview.mj_header.endRefreshing()
            
            let data = JSON(result)
            
            //评论总数
            let totalNum = JSON(result)["meta"]["pagination"]["total"].intValue
            self.headTitleV.comNum = totalNum
            
            //评论总页数和当前页数比较
            if let totalPage = data["meta"]["pagination"]["total_pages"].int {
                if self.currentPage >= totalPage, self.currentPage != 1{
                    self.currentPage = totalPage
                    self.tableview.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
            }
            
            let models = Mapper<GCCommentModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
            if self.currentPage == 1 {
                self.commentModels = models
            }else {
                self.commentModels.append(contentsOf: models)
            }
            
            self.tableview.reloadData()
            self.tableview.mj_footer.endRefreshing()
 
        }) { (error) in
            JYLog(error)
            
        }
    }
    
    //请求发起评论
    private func requestPostComment(content: String) {
        
        guard let topicId = topicId else {return}
        let prama: [String: Any] = [
            "topic_id": topicId,
            "content" : content
        ]
        GCNetTool.requestData(target: GCNetApi.postComment(prama: prama), controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            
            if let commentModel = Mapper<GCCommentModel>().map(JSON: result) {
                self.commentModels.insert(commentModel, at: 0)

                self.tableview.reloadData()
                self.bCommentV.clearMsg()
            }
        }) { (error) in
            JYLog(error)
        }
    }
    
    //请求发起二级评论
    private func requestPostCommentReply(content: String) {
        
        guard let topicId = topicId else {return}
        guard let commentId = commentId else {return}
        
        var prama: [String: Any] = [
            "topic_id": topicId,
            "comment_id": commentId,
            "content" : content
        ]
        if let beCommentId = beCommentUid {
            prama["parent_id"] = beCommentId
        }
        GCNetTool.requestData(target: GCNetApi.postCommentReply(prama: prama), controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            
            if let commentModel = Mapper<GCCommentReplyModel>().map(JSON: result) {
                
                self.bCommentV.isFirstClassComment = true
                self.bCommentV.clearMsg()
                
                if let section = self.addedSection {
                    if self.commentModels[section].replies == nil {
                        self.commentModels[section].replies = [commentModel]
                    }else {
                        self.commentModels[section].replies!.append(commentModel)
                    }
                    self.tableview.beginUpdates()
                    self.tableview.reloadSections([section], with: .automatic)
                    self.tableview.endUpdates()
                }
                
            }
            
        }) { (error) in
            JYLog(error)
            
        }
    }
    
    //评论点赞
    private func requestTapZan(isZan: Bool, commentId: Int, success: @escaping (()->())){
        
        let target = isZan ? GCNetApi.commentCancelZan(commentId: String(commentId)) : GCNetApi.commentTapZan(commentId: String(commentId))
        
        GCNetTool.requestData(target: target, controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
            self.showToast(isZan ? "取消点赞成功" : "点赞成功")
            success()
        }) { (error) in
            JYLog(error)
        }
        
    }
}
