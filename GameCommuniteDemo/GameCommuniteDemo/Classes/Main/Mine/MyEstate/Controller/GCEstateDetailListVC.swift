//
//  GCEstateDetailListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import MJRefresh
import SwiftyJSON

class GCEstateDetailListVC: GCBaseVC {
    
    ///数据源
    private var dataList: [GCEstateModel] = []
    
    private var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "资产明细"
        initTableView()
        
        reqestEstateDetailList()
    }
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.backgroundColor = MetricGlobal.mainBgColor
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        tableV.estimatedRowHeight = adaptW(100.0)
        self?.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        }
        return tableV
        }()
}

extension GCEstateDetailListVC {
    
    private func initTableView() {
        
        
        tableview.register(cellType: GCEstateDetailCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
        
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.reqestEstateDetailList()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.reqestEstateDetailList()
        })
        tableview.mj_header.beginRefreshing()
    }
}

extension GCEstateDetailListVC: UITableViewDelegate, UITableViewDataSource {
    
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
        let cell: GCEstateDetailCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCEstateDetailCell.self)
        cell.setModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension GCEstateDetailListVC {
    
    private func reqestEstateDetailList() {
        
        GCNetTool.requestData(target: GCNetApi.eState, showAcvitity: true, success: { (result) in
            
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
            
            let models = Mapper<GCEstateModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
            if self.currentPage == 1 {
                self.dataList = models
            }else {
                self.dataList.append(contentsOf: models)
            }
            
            
            self.tableview.reloadData()
            
        }) { (error) in
            self.tableview.mj_header.endRefreshing()
            self.tableview.mj_footer.endRefreshing()
            JYLog(error)
        }
    }
}
