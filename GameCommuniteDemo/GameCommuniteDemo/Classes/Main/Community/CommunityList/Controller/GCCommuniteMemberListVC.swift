//
//  GCCommuniteMemberListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import MJRefresh
import SwiftyJSON

class GCCommuniteMemberListVC: GCBaseVC {
    
    var communityId: String?
    
    ///数据源
    private var dataList: [UserModel] = []
    
    private var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.backgroundColor = MetricGlobal.mainBgColor
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        tableV.estimatedRowHeight = adaptW(70.0)
        self?.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        }
        return tableV
        }()
}

extension GCCommuniteMemberListVC {
    
    private func initTableView() {
        
        tableview.register(cellType: GCMemberCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
        
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestMemberList()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.requestMemberList()
        })
        
        tableview.mj_header.beginRefreshing()
    }
}

extension GCCommuniteMemberListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adaptW(10.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataList[indexPath.row]
        let cell: GCMemberCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCMemberCell.self)
        cell.setModel(model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return adaptW(50.0)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerLb = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: adaptW(50.0)))
        footerLb.font = kFont(adaptW(14.0))
        footerLb.textColor = MetricGlobal.mainGray
        footerLb.text = "共\(dataList.count)个成员"
        footerLb.textAlignment = .center
        return footerLb
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension GCCommuniteMemberListVC: GCMemberCellDelegate {
    
    func cellDidClickFollow(cell: GCMemberCell) {
        
        if let index = tableview.indexPath(for: cell) {
            
            requestFollow(isFollow: dataList[index.row].isFollower ?? false, uId: dataList[index.row].id!, success: {
                
                self.dataList[index.row].isFollower = !self.dataList[index.row].isFollower!
                
                self.tableview.beginUpdates()
                self.tableview.reloadRows(at: [index], with: .automatic)
                self.tableview.endUpdates()
            })
 
        }
    }
    
}

extension GCCommuniteMemberListVC {
    
    private func requestMemberList() {
        guard let cid = communityId, let comId = Int(cid) else {
            showToast("数据异常")
            return
        }
        
        GCNetTool.requestData(target: GCNetApi.communiteMemberList(cid: comId), success: { (result) in
            self.tableview.mj_header.endRefreshing()
            self.tableview.mj_footer.endRefreshing()
            
            let data = JSON(result)
            if let totalPage = data["meta"]["pagination"]["total_pages"].int {
                if self.currentPage >= totalPage, self.currentPage != 1{
                    self.currentPage = totalPage
                    self.tableview.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
            }
            
            let models = Mapper<UserModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
            if self.currentPage == 1 {
                self.dataList = models
            }else {
                self.dataList.append(contentsOf: models)
            }
            
            
            self.tableview.reloadData()
            
        }) { (error) in
            self.tableview.mj_header.endRefreshing()
            JYLog(error)
        }
    }
    
    private func requestFollow(isFollow: Bool, uId: Int, success: @escaping ()->()) {
         
        let target = isFollow ? GCNetApi.cancelFollow(prama: uId) : GCNetApi.follow(userId: uId)
         
         GCNetTool.requestData(target: target, controller: self, showAcvitity: true, isTapAble: false, success: { (result) in
             if let msg = result["message"] as? String {
                 self.showToast(msg)
                
                success()
                
             }
            
         }) { (error) in
             
         }
         
     }
}
