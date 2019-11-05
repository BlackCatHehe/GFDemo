//
//  GCMineVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import MJRefresh

fileprivate struct Metric {
    static let cateSize = CGSize(width: adaptW(90.0), height: adaptW(90.0))
    
    static let cates = [
        [
            ["img": "mine_myItem", "title": "我的道具"],
            ["img": "mine_goods_manager", "title": "商品管理"],
            ["img": "mine_myAct", "title": "我的动态"],
            ["img": "mine_share", "title": "推荐给好友"]
        ],
        [
            ["img": "mine_mySale", "title": "我卖出的"],
            ["img": "mine_myBuy", "title": "我购买的"]
        ]
    ]
}

class GCMineVC: GCBaseVC {
    private var listDatas: [[[String: String]]] = Metric.cates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = nil
        initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBackgroundColor(bgColor: .clear, shadowColor: .clear)
    }
    
    //MARK: ------------lazyload------------
    private lazy var collectionView: UICollectionView = {[weak self] in
        let layout = JYCollectionViewFlowLayout()
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
        
        collectionV.register(cellType: GCMineCateCell.self)
        collectionV.register(supplementaryViewType: GCCommuniteResuableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        
        return collectionV
        }()
    private lazy var headerV: GCMineHeaderView = {
        let hV = GCMineHeaderView()
        return hV
    }()
}

//MARK: ------------createUI------------
extension GCMineVC {
    
    private func initUI() {
        
        self.componentInstall(with: JYNavigationComponents.setting) { (model) in
            let vc = GCSettingListVC()
            self.push(vc)
        }
        
        initCollectionView()
    }
    
    private func initCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: kStatusBarheight + kNavBarHeight + adaptW(424.0), left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kTabBarHeight)
        }
        
        headerV.setModel()
        headerV.clickMyEstate = {[weak self] in
            let vc = GCMyEstateVC()
            self?.push(vc)
        }
        headerV.frame = CGRect(x: 0, y: -kStatusBarheight - kNavBarHeight - adaptW(424.0), width: kScreenW, height: kStatusBarheight + kNavBarHeight + adaptW(424.0))
        collectionView.addSubview(headerV)
        
        
//        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            //self.currentPage = 1
//
//        })
        //
        //
        //        collectionView.mj_footer =  MJRefreshBackNormalFooter(refreshingBlock: {
        //            self.currentPage += 1
        //            self.requestListData()
        //        })
        //
        //
       // collectionView.mj_header.beginRefreshing()
    }
}


//MARK: ------------collectiondelegate------------
extension GCMineVC: UICollectionViewDelegate, UICollectionViewDataSource, JYCollectionDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listDatas[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: kScreenW, height: adaptW(60.0))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header: GCCommuniteResuableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: GCCommuniteResuableView.self)
        if indexPath.section == 0 {
            header.titleLb.text = "我的服务"
//            header.addSubview(self.addCateButton)
//            self.addCateButton.snp.makeConstraints { (make) in
//                make.right.equalToSuperview().offset(-15.0)
//                make.size.equalTo(CGSize(width: adaptW(88.0), height: adaptW(28.0)))
//                make.centerY.equalTo(header.titleLb)
//            }
        }else {
            header.titleLb.text = "我的购买"
        }
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = listDatas[indexPath.section][indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCMineCateCell.self) as GCMineCateCell
        cell.titleLb.text = model["title"]
        cell.imageV.image = UIImage(named: model["img"]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                showToast("暂未开放")
                let vc = GCLoginVC()
                push(vc)
            case 1:
                let vc = GCGoodsManagerVC()
                push(vc)
            case 2:
                let vc = GCPeopleMainPageVC()
                push(vc)
            case 3:
                showToast("暂未开放")
            default:
                break
            }
        }else  {
            let vc = GCSaleVC()
            vc.title = indexPath.row == 0 ? "我卖出的" : "我购买的"
            push(vc)
        }
        
//        let vc = GCCommunityDetailVC()
//        vc.communiteId = String(model.id!)
//        push(vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return Metric.cateSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return adaptW(15.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        let margin = (kScreenW - adaptW(5.0)*2 - Metric.cateSize.width * 4)/3
        JYLog(margin)
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: adaptW(5.0), bottom: 20, right: adaptW(5.0))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return MetricGlobal.mainCellBgColor
    }
}


extension GCMineVC {
    private func requestInfo() {
        let prama = ["phone": "15333831665"]
        GCNetTool.requestData(target: GCNetApi.getUserInfo(prama: prama), showAcvitity: true, success: { (result) in
            
            
            
        }) { (error) in
            JYLog(error)
        }
    }
}
