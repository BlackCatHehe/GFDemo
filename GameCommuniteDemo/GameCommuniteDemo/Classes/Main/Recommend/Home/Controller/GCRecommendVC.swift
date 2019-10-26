//
//  GCRecommendVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import MJRefresh
import Kingfisher
fileprivate struct Metric {
    static let topCellSize = CGSize(width: kScreenW - 15 * 2, height: (kScreenW - 15 * 2) * 162.0/345.0)
    static let cateSize = CGSize(width: adaptW(70.0), height: adaptW(90.0))
    static let sanItemSize = CGSize(width: kScreenW, height: (kScreenW - 15 * 2) * 223.0/345.0)
    static let zixunItemSize = CGSize(width: kScreenW, height: adaptW(100.0))
}

class GCRecommendVC: GCBaseVC {
    
    private let datas = [
        ["title": "姜还是老的辣？如何看待doda2高龄化现象", "view_num": "12523", "time": "刚刚", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
        ["title": "魔兽世界怀旧复：玩家吵了十五年，发誓开门到底该不该收钱", "view_num": "12523", "time": "5分钟前", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
        ["title": "姜还是老的辣？如何看待doda2高龄化现象", "view_num": "12523", "time": "刚刚", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
        ["title": "魔兽世界怀旧复：玩家吵了十五年，发誓开门到底该不该收钱", "view_num": "12523", "time": "10-09", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"],
        ["title": "姜还是老的辣？如何看待doda2高龄化现象", "view_num": "12523", "time": "03-12", "img": "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"]
    ]
    
    //MARK: ------------cyclelife------------
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = nil
        
        initUI()
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
        
        collectionV.register(cellType: GCHomeTopCell.self)
        collectionV.register(cellType: GCCateCell.self)
        collectionV.register(cellType: GCRecommendSanCell.self)
        collectionV.register(cellType: GCRecommendZixunCell.self)
        collectionV.register(supplementaryViewType: GCNormalReusableHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        
        return collectionV
        }()
    
    private lazy var tipBt: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30.0, height: 30.0))
        button.setImage(UIImage(named: "recommend_tip"), for: .normal)
        return button
    }()
    
}

//MARK: ------------createUI------------
extension GCRecommendVC {
    
    private func initUI() {

        initNaviSearchBar()
        initCollectionView()
    }
    
    private func initNaviSearchBar() {
        //1.搜索
        let naviView = GCRecommendSearchHeaderBar(frame: CGRect(x: 0, y: kStatusBarheight, width: kScreenW - 2*15 - 44*2, height: kNavBarHeight), delegate: self)
        maskNavigationBar(with: naviView)
        
        //2.message
        let customItem = UIBarButtonItem(customView: tipBt)
        self.navigationItem.rightBarButtonItem = customItem
        tipBt.showBadgeDot(-1, 0)
        tipBt.rx.tap
            .bind{[weak tipBt, weak self] in
                tipBt?.removeBadge()
                let vc = GCMessageCenterVC()
                self?.push(vc)
        }.disposed(by: rx.disposeBag)

    }
    
    private func initCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
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

//MARK: ------------searchbarDelegate------------
extension GCRecommendVC: GCRecommendSearchHeaderBarDelegate {
    
    func headerViewDidTapRightButton(_ headerView: GCRecommendSearchHeaderBar) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let vc = GCSearchVC()
        push(vc)
        
        return false
    }
}
//MARK: ------------collectiondelegate------------
extension GCRecommendVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3 {
            return datas.count
        }else if section == 1{
            return 3
        }else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSize(width: kScreenW, height: 40.0)
        }else {
            return .zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header: GCNormalReusableHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: GCNormalReusableHeaderView.self)
        header.backgroundColor = kRGB(r: 27, g: 26, b: 47)
        header.iconImgV.image = UIImage(named: "recommend_section")
        header.titleLb.text = "最新资讯"
            return header

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCHomeTopCell.self)
        
            let imgV = UIImageView(frame: cell.bounds)
            imgV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(5.0), targetSize: imgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
            imgV.contentMode = .scaleAspectFill
            imgV.clipsToBounds = true
            cell.addSubview(imgV)
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCCateCell.self)
            cell.iconImgV.kf.setImage(with: URL(string: "https://i.52112.com/icon/jpg/256/20190424/37588/1788145.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: cell.iconImgV.bounds.size.width/2, targetSize: cell.iconImgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
            cell.titleLb.text = "分类"
            return cell
        }else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCRecommendSanCell.self)
            cell.layoutIfNeeded()
            cell.leftImgV.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2334465942,3760491718&fm=115&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(5.0), targetSize: cell.leftImgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
            cell.rightTopImgV.kf.setImage(with: URL(string: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2120552043,3915997002&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(5.0), targetSize: cell.rightTopImgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
            cell.rightBottomImgV.kf.setImage(with: URL(string: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4140453287,1307687785&fm=26&gp=0.jpg"), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(5.0), targetSize: cell.rightBottomImgV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCRecommendZixunCell.self)
            cell.layoutIfNeeded()
            let dic = datas[indexPath.row]
            cell.titleLb.text = dic["title"]
            cell.viewNumLb.text = dic["view_num"]
            cell.timeLb.text = dic["time"]
            cell.imageV.kf.setImage(with: URL(string: dic["img"]!), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: adaptW(5.0), targetSize: cell.imageV.bounds.size, roundingCorners: [.all], backgroundColor: nil))], progressBlock: nil, completionHandler: nil)
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let vc = GCGameUsualListVC()
                push(vc)
            case 1:
                let vc = GCNewUpVC()
                push(vc)
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return Metric.topCellSize
        case 1:
            return Metric.cateSize
        case 2:
            return Metric.sanItemSize
        case 3:
            return Metric.zixunItemSize
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            let margin = (kScreenW - 15*2 - adaptW(70.0) * 3)/3
            JYLog(margin)
            return margin
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 0:
            return UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15)
        case 1:
            return UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        default:
            return .zero
        }
        
    }
    
}


