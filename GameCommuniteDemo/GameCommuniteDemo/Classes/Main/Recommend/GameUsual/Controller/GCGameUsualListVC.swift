//
//  GCGameUsualListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/22.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import SDCycleScrollView
import ObjectMapper
import MJRefresh
import SwiftyJSON

class GCGameUsualListVC: GCBaseVC {
    
    ///数据源
    private var dataList: [GCGameModel] = []

    ///轮播图数据
    private var bannerModels: [GCBannerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "游戏精选"
        initUI()
        requestBanner()
    }
    
    //MARK: ------------lazyload------------
    private lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.backgroundColor = MetricGlobal.mainBgColor
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            collectionV.contentInsetAdjustmentBehavior = .never
            self?.extendedLayoutIncludesOpaqueBars = true//navigabar不透明
        } else {
            self?.automaticallyAdjustsScrollViewInsets = false
        }
        
        collectionV.register(cellType: GCUsualGameCell.self)
        return collectionV
        }()
    

    
    private lazy var cycleImgV: SDCycleScrollView = {[weak self] in
        let imagesV = SDCycleScrollView(frame: CGRect(x: adaptW(15.0), y:-adaptW(175.0) , width: kScreenW - adaptW(15.0)*2, height: adaptW(165.0)))
        imagesV.currentPageDotColor = .white
        imagesV.pageDotColor = kRGB(r: 153, g: 153, b: 153)
        imagesV.autoScroll = true
        imagesV.autoScrollTimeInterval = 3.0
        imagesV.bannerImageViewContentMode = .scaleAspectFill
        imagesV.infiniteLoop = true
        imagesV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        imagesV.delegate = self
        return imagesV
    }()
}

//MARK: ------------createUI------------
extension GCGameUsualListVC {
    
    private func initUI() {
        
        initCollectionView()
        initCateTopView()
    }
    
    private func initCateTopView() {
        collectionView.addSubview(self.cycleImgV)
//        cycleImgV.snp.makeConstraints { (make) in
//            make.top.equalTo(adaptW(175.0))
//            make.left.equalToSuperview().offset(adaptW(15.0))
//            make.right.equalToSuperview().offset(-adaptW(15.0))
//            make.height.equalTo(adaptW(165.0))
//        }
        
    }
    
    private func initCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: adaptW(192.0), left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let header = MJRefreshNormalHeader(refreshingBlock: {
        
                 self.requestListData()
             })
        header?.ignoredScrollViewContentInsetTop = adaptW(192.0)
        
        collectionView.mj_header = header
   
        collectionView.mj_header.beginRefreshing()
    }
}

//MARK: ------------collectiondelegate------------
extension GCGameUsualListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCUsualGameCell.self) as GCUsualGameCell
        cell.setModel(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataList[indexPath.row]
        let vc = GCGameDetailVC()
        vc.pageModel = model
        push(vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (kScreenW - adaptW(15.0*2) - adaptW(10.0))/2, height: (kScreenW - adaptW(15.0*2) - adaptW(10.0))/2 * 130/168)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return adaptW(10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return adaptW(10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 0, left: adaptW(15.0), bottom: kBottomH + 10, right: adaptW(15.0))
        
        
    }
}

//MARK: ------------sdcycledelegate------------
extension GCGameUsualListVC: SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
}

//MARK: ------------request------------
extension GCGameUsualListVC {
    
    ///请求数据
    private func requestListData() {
        GCNetTool.requestData(target: GCNetApi.hotGameList(prama: ["include" : "images,labels,characteristics"]), showAcvitity: true, success: { (result) in
            self.collectionView.mj_header.endRefreshing()
            
            if let datas = result["data"] as? [[String : Any]] {
                let models = Mapper<GCGameModel>().mapArray(JSONArray: datas)
                self.dataList = models
                self.collectionView.reloadData()
            }
            
        }) { (error) in
            self.collectionView.mj_header.endRefreshing()
            JYLog(error)
        }
        
    }
    
    ///请求头部轮播图
    private func requestBanner() {
        
        GCNetTool.requestData(target: GCNetApi.banner(prama: ["position_id" : 2]), showAcvitity: false, success: { (result) in
            
            if let datas = result["data"] as? [[String: Any]] {
                let models = Mapper<GCBannerModel>().mapArray(JSONArray: datas)
 
                self.cycleImgV.imageURLStringsGroup = models.map{$0.cover!}
            }
            
         
        }) { (error) in
         
            JYLog(error)
        }
    }
    
    
}
