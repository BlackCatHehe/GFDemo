//
//  GCGoodsManagerListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import MJRefresh
import SwiftyJSON

class GCGoodsManagerListVC: GCBaseVC {
    
    var isXia: Bool = false
    
    ///数据源
      private var dataList: [GCGoodsModel] = []
      
      private var currentPage: Int = 1
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initTableView()
        requestListData()
    }
}

extension GCGoodsManagerListVC {
    
    private func initTableView() {
        tableview.register(cellType: GCGoodsManagerCell.self)
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
         tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
             self.currentPage += 1
             self.requestListData()
         })
    }
}

extension GCGoodsManagerListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataList[indexPath.row]
        let cell: GCGoodsManagerCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCGoodsManagerCell.self)
        cell.setModel(isXia: isXia, model: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: ------------cell点击下架和删除------------
extension GCGoodsManagerListVC: GCGoodsManagerCellDelegate {
    
    func managerCell(_ cell: GCGoodsManagerCell, didClickDelete button: UIButton) {
        
    }
    
    func managerCell(_ cell: GCGoodsManagerCell, didClickXiaJia button: UIButton) {
        
        if isXia {//下架
            if let index = tableview.indexPath(for: cell) {
                let model = dataList[index.row]
                requestXiaJia(with: String(model.id!))
            }
        }else {//重新编辑
            let vc = GCPostGoodsVC()
            push(vc)
        }
        
        
        
    }
}
//MARK: ------------request------------
extension GCGoodsManagerListVC {
    ///请求数据
    private func requestListData() {
        let prama = ["status" : isXia ? 2 : 1]
        GCNetTool.requestData(target: GCNetApi.goodsManager(prama: prama), showAcvitity: true, success: { (result) in
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
            
            let models = Mapper<GCGoodsModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
            if self.currentPage == 1 {
                self.dataList = models
            }else {
                self.dataList.append(contentsOf: models)
            }
            
            
            self.tableview.reloadData()
            
        }) { (error) in
            JYLog(error)
        }
        
    }
    
    ///请求下架
    private func requestXiaJia(with gId: String) {
        
        GCNetTool.requestData(target: GCNetApi.goodsDown(prama: gId), showAcvitity: true, success: { (result) in
            
            self.showToast("下架成功")
            
        }) { (error) in
            JYLog(error)
        }
        
    }
    
//    ///请求删除
//    private func requestXiaJia(with gId: String) {
//
//        GCNetTool.requestData(target: GCNetApi.goodsDown(prama: gId), showAcvitity: true, success: { (result) in
//
//            self.showToast("下架成功")
//
//        }) { (error) in
//            JYLog(error)
//        }
//
//    }
}
