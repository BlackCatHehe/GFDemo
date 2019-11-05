//
//  GCSettingListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCSettingListVC: GCBaseVC {

    let settings = [ ["用户"],
    ["安全与绑定", "游戏账号管理", "推送设置","通用设置"],
    ["关于我们", "邀请好友", "隐私政策"],
    ["退出登录"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "设置"
        initUI()
    }
    
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

extension GCSettingListVC {
    
    private func initUI() {
        tableview.register(cellType: GCSettingUserCell.self)
        tableview.register(cellType: GCTableViewCell.self)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
    }
}

extension GCSettingListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : adaptW(58.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: GCSettingUserCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCSettingUserCell.self)
            cell.accessoryView?.backgroundColor = MetricGlobal.mainCellBgColor
            cell.setModel()
            return cell
        }else {
            let cell: GCTableViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCTableViewCell.self)
            cell.titleLb.text = settings[indexPath.section][indexPath.row]
            cell.titleLb.textAlignment = indexPath.section == 3 ? .center : .left
            cell.iconImgV.isHidden = indexPath.section == 3 ? true : false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adaptW(10.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = GCPersonalMsgVC()
            push(vc)
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 2:
                let vc = GCNotiSettingVC()
                push(vc)
            default:
                let vc = GCUsualSettingVC()
                push(vc)
            }
        }else {
            
        }
        
    }
}
