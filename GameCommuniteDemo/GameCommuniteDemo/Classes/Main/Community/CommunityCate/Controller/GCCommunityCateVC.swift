//
//  GCCommunityCateVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import MJRefresh
import ObjectMapper

fileprivate struct Metric {
    static let cateSize = CGSize(width: adaptW(90.0), height: adaptW(90.0 + 20))
    static let addCateSize = CGSize(width: adaptW(90.0), height: adaptW(90.0 + 20.0 + 22.0 + 10.0))
}

class GCCommunityCateVC: GCBaseVC {

    private var listDatas: [[GCCommuniteModel]] = []
           
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
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
        
        collectionV.register(cellType: GCCommuniteCateCell.self)
        collectionV.register(supplementaryViewType: GCCommuniteResuableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        
        return collectionV
        }()
    
    private lazy var addCateButton: UIButton = {[weak self] in
       let button = UIButton()
        button.setTitle("创建社区", for: .normal)
        button.backgroundColor = MetricGlobal.mainBlue
        button.titleLabel?.font = kFont(14.0)
        button.layer.cornerRadius = adaptW(14.0)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(clickCreate), for: .touchUpInside)
        return button
    }()
}

//MARK: ------------createUI------------
extension GCCommunityCateVC {
    
    private func initUI() {

        initCollectionView()
    }
    
    private func initCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kTabBarHeight)
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            //self.currentPage = 1
            self.requestListData()
        })
//
//
//        collectionView.mj_footer =  MJRefreshBackNormalFooter(refreshingBlock: {
//            self.currentPage += 1
//            self.requestListData()
//        })
//
//
        collectionView.mj_header.beginRefreshing()
    }
}


//MARK: ------------collectiondelegate------------
extension GCCommunityCateVC: UICollectionViewDelegate, UICollectionViewDataSource, JYCollectionDelegateFlowLayout {
    
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
            header.titleLb.text = "已加入的社区"
            header.addSubview(self.addCateButton)
            self.addCateButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-15.0)
                make.size.equalTo(CGSize(width: adaptW(88.0), height: adaptW(28.0)))
                make.centerY.equalTo(header.titleLb)
            }
        }else {
            header.titleLb.text = "公共社区"
        }
        
        return header

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = listDatas[indexPath.section][indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCCommuniteCateCell.self) as GCCommuniteCateCell
        cell.delegate = self
        cell.setModel(model)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.listDatas[indexPath.section][indexPath.row]
        let vc = GCCommunityDetailVC()
        vc.communiteId = String(model.id!)
        push(vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return indexPath.section == 0 ? Metric.cateSize : Metric.addCateSize
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

//MARK: ------------cateCell delegate------------
extension GCCommunityCateVC: GCCommuniteCateCellDelegate {
    
    func cateCell(_ cell: GCCommuniteCateCell, didClickAdd button: UIButton) {
        if let index = collectionView.indexPath(for: cell) {
            let model = self.listDatas[index.section][index.row]
            requestAddCommunite(model: model)
        }
    }
}

//MARK: ------------click------------
extension GCCommunityCateVC {
    
    @objc private func clickCreate() {
        let vc = GCCreateCommuniteVC()
        push(vc)
    }
}

//MARK: ------------reuqest------------
extension GCCommunityCateVC {
    
    ///请求列表数据
    private func requestListData() {
        /**
        {
          "data" : [
            {
              "cover" : "http:\/\/res.uioj.com\/images\/apiUpload\/\/2019\/10\/e38UuOZ6oZMkD1LNc0ZeI1oXiBBHjBeL9dmGuZi8.jpeg",
              "isJoin" : false,
              "introduce" : "欢迎年轻人来照顾老年程序员们",
              "member_count" : 0,
              "updated_at" : "2019-10-30 05:40:13",
              "id" : 1,
              "created_at" : "2019-10-30 05:40:13",
              "name" : "老年活动中心",
              "topic_count" : 0
            }
          ]
        }
        */

        GCNetTool.requestData(target: GCNetApi.communiteList, success: { (result) in
            
            if let data = result["data"] as? [[String: Any]] {
                
                let models = Mapper<GCCommuniteModel>().mapArray(JSONArray: data)
                let joins = models.filter{$0.isJoin == true}
                let noJoins = models.filter{$0.isJoin == false}
                self.listDatas = [joins, noJoins]
                self.collectionView.reloadData()
            }
            
            
            self.collectionView.mj_header.endRefreshing()
        }) { (error) in
            JYLog(error)
            self.collectionView.mj_header.endRefreshing()
        }
    }
    
    ///请求加入社团
    private func requestAddCommunite(model: GCCommuniteModel) {
        /**

        */
        guard let communityId = model.id else{return}
        GCNetTool.requestData(target: GCNetApi.joinCommunite(prama: String(communityId)), success: { (result) in
            
           
        }) { (error) in
            JYLog(error)
            
        }
    }
}
