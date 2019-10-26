//
//  GCQuHaoVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCQuHaoVC: GCBaseVC {
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.backgroundColor = MetricGlobal.mainBgColor
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        self?.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        }
        return tableV
        }()
    private lazy var bButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackButton()
        initTableView()
 
    }

}

extension GCQuHaoVC {
    
    private func initBackButton() {
        
        view.addSubview(self.bButton)
        self.bButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight + adaptW(10.0))
        }
        bButton.rx.tap
            .bind {[weak self] in
                self?.dismissOrPop(true)
        }.disposed(by: rx.disposeBag)
    }
    
    private func initTableView() {
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.bButton.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
    }

}

extension GCQuHaoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLb = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: adaptW(50.0)))
        headerLb.textColor = .white
        headerLb.font = kFont(adaptW(24.0), MetricGlobal.mainMediumFamily)
        headerLb.text = "  请选择手机区号"
        return headerLb
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adaptW(50.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = MetricGlobal.mainBgColor
        cell.textLabel?.text = "北京"
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = "+86"
        cell.detailTextLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adaptW(50.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
