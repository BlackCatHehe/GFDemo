//
//  GCNotiMsgListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import MJRefresh

class GCNotiMsgListVC: GCBaseVC {
    
    private var dataList: [GCNotiModel] = []
    private var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "通知消息"
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

extension GCNotiMsgListVC {
    
    private func initTableView() {
        tableview.register(cellType: GCNotiMsgCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestMsgListData()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.requestMsgListData()
        })
        tableview.mj_header.beginRefreshing()
    }
}

extension GCNotiMsgListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataList[indexPath.row]
        
        let cell: GCNotiMsgCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCNotiMsgCell.self)
        cell.setModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension GCNotiMsgListVC {
    
    private func requestMsgListData() {
        
        let prama = ["page": currentPage]
        
        GCNetTool.requestData(target: GCNetApi.notiMsgs(prama: prama), success: { (result) in
            
            self.tableview.mj_header.endRefreshing()
            
            let data = JSON(result)
            if let totalPage = data["meta"]["pagination"]["total_pages"].int {
                if self.currentPage >= totalPage, self.currentPage != 1{
                    self.currentPage = totalPage
                    self.tableview.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
            }
            
            let models = Mapper<GCNotiModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
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
}
