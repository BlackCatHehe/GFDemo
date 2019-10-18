//
//  GCShopGoodsDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    static let tableHeaderH: CGFloat = adaptW(adaptW(328.0))
}

class GCShopGoodsDetailVC: GCBaseVC {
    //MARK: - cyclelife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "商品详情"
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
        tableV.estimatedRowHeight = adaptW(70.0)
        self?.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        }
        return tableV
        }()
    
    private lazy var theaderV: GoodDetailHeaderView = {
        let headerV = GoodDetailHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Metric.tableHeaderH))
        
        return headerV
    }()
}

extension GCShopGoodsDetailVC {
    
    private func initTableView() {
        tableview.tableHeaderView = self.theaderV
        self.theaderV.setModel()
        
        tableview.register(cellType: GCChatListCell.self)
        tableview.register(cellType: GCGoodsPriceFloatCell.self)
        tableview.register(cellType: GCGoodsDetailCell.self)
        tableview.register(cellType: GCShopRecommendCell.self)
        tableview.register(cellType: GCChartView.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
    }
}

extension GCShopGoodsDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 5 : 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerV = GCNormalHeaderView.loadFromNib()
        switch section {
        case 0:
            headerV.titleLb.text = "属性"
        case 1:
            headerV.titleLb.text = "价格趋势"
        case 2:
            headerV.titleLb.text = "评论(999条)"
            headerV.moreBt.isHidden = false
            headerV.moreBt.setTitle("查看全部评论    >", for: .normal)
            headerV.moreBt.addTarget(self, action: #selector(clickMoreCommend), for: .touchUpInside)
        case 3:
            headerV.titleLb.text = "相关推荐"
            
        default: break
        }
        return headerV
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adaptW(50.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: GCGoodsDetailCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCGoodsDetailCell.self)
            return cell
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell: GCChartView = tableView.dequeueReusableCell(for: indexPath, cellType: GCChartView.self)
               
                return cell
            }else {
                let cell: GCGoodsPriceFloatCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCGoodsPriceFloatCell.self)
                cell.setModel()
                return cell
            }
        }else if indexPath.section == 2 {
            let cell: GCChatListCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCChatListCell.self)
            cell.setModel()
            cell.newMsgLb.isHidden = true
            return cell
        }else {
            let cell: GCShopRecommendCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCShopRecommendCell.self)
            cell.setModel()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension GCShopGoodsDetailVC {
    
    @objc private func clickMoreCommend() {
        
    }
    
}
