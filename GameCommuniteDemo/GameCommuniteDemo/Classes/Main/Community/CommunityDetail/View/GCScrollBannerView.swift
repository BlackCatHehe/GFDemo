//
//  GCScrollBannerView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/7.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

class GCScrollBannerView: UIView {

    var dataSource: [GCTopicModel] = [] {
        didSet {
            self.tableview.reloadData()
            
            guard dataSource.count > 1 else {
                self.tableview.isScrollEnabled = false
                return
            }
            self.tableview.isScrollEnabled = true
            
            self.count = dataSource.count
            
            JYGCDTimer.share.destoryTimer(withName: "scrollBanner")
            //开启计时器
            JYGCDTimer.share.scheduledDispatchTimer(withName: "scrollBanner", timeInterval: 3.0, queue: .main, repeats: true) {

                self.count -= 1
                
                let indexPath = IndexPath(row: self.dataSource.count - self.count, section: 0)
                self.tableview.scrollToRow(at: indexPath, at: .top, animated: true)
                
                
                if self.count == 0 {
                    self.count = self.dataSource.count
                    self.tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    return
                }

            }
        }
    }
    
    private var count: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.backgroundColor = MetricGlobal.mainBgColor
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        return tableV
        }()
}

extension GCScrollBannerView {
    
    private func initUI(){
        
        tableview.register(cellType: GCScrollBannerCell.self)
        addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension GCScrollBannerView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.dataSource[indexPath.row == self.dataSource.count ? 0 : indexPath.row]
        let cell: GCScrollBannerCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCScrollBannerCell.self)
        cell.setModel(title: model.title)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adaptW(44.0)
    }

}
