//
//  GCMessageCenterVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCMessageCenterVC: GCBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "消息中心"
        initTableView()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundColor(bgColor: .clear, shadowColor: .clear)
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
    
    private lazy var headerV: GCMsgHeaderView = {
        let headerView = GCMsgHeaderView()
        
        headerView.setModel()
        return headerView
    }()
}

extension GCMessageCenterVC {
    
    private func initTableView() {
        
        let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        headerV.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
        tableview.tableHeaderView = self.headerV
        
        headerV.clickCateButton = {[weak self] index in
            if index == 0 {
                let vc = GCPreferentialVC()
                self?.push(vc)
            }else if index == 1 {
                let vc = GCNotiMsgListVC()
                self?.push(vc)
            }else {
                let vc = GCReceiveMsgVC()
                self?.push(vc)
            }
        }
        JYLog(self.headerV)
        
        tableview.register(cellType: GCMsgCell.self)
        tableview.register(headerFooterViewType: GCMsgSectionHeaderView.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH)
        }
    }
}

extension GCMessageCenterVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }else {
            let headerV: GCMsgSectionHeaderView = tableView.dequeueReusableHeaderFooterView(GCMsgSectionHeaderView.self)!
            headerV.setModel()
            return headerV
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? adaptW(38.0) : adaptW(10.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GCMsgCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCMsgCell.self)
        cell.setModel()
        cell.timeLb.isHidden = indexPath.section == 0 ? true: false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return adaptW(10.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

