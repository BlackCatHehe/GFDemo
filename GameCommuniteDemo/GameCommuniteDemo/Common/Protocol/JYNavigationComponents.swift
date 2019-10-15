//
//  JYNavigationComponents.swift
//  GameCommunity
//
//  Created by APP on 2019/9/29.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

struct JYNavigationComponents {
    //返回按钮
    static let back = JYNavigationComponentModel(title: nil, img: UIImage(named: "navigation_back"), selectedImg: nil, postiton: .left);
    
    static let search = JYNavigationSearchComponentModel(searchLeftImg: UIImage(named: "navigation_search"), searchRightImg: nil, placeholder: nil, attributedPlaceholder: "小霸王学习机".jys.add(UIColor.white).add(kFont(14.0)).base)
    
    static let searchCancel = JYNavigationComponentModel(title: "取消", img: nil, selectedImg: nil, postiton: .right);
    
    static let tipMessage = JYNavigationComponentModel(title: nil, img: UIImage(named: "navigation_sao")?.withRenderingMode(.alwaysOriginal), selectedImg: nil, postiton: .right);
    
    static let saoma = JYNavigationComponentModel(title: nil, img: UIImage(named: "navigation_sao")?.withRenderingMode(.alwaysOriginal), selectedImg: nil, postiton: .left);
    
    
}


