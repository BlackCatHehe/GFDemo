//
//  GCGoodsManagerListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCGoodsManagerListVC: GCBaseVC {
    
    var isXia: Bool = false
    
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
    }
}

extension GCGoodsManagerListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GCGoodsManagerCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCGoodsManagerCell.self)
        cell.setModel(isXia: isXia)
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
        
    }
}
//MARK: ------------request------------
extension GCGoodsManagerListVC {
    
    private func requestXiaJia() {
        
        GCNetTool.requestData(target: GCNetApi.goodsDown(prama: ""), showAcvitity: true, success: { (result) in
            
            
        }) { (error) in
            JYLog(error)
        }
        
    }
}
