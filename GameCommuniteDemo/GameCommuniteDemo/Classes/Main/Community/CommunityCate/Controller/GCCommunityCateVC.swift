//
//  GCCommunityCateVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit

fileprivate struct Metric {

    static let cateSize = CGSize(width: adaptW(90.0), height: adaptW(90.0 + 20))
    static let addCateSize = CGSize(width: adaptW(90.0), height: adaptW(90.0 + 20.0 + 22.0 + 10.0))

}

class GCCommunityCateVC: GCBaseVC {

    private let datas = [
           ["title": "姜还是", "view_num": "12523", "time": "刚刚", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
           ["title": "魔兽世界", "view_num": "12523", "time": "5分钟前", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
           ["title": "姜还是老的辣", "view_num": "12523", "time": "刚刚", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
           ["title": "魔兽", "view_num": "12523", "time": "10-09", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
           ["title": "姜还是老", "view_num": "12523", "time": "03-12", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"]
       ]
    
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
        button.backgroundColor = MetricGlobal.mainButtonBgColor
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
        
//        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            self.currentPage = 1
//            self.requestListData()
//        })
//
//
//        collectionView.mj_footer =  MJRefreshBackNormalFooter(refreshingBlock: {
//            self.currentPage += 1
//            self.requestListData()
//        })
//
//
//        collectionView.mj_header.beginRefreshing()
    }
}


//MARK: ------------collectiondelegate------------
extension GCCommunityCateVC: UICollectionViewDelegate, UICollectionViewDataSource, JYCollectionDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 5 : 3
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
        
        let dic = datas[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCCommuniteCateCell.self) as GCCommuniteCateCell
        cell.delegate = self
        cell.setModel(dic, isAdd: indexPath.section == 0 ? false : true)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = GCCommunityDetailVC()
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
        
    }
}

//MARK: ------------click------------
extension GCCommunityCateVC {
    
    @objc private func clickCreate() {
        
    }
}
