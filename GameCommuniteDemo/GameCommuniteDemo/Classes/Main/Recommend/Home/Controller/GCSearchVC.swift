//
//  GCSearchVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper
import MJRefresh
import SwiftyJSON

class GCSearchVC: GCBaseVC {

    ///数据源
    private var dataList: [GCGoodsModel] = []
    
    private var currentPage: Int = 1

    private var hotSearchs: [GCHotWord] = []
    
    ///第一次搜索的话把tableview添加到视图
    private var isFirstSearch: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        //获取热词
        requestPramas()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchView?.beFirstResponder()
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
    
    private var searchView: GCRecommendSearchHeaderBar?
    
    private lazy var tagView: JYTagView = {[weak self] in
        
        let tagV = JYTagView()
        tagV.itemHeight = adaptW(28.0)
        tagV.itemSpacing = adaptW(12.0)
        tagV.itemInsetPadding = adaptW(25.0)
        tagV.itemBuilder = {index -> UIView in
            let bt = UIButton()
            bt.backgroundColor = kRGB(r: CGFloat(arc4random()%255), g: CGFloat(arc4random()%255), b: CGFloat(arc4random()%255))
            bt.titleLabel?.font = kFont(14.0)
            bt.tag = index
            bt.layer.cornerRadius = adaptW(14.0)
            bt.addTarget(self, action: #selector(self?.clickTags(_:)), for: .touchUpInside)
            bt.layer.masksToBounds = true
            return bt
        }
        return tagV
    }()

}

//MARK: ------------createUI------------
extension GCSearchVC {
    
    private func initUI() {
        self.navigationItem.leftBarButtonItem = nil
        
        view.backgroundColor = MetricGlobal.mainBgColor
        initNaviSearchBar()
        initSearchHistory()

    }
    
    private func initNaviSearchBar() {
        //0.隐藏返回按钮
        navigationItem.setHidesBackButton(true, animated: true)
        
        //1.搜索
        let naviView = GCRecommendSearchHeaderBar(frame: CGRect(x: 0, y: kStatusBarheight, width: kScreenW - 2*adaptW(15.0) - adaptW(44.0)*2 - adaptW(10.0), height: kNavBarHeight), delegate: self)
        self.searchView = naviView
        maskNavigationBar(with: naviView)
        
        //2.cancel
        self.componentInstall(with: JYNavigationComponents.searchCancel) { (model) in
            
            self.dismissOrPop()
        }
    }
    
    private func initSearchHistory() {
        let titleSectionV = UIButton()
        titleSectionV.setTitle("热搜", for: .normal)
        titleSectionV.setImage(UIImage(named: "game_hot"), for: .normal)
        titleSectionV.titleLabel?.font = kFont(16.0)
        titleSectionV.layoutButton(style: .Left, imageTitleSpace: 5.0)
        view.addSubview(titleSectionV)
        titleSectionV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight + 20.0)
            make.width.equalTo(adaptW(60.0))
            make.height.equalTo(adaptW(15.0))
        }
        
        view.addSubview(self.tagView)
        tagView.snp.makeConstraints { (make) in
            make.top.equalTo(titleSectionV.snp.bottom).offset(adaptW(20.0))
            make.left.equalTo(titleSectionV)
            make.right.equalToSuperview().offset(-15.0)
        }
        
    }
    
    private func initTableview(){
        
        tableview.register(cellType: GCShopRecommendCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestSearchData()
        })
        noDataView.refreshHeader = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.requestSearchData()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.currentPage += 1
            self.requestSearchData()
        })
        tableview.mj_header.beginRefreshing()
    }
    
}

extension GCSearchVC: UITableViewDelegate, UITableViewDataSource {
    
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
        let cell: GCShopRecommendCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCShopRecommendCell.self)
        cell.setModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataList[indexPath.row]
        let vc = GCShopGoodsDetailVC()
        vc.gid = model.id
        push(vc)
    }
}

//MARK: ------------click------------
extension GCSearchVC {
    
    @objc private func clickTags(_ sender: UIButton){
        if let hotWord = hotSearchs[sender.tag].word {
            searchView?.text = hotWord
            if isFirstSearch {
                initTableview()
            }
            requestSearchData()
        }
    }
}


//MARK: ------------searchbarDelegate------------
extension GCSearchVC: GCRecommendSearchHeaderBarDelegate {
    
    func headerViewDidTapRightButton(_ headerView: GCRecommendSearchHeaderBar) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isFirstSearch {
            initTableview()
        }
        
        currentPage = 1
        requestSearchData()
        
        searchView?.reFirstResponder()
        
        return true
    }
    
}

extension GCSearchVC {
    
    ///请求数据
    private func requestSearchData() {
        
        guard let keyword = searchView?.text, !keyword.isEmpty() else {
            showToast("请输入关键词")
            return
        }

        let prama: [String: Any] = ["page" : currentPage,
                                    "keywords" : keyword]
        GCNetTool.requestData(target: GCNetApi.search(prama: prama), showAcvitity: false, success: { (result) in
            self.isFirstSearch = false
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
    
    //搜索热词
    private func requestPramas() {
        GCNetTool.requestData(target: GCNetApi.goodsSortPramas, showAcvitity: false, success: { (result) in
            
            if let model = Mapper<GCGoodsSortModel>().map(JSON: result) {
                if let hots = model.hotWords {
                    self.hotSearchs = hots
                    self.tagView.titles = hots.map{$0.word!}
                    self.tagView.reloadData()
                }
            }
            
        }) { (error) in
            
            JYLog(error)
        }
    }
    
    
}
