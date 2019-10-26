//
//  GCPreferentialVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/23.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCPreferentialVC: GCBaseVC {
    
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
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
    }
}

extension GCPreferentialVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GCPreferentialCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCPreferentialCell.self)
        cell.setModel()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
