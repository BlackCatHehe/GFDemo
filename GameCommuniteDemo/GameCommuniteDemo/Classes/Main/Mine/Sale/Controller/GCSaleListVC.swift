//
//  GCSaleListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import MJRefresh
import SwiftyJSON

class GCSaleListVC: GCBaseVC {
    
    ///true 我的卖出。  false 我的购买
    var isSale: Bool = true
    
    ///1:待付款，2:待发货，3:待签收，4:已完成  不传：全部
    var orderStatus: String?
    
    ///数据源
    private var dataList: [GCOrderListModel] = []
    
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

extension GCSaleListVC {
    
    private func initTableView() {
        tableview.register(cellType: GCSaleListCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kNavBarHeight)
        }
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestListData()
        })
        noDataView.refreshHeader = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestListData()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.requestListData()
        })
        tableview.mj_header.beginRefreshing()
    }
}

extension GCSaleListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataList[indexPath.row]
        let cell: GCSaleListCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCSaleListCell.self)
        cell.setModel(model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension GCSaleListVC: GCSaleListCellDelegate {
    
    func cellDidClickMore(cell: GCSaleListCell) {
        let vc = GCOrderDetailVC()
        
        vc.pageModel = cell.model
        
        push(vc)
    }
    
    func cellDidClickComment(cell: GCSaleListCell) {
        let vc = GCPostCommentVC()
        push(vc)
    }
    
    func cellDidClickGoods(cell: GCSaleListCell, goodsId: Int) {
        let gVC = GCShopGoodsDetailVC()
        gVC.gid = goodsId
        push(gVC)
    }
    

    
}


extension GCSaleListVC {
    
    ///请求数据
    private func requestListData() {
        
        var prama: [String: Any] = [:]
        if let status = orderStatus {
            prama["status"] = status
        }
        
        let target: GCNetApi = isSale ? .orderSaleList(prama) : .orderBuyList(prama)
        
        GCNetTool.requestData(target: target, showAcvitity: false, success: { (result) in
            self.tableview.mj_header.endRefreshing()
            self.tableview.mj_footer.endRefreshing()
            self.noDataView.refreshHeader?.endRefreshing()
            
            
            let data = JSON(result)
            if let totalPage = data["meta"]["pagination"]["total_pages"].int {
                if self.currentPage >= totalPage, self.currentPage != 1{
                    self.currentPage = totalPage
                    self.tableview.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
            }
            
            if let datas = result["data"] as? [[String: Any]] {
                
                let models = Mapper<GCOrderListModel>().mapArray(JSONArray: datas)
                if self.currentPage == 1 {
                    self.dataList = models
                }else {
                    self.dataList.append(contentsOf: models)
                }
                
                if self.dataList.count != 0 {
                    self.tableview.reloadData()
                }else {
                    self.showNoData()
                }
            }
            
            
            
        }) { (error) in
            self.tableview.mj_header.endRefreshing()
            self.tableview.mj_footer.endRefreshing()
            self.noDataView.refreshHeader?.endRefreshing()
            
            JYLog(error)
        }
        
    }
}
