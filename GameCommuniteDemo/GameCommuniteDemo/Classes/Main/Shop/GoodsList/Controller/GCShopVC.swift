//
//  GCShopVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
fileprivate struct Metric {
    static let goodsItemSize = CGSize(width: (kScreenW - 15 * 2 - 10)/2, height: (kScreenW - 15 * 2 - 10)/2 * 103.0/167.0 + adaptW(47.0 + 10.0))
    
    static let normalTagBgColor = kRGB(r: 79, g: 107, b: 149)
    static let selTagBgColor = MetricGlobal.mainBlue
    static let normalTagFont = kFont(adaptW(14.0))
    static let selTagFont = kFont(adaptW(15.0), "HelveticaNeue-Medium")
    
    static let tagWidth = (kScreenW - adaptW(12.0*3) - adaptW(15.0*2) - adaptW(30.0 + 20.0))/4
}

class GCShopVC: GCBaseVC {

    private var selectIndex: Int = 0
    
    //MARK: ------------cyclelife------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "商城"
        
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
        
        collectionV.register(cellType: GCShopGoodsListCell.self)
        return collectionV
        }()
    
    private lazy var tagView: JYTagView = {[weak self] in
        let tagV = JYTagView()
        tagV.itemHeight = adaptW(34.0)
        tagV.itemWidth = Metric.tagWidth
        tagV.itemSpacing = adaptW(12.0)
        tagV.itemInsetPadding = adaptW(21.0)
        tagV.clipsToBounds = true
        tagV.moreButton = {
            let bt = UIButton()
            bt.setImage(UIImage(named: "shop_jiantou_xia"), for: .normal)
            bt.setImage(UIImage(named: "shop_jiantou_shang"), for: .selected)
            bt.addTarget(self!, action: #selector(self?.moreTag(_ :)), for: .touchUpInside)
            return bt
        }()
        tagV.buttonMargin = adaptW(10.0)
        
        let titles = ["全部", "嗷嗷", "播报", "等等", "间隔下降"]
        tagV.itemBuilder = {index -> UIView in
            let bt = UIButton()
            bt.setTitle(titles[index], for: .normal)
            bt.backgroundColor = index == 0 ? Metric.selTagBgColor : Metric.normalTagBgColor
            bt.titleLabel?.font = index == 0 ? Metric.selTagFont : Metric.normalTagFont
            bt.isSelected = index == 0 ? true : false
            bt.tag = index + 100
            bt.layer.cornerRadius = adaptW(17.0)
            bt.layer.masksToBounds = true
            bt.addTarget(self!, action: #selector(self?.selectTag(_ :)), for: .touchUpInside)
            return bt
        }
        return tagV
    }()
}

//MARK: ------------createUI------------
extension GCShopVC {
    
    private func initUI() {
        
        initCateTopView()
        initCollectionView()

    }
    
    private func initCateTopView() {
        view.addSubview(self.tagView)
        tagView.snp.makeConstraints { (make) in
            make.top.equalTo(kStatusBarheight + kNavBarHeight + adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            make.height.equalTo(tagView.itemHeight)
        }
        
        tagView.titles = ["全部", "嗷嗷", "播报", "等等", "间隔下降"]
        
        if tagView.titles.count < 5 {
            tagView.moreButton?.isHidden = true
        }
        tagView.reloadData()
    }
    
    private func initCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(tagView.snp.bottom).offset(adaptW(10.0))
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
extension GCShopVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GCShopGoodsListCell.self) as GCShopGoodsListCell
        cell.setModel()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = GCShopGoodsDetailVC()
        push(detailVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return Metric.goodsItemSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: kBottomH + 10, right: 15)
    
    }
}

//MARK: ------------click------------
extension GCShopVC {
    
    @objc private func selectTag(_ sender: UIButton) {
        let tag = sender.tag - 100
        
        //点击选中的按钮，直接返回
        if tag == selectIndex {
            return
        }
        
        //反之 设置其为选中的样式
        sender.backgroundColor = Metric.selTagBgColor
        sender.titleLabel?.font = Metric.selTagFont
        
        //拿到之前选中的按钮，将其变为未选中
        for tagV in tagView.tagViews {
            if let bt = tagV as? UIButton, bt.tag == selectIndex + 100 {
                bt.isSelected = false
                bt.backgroundColor = Metric.normalTagBgColor
                bt.titleLabel?.font = Metric.normalTagFont
                break
            }
        }
        
        //将点击的按钮赋值给selectindex
        selectIndex = tag
        
    }
    
    @objc private func moreTag(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        tagView.snp.remakeConstraints { (make) in
            make.top.equalTo(kStatusBarheight + kNavBarHeight + adaptW(10.0))
            make.left.equalToSuperview().offset(adaptW(15.0))
            make.right.equalToSuperview().offset(-adaptW(15.0))
            if !sender.isSelected {
                make.height.equalTo(tagView.itemHeight)
            }
            
        }
        
    }
    
}
