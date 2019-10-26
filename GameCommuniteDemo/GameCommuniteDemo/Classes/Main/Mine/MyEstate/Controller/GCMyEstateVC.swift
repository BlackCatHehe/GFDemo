//
//  GCMyEstateVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCMyEstateVC: GCBaseVC {
    
    let settings = [ ["资产明细"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    private lazy var headerV: GCMyEstateHeaderView = {
        let headerView = GCMyEstateHeaderView(frame: .zero)
        headerView.setModel()
        return headerView
    }()
    
    private lazy var tableview: UITableView = {[weak self] in
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.backgroundColor = MetricGlobal.mainBgColor
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.estimatedRowHeight = adaptW(70.0)
        tableview.delegate = self
        tableview.dataSource = self
        if #available(iOS 11.0, *) {
            tableview.contentInsetAdjustmentBehavior = .never
        }else{
            self?.automaticallyAdjustsScrollViewInsets = false
        }
        return tableview
    }()
    
}

extension GCMyEstateVC {
    
    private func initUI() {
        let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        headerV.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
        tableview.tableHeaderView = self.headerV

        
        tableview.register(cellType: GCTableViewCell.self)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
    }
}

extension GCMyEstateVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adaptW(58.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GCTableViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCTableViewCell.self)
        cell.titleLb.text = settings[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adaptW(10.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GCEstateDetailListVC()
        push(vc)
    }
}
