//
//  GCAssociationGoodsList.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import MJRefresh
import SwiftyJSON

class GCAssociationGoodsList: GCBaseVC {
    
    var clickChoose: ((GCGoodsModel?)->())?
    
    ///数据源
    private var dataList: [GCGoodsModel] = []
    
    private var currentPage: Int = 1
    
    private var selectedIndex: Int?
    
    private var selPrams: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "关联商品"
        initTableView()
        initSortBt()
        initNextBt()
        
        sortVC.clickSort = {[weak self] prama in
            self?.selPrams = prama
            self?.currentPage = 1
            self?.requestListData( prama)
        }
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
     
     private lazy var sortBt: UIButton = {
         let button = UIButton(frame: CGRect(x: 0, y: 0, width: adaptW(70.0), height: adaptW(30.0)))
         button.setTitle("筛选", for: .normal)
         button.titleLabel?.font = kFont(adaptW(14.0))
         button.setTitleColor(.white, for: .normal)
         button.backgroundColor = MetricGlobal.mainBlue
         button.layer.cornerRadius = adaptW(15.0)
         button.layer.masksToBounds = true
         return button
     }()
     private lazy var nextBt: UIButton = {
         let button = UIButton(frame: .zero)
         button.setTitle("下一步", for: .normal)
         button.titleLabel?.font = kFont(adaptW(14.0))
         button.setTitleColor(.white, for: .normal)
         button.backgroundColor = MetricGlobal.mainBlue
         button.layer.cornerRadius = adaptW(22.0)
         button.layer.masksToBounds = true
         return button
     }()
     
    private lazy var sortVC: GCAssGoodsSortVC = {
        let vc = GCAssGoodsSortVC()
        let transtion = CATransition()
        transtion.duration = 0.3
        transtion.timingFunction = CAMediaTimingFunction(name: .easeOut)
        transtion.type = .fade
        vc.view.window?.layer.add(transtion, forKey: nil)
        return vc
    }()
    

}

extension GCAssociationGoodsList {
    
    private func initTableView() {
        tableview.register(cellType: GCAssociationGoodsCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kStatusBarheight - kNavBarHeight)
        }
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestListData(self.selPrams)
        })
        noDataView.refreshHeader = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestListData(self.selPrams)
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.requestListData(self.selPrams)
        })
        tableview.mj_header.beginRefreshing()
    }
    
    private func initSortBt(){
        
        let customItem = UIBarButtonItem(customView: sortBt)
        self.navigationItem.rightBarButtonItem = customItem
        
        sortBt.rx.tap
            .bind{[weak self] in
                self?.enterSortVC()
        }.disposed(by: rx.disposeBag)
    }
    
    private func enterSortVC() {
        
        let preAniVC = JYWPrestentCustomVC(presentedViewController: sortVC, presenting: self)
        preAniVC.isDismissAnimateable = true
        preAniVC.toFrame = CGRect(x: kScreenW - adaptW(290.0), y: 0, width: adaptW(290.0), height: kScreenH)
        sortVC.modalPresentationStyle = .custom
        sortVC.modalTransitionStyle = .coverVertical
        sortVC.transitioningDelegate = preAniVC
        
        //从左侧弹出
        let transtion = CATransition()
        transtion.duration = 0.3
        transtion.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transtion.type = .moveIn
        transtion.subtype = .fromRight
        view.window?.layer.add(transtion, forKey: "presentRight")
        present(sortVC, animated: false, completion: nil)
        
        
    }
    
    private func initNextBt(){
        
        view.addSubview(nextBt)
        nextBt.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-kBottomH - 5.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenW - adaptW(15.0)*2)
            make.height.equalTo(adaptW(44.0))
        }
        
        nextBt.rx.tap
            .bind{[weak self] in

                if let sel = self?.selectedIndex {
                    let model = self?.dataList[sel]
                    self?.clickChoose?(model)
                }else {
                    self?.clickChoose?(nil)
                }
                
                self?.dismissOrPop()
        }.disposed(by: rx.disposeBag)
    }

}

extension GCAssociationGoodsList: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adaptW(10.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataList[indexPath.row]
        
        let cell: GCAssociationGoodsCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCAssociationGoodsCell.self)
        cell.setModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? GCAssociationGoodsCell {
            cell.isSel = !cell.isSel
            
            guard indexPath.row != selectedIndex else {
                selectedIndex = nil
                return
            }
            
            if let selIndex = selectedIndex, let oldSelCell = tableView.cellForRow(at: IndexPath(row: selIndex, section: 0)) as? GCAssociationGoodsCell {
                oldSelCell.isSel = false
            }
            
            selectedIndex = indexPath.row
            JYLog(selectedIndex)
        }
    }
    
}

extension GCAssociationGoodsList {
    
    ///请求数据
    private func requestListData(_ sortPrama: [String: Any] = [:]) {
        var prama: [String: Any] = ["page" : currentPage]
        prama.merge(sortPrama, uniquingKeysWith: {$1})
        
        GCNetTool.requestData(target: GCNetApi.goodsList(prama: prama), showAcvitity: false, success: { (result) in
            self.tableview.mj_header.endRefreshing()
            self.tableview.mj_footer.endRefreshing()
            self.noDataView.refreshHeader?.endRefreshing()
            
            
            let data = JSON(result)
            if let totalPage = data["meta"]["pagination"]["total_pages"].int {
                if self.currentPage >= totalPage, self.currentPage != 1{
                    self.currentPage = totalPage
                    self.tableview.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
            }
            
            let models = Mapper<GCGoodsModel>().mapArray(JSONArray: result["data"] as! [[String: Any]])
            if self.currentPage == 1 {
                self.dataList = models
            }else {
                self.dataList.append(contentsOf: models)
            }
            
            if self.dataList.count != 0 {
                self.tableview.reloadData()
            }else {
                self.showNoData()
            }
            
            
        }) { (error) in
            self.tableview.mj_header.endRefreshing()
            self.tableview.mj_footer.endRefreshing()
            self.noDataView.refreshHeader?.endRefreshing()
            
            JYLog(error)
        }
        
    }
}
