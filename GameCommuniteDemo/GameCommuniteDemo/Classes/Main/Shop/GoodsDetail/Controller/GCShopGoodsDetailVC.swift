//
//  GCShopGoodsDetailVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper

fileprivate struct Metric {
    static let tableHeaderH: CGFloat = adaptW(adaptW(328.0))
}

class GCShopGoodsDetailVC: GCBaseVC {
    
    var gid: Int! //商品id
    
    ///是否是我的道具进来的。如果是，隐藏立即购买
    var isMyItems: Bool = false
    
    ///是否折叠评论
    var isCommentFolded: Bool = true
    
    private var goodsModel: GCGoodsModel?
    
    //MARK: - cyclelife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "商品详情"
        initTableView()
        requestGoodsDetail()
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
    
    private lazy var buyBt: UIButton = {
        let button = UIButton()
        button.setTitle("立即购买", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MetricGlobal.mainBlue
        button.layer.cornerRadius = adaptW(22.0)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(clickBuy), for: .touchUpInside)
        return button
    }()
    
    private lazy var moreCommentsBt: UIButton = {
        let button = UIButton()
        button.setTitle("查看全部评论", for: .normal)
        button.setImage(UIImage(named: "jiantou_xia_blue"), for: .normal)
        button.setTitleColor(MetricGlobal.mainBlue, for: .normal)
        button.titleLabel?.font = kFont(adaptW(12.0))
        button.backgroundColor = MetricGlobal.mainCellBgColor
        button.addTarget(self, action: #selector(clickMoreCommend), for: .touchUpInside)
        return button
    }()
}

extension GCShopGoodsDetailVC {
    
    private func initTableView() {

        tableview.tableHeaderView = self.theaderV
        
        tableview.register(cellType: GCGoodsCommentCell.self)
       // tableview.register(cellType: GCGoodsPriceFloatCell.self)
        tableview.register(cellType: GCGoodsDetailCell.self)
        tableview.register(cellType: GCShopRecommendCell.self)
        //tableview.register(cellType: GCChartView.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
    }
}

extension GCShopGoodsDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if let comments =  goodsModel?.comments, comments.count > 2 {
                if isCommentFolded {
                    return 2
                }
            }
            return goodsModel?.comments?.count ?? 0
        }else {
           return goodsModel?.relations?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let models = goodsModel?.comments
        let headerV = GCNormalHeaderView.loadFromNib()
        switch section {
        case 0:
            headerV.titleLb.text = "属性"
            
        case 1:
            headerV.titleLb.text = "评论(\(models?.count ?? 0)条)"

        case 2:
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
            
            if let model = self.goodsModel {
                cell.setModel(model)
            }
            return cell
//        }
//        else if indexPath.section == 1 {
//            if indexPath.row == 0 {
//                let cell: GCChartView = tableView.dequeueReusableCell(for: indexPath, cellType: GCChartView.self)
//
//                return cell
//            }else {
//                let cell: GCGoodsPriceFloatCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCGoodsPriceFloatCell.self)
//                cell.setModel()
//                return cell
//            }
        }else if indexPath.section == 1 {
            let model = goodsModel?.comments?[indexPath.row]
            let cell: GCGoodsCommentCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCGoodsCommentCell.self)
            cell.setModel(model!)
            return cell
        }else {
            let model = goodsModel?.relations?[indexPath.row]
            let cell: GCShopRecommendCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCShopRecommendCell.self)
            cell.setModel(model!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        //如果是评论，添加查看全部评论和收起
        if section == 1 {
            if let comments =  goodsModel?.comments, comments.count > 2 {
                let cView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: adaptW(54.0)))
                cView.backgroundColor = MetricGlobal.mainCellBgColor
                cView.addSubview(moreCommentsBt)
                moreCommentsBt.frame = CGRect(x: adaptW(15.0), y: adaptW(5.0), width: kScreenW - adaptW(15.0)*2, height: adaptW(44.0))
                return cView
            }
        }else if section == 2 {
            if isMyItems == true {
                buyBt.isHidden = true
            }
            
            let cView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: adaptW(120.0)))
            cView.addSubview(buyBt)
            buyBt.frame = CGRect(x: adaptW(15.0), y: adaptW(120.0) - adaptW(44.0) - adaptW(20.0), width: kScreenW - adaptW(15.0)*2, height: adaptW(44.0))
            return cView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else if section == 1 {
            if let comments =  goodsModel?.comments, comments.count > 2 {
                return adaptW(64.0)
            }
        }else if section == 2 {
            return adaptW(120.0)
        }
        return 0

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if let gid = goodsModel?.relations?[indexPath.row].id {
                let vc = GCShopGoodsDetailVC()
                vc.gid = gid
                push(vc)
            }
        }
    }
    
}

//MARK: ------------click------------
extension GCShopGoodsDetailVC {
    
    @objc private func clickMoreCommend() {
        
        isCommentFolded = !isCommentFolded
        
        moreCommentsBt.setTitle(isCommentFolded ? "查看全部评论" : "收起评论", for: .normal)
        moreCommentsBt.setImage(UIImage(named: isCommentFolded ? "jiantou_xia_blue" : "jiantou_shang_blue"), for: .normal)
        
        moreCommentsBt.layoutButton(style: .Right, imageTitleSpace: 10.0)
        
        tableview.beginUpdates()
        tableview.reloadSections([1], with: .automatic)
        tableview.endUpdates()
        
    }
    
    @objc private func clickBuy() {
        let vc = GCPostOrderVC()
        vc.gModel = self.goodsModel
        push(vc)
    }
    
}

//MARK: ------------request------------
extension GCShopGoodsDetailVC {
    
    ///请求商品详情
    private func requestGoodsDetail() {

        guard let gid = self.gid else{return}
        let prama = [
            "include" : "attributes,comments,relations,user"
        ]
        GCNetTool.requestData(target: GCNetApi.goodsDetail(gid: String(gid), prama: prama), success: { (result) in
 
            if let model = Mapper<GCGoodsModel>().map(JSON: result) {
                self.goodsModel = model

                self.theaderV.setModel(model)
                self.tableview.reloadData()
            }

        }) { (error) in
            JYLog(error)
            
        }
    }
    
}
