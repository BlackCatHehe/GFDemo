//
//  GCAlertCommentVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCAlertCommentVC: GCBaseVC {
    
    
    var tableHeaderV: UIView?
    
    private var scrollBlock: ((UIScrollView)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
    }
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .grouped)
        tableV.backgroundColor = MetricGlobal.mainBgColor
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
    
}

extension GCAlertCommentVC {
    
    private func initTableView() {
        
        if let headerV = tableHeaderV as? GCCommunityHeaderView {
            let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            headerV.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
            tableview.tableHeaderView = headerV
            
            headerV.updateLayout = {[weak self] in
                let height = headerV.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
                headerV.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
                self?.tableview.tableHeaderView = headerV
            }
        }
        
        tableview.register(headerFooterViewType: GCCommentHeaderView.self)
        tableview.register(cellType: GCCommentCell.self)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
}

extension GCAlertCommentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return section == 2 ? 2 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }else {
            let headerV = tableView.dequeueReusableHeaderFooterView(GCCommentHeaderView.self)
            headerV?.setModel()
            return headerV
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 10.0 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell: GCCommentCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCCommentCell.self)
        cell.setModel()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GCPeopleMainPageVC()
        push(vc)
    }
    
}
