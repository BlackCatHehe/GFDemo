//
//  GCAssGoodsSortVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/18.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import ObjectMapper

fileprivate struct Metric {
    static let itemSize = CGSize(width: adaptW(80.0), height: 30.0)
}

class GCAssGoodsSortVC: GCBaseVC {

    var clickSort: (([String: Any]) -> ())?

    private var serverSorts: GCGoodsSortModel?
    
    private var normalSorts: [[GCSortPrama]] = []
    
    private var sorts: [[String : Any]] =  [
        ["title": "时间排序",
         "items": ["时间↓", "时间↑"],
         "isSel" : 2 //0. 选择 时间↓ 1. 选择 时间↑ 2.未选择
        ],
        ["title": "价值排序",
         "items": ["价值↓", "价值↑"],
         "isSel" : 2
        ],
        ["title": "分类"],
        ["title": "品质"],
        ["title": "稀有度"]
    ]
    
    
    private var itemSels: [Int?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemSels = Array(repeating: nil, count: sorts.count)
        
        initUI()
        
        requestPramas()
    }
    
    //MARK: ------------lazyload------------
     private lazy var collectionView: UICollectionView = {[weak self] in
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionV.backgroundColor = MetricGlobal.mainCellBgColor
         collectionV.delegate = self
         collectionV.dataSource = self
         collectionV.showsVerticalScrollIndicator = false
         
         if #available(iOS 11.0, *) {
             collectionV.contentInsetAdjustmentBehavior = .never
             self?.extendedLayoutIncludesOpaqueBars = true//navigabar不透明
         } else {
             self?.automaticallyAdjustsScrollViewInsets = false
         }
         
         collectionV.register(cellType: GCSortCell.self)
         collectionV.register(supplementaryViewType: GCTitleReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
         
         return collectionV
         }()
}

extension GCAssGoodsSortVC {
    
    private func initUI() {
        self.view.backgroundColor = MetricGlobal.mainCellBgColor
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kNavBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let bgBottomV = UIView()
        view.addSubview(bgBottomV)
        let buttonsV = GCSortBottomButtonsView()
        bgBottomV.addSubview(buttonsV)
        bgBottomV.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-kBottomH)
            make.right.equalToSuperview().offset(adaptW(-15.0))
            make.height.equalTo(adaptW(44.0))
            
        }
        buttonsV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.left.equalToSuperview()
            make.width.equalTo(adaptW(187.0))
            make.height.equalTo(adaptW(38.0))
        }
        //TODO: 点击事件
        buttonsV.tapButton = {[weak self] index in
            guard let weakself = self else {return}
            if index == 0 {//重制
                weakself.cancelAllSel()
            }else {//确认
                weakself.entrueSort()
                JYLog(weakself.itemSels)
            }
        }
    }
    ///重制选择
    private func cancelAllSel() {
        
        sorts[0]["isSel"] = 3
        sorts[1]["isSel"] = 3

        if let item = itemSels[2] {
            normalSorts[0][item].isSel = false
        }
        if let item = itemSels[3] {
            normalSorts[1][item].isSel = false
        }
        if let item = itemSels[4] {
            normalSorts[2][item].isSel = false
        }
        
        collectionView.reloadData()
    }
    
    ///将选中的item转化为商品筛选需要的参数
    private func entrueSort() {
        var sortPramas = [String : Any]()
        if let item = itemSels[0] {
            sortPramas["time_sort"] = item == 0 ? "desc" : "asc"
        }
        if let item = itemSels[1] {
            sortPramas["price_sort"] = item == 0 ? "desc" : "asc"
        }
        if let item = itemSels[2] {
            if let cid = serverSorts?.categories?[item].id {
                sortPramas["category_id"] = cid
            }
        }
        if let item = itemSels[3] {
            if let qid = serverSorts?.qualities?[item].id {
                sortPramas["quality"] = qid
            }
        }
        if let item = itemSels[4] {
            if let rid = serverSorts?.rarities?[item].id {
                sortPramas["rarity"] = rid
            }
        }
        
        JYLog("筛选参数: \(sortPramas)")
        
        clickSort?(sortPramas)
        
        self.dismissOrPop()
    }
}

//MARK: ------------collectiondelegate------------
extension GCAssGoodsSortVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sorts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < 2 {
            if let items = sorts[section]["items"] as? [String] {
                return items.count
            }else {
                return 0
            }
        }else {
            return normalSorts[section - 2].count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: kScreenW, height: 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header: GCTitleReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: GCTitleReusableView.self)
        header.backgroundColor = MetricGlobal.mainCellBgColor
        header.title = sorts[indexPath.section]["title"] as? String
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCSortCell.self)
        if indexPath.section < 2 {
            if let items = sorts[indexPath.section]["items"] as? [String] {
                cell.title = items[indexPath.row]
                cell.isSel = (sorts[indexPath.section]["isSel"] as! Int) == indexPath.row
            }
        }else {
            let model = normalSorts[indexPath.section - 2][indexPath.row]
            cell.title = model.name
            cell.isSel = model.isSel
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section < 2 {
    
            sorts[indexPath.section]["isSel"] = indexPath.row
            
        }else {
            if let oldSel = itemSels[indexPath.section] {
                normalSorts[indexPath.section - 2][oldSel].isSel = false
            }
            normalSorts[indexPath.section - 2][indexPath.row].isSel = true
        }
        
        //取消旧的选择
        if let oldSel = itemSels[indexPath.section] {
            
            let oldIndex = IndexPath(row: oldSel, section: indexPath.section)
            UIView.performWithoutAnimation {
                collectionView.reloadItems(at: [oldIndex])
            }
        }
        //更新新的选择
        UIView.performWithoutAnimation {
            collectionView.reloadItems(at: [indexPath])
        }
        
        //保存新的选择
        itemSels[indexPath.section] = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return Metric.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 15, bottom: section == self.sorts.count - 1 ? kBottomH + adaptW(50.0) : 0, right: 15)

    }
}

extension GCAssGoodsSortVC {
    
    private func requestPramas() {
        GCNetTool.requestData(target: GCNetApi.goodsSortPramas, showAcvitity: false, success: { (result) in
            
            if let model = Mapper<GCGoodsSortModel>().map(JSON: result) {
                self.serverSorts = model
                
                if let items = model.categories {
                    self.normalSorts.append(items)
                }
                
                if let items = model.qualities {
                    self.normalSorts.append(items)
                }
                
                if let items = model.rarities {
                    self.normalSorts.append(items)
                }

                self.collectionView.reloadData()
            }
            
        }) { (error) in

            JYLog(error)
        }
    }
    
}
