//
//  GCPreferentialVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import MJRefresh

class GCPreferentialVC: GCBaseVC {
    
    private var dataList: [GCCheapActivityModel] = []
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
    
    private lazy var allReadButton: UIButton = {
        let button = UIButton()
        button.setTitle("全部已读", for: .normal)
        button.titleLabel?.font = kFont(adaptW(15.0))
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "优惠活动"
        initTableView()
        
        //保存按钮
        let rightbarItem = UIBarButtonItem(customView: allReadButton)
        self.navigationItem.rightBarButtonItem = rightbarItem
        allReadButton.rx.tap
            .bind{[weak self] in
                JYLog("all read")
        }.disposed(by: rx.disposeBag)
    }
}

extension GCPreferentialVC {
    
    private func initTableView() {
        tableview.register(cellType: GCPreferentialCell.self)
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

extension GCPreferentialVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataList[indexPath.row]
        let cell: GCPreferentialCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCPreferentialCell.self)
        cell.setModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataList[indexPath.row]
        
        guard let jumpUrl = model.target?.url else {return}
        
        let pageVc = JYWWKWebViewController()
        pageVc.title = model.target?.title
        pageVc.openUrl = URL(string: jumpUrl)
        push(pageVc)
        
    }
    
}

extension GCPreferentialVC {
    
    private func requestMsgListData() {
        
        let prama = ["page": currentPage]
        
        GCNetTool.requestData(target: GCNetApi.cheaperActivities(prama: prama), success: { (result) in
            
            self.tableview.mj_header.endRefreshing()
            
            let data = JSON(result)
            if let totalPage = data["meta"]["pagination"]["total_pages"].int {
                if self.currentPage >= totalPage, self.currentPage != 1{
                    self.currentPage = totalPage
                    self.tableview.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
            }
            
            let models = Mapper<GCCheapActivityModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
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
