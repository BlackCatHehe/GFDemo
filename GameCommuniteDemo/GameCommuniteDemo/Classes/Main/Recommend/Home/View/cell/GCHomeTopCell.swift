//
//  GCHomeTopCell.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/10.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable
import SDCycleScrollView

protocol GCHomeTopCellDelegate {
    func cell(_ cell: GCHomeTopCell, didSelectItemAt index: Int)
}

class GCHomeTopCell: UICollectionViewCell, NibReusable {

    var delegate: GCHomeTopCellDelegate?
    
    @IBOutlet private weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        bgView.addSubview(cycleImgV)
        cycleImgV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private lazy var cycleImgV: SDCycleScrollView = {[weak self] in
        let imagesV = SDCycleScrollView()
        imagesV.currentPageDotColor = .white
        imagesV.pageDotColor = kRGB(r: 153, g: 153, b: 153)
        imagesV.autoScroll = true
        imagesV.autoScrollTimeInterval = 3.0
        imagesV.bannerImageViewContentMode = .scaleAspectFill
        imagesV.infiniteLoop = true
        imagesV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        imagesV.layer.cornerRadius = adaptW(5.0)
        imagesV.layer.masksToBounds = true
        imagesV.delegate = self
        return imagesV
    }()
    
    func setModel() {
        cycleImgV.imageURLStringsGroup = ["https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg", "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3247749323,1379996244&fm=26&gp=0.jpg"]
        
    }
}

extension GCHomeTopCell: SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        delegate?.cell(self, didSelectItemAt: index)
    }
}
