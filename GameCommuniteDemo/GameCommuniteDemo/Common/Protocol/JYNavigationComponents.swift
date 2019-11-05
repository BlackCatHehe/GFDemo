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
    static let back = JYNavigationComponentModel(title: nil, img: UIImage(named: "navigation_back"), selectedImg: nil, postiton: .left)
    
    static let search = JYNavigationSearchComponentModel(searchLeftImg: UIImage(named: "navigation_search"), searchRightImg: nil, placeholder: nil, attributedPlaceholder: "小霸王学习机".jys.add(kRGB(r: 229, g: 229, b: 229)).add(kFont(13.0)).base)
    
    static let searchCancel = JYNavigationComponentModel(title: "取消", img: nil, selectedImg: nil, postiton: .right)
    
    static let tipMessage = JYNavigationComponentModel(title: nil, img: UIImage(named: "recommend_tip")?.withRenderingMode(.alwaysOriginal), selectedImg: nil, postiton: .right)
    
    static let more = JYNavigationComponentModel(title: nil, img: UIImage(named: "navigation_more")?.withRenderingMode(.alwaysOriginal), selectedImg: nil, postiton: .right)
    static let share = JYNavigationComponentModel(title: nil, img: UIImage(named: "communite_share")?.withRenderingMode(.alwaysOriginal), selectedImg: nil, postiton: .right)
    static let setting = JYNavigationComponentModel(title: nil, img: UIImage(named: "mine_setting")?.withRenderingMode(.alwaysOriginal), selectedImg: nil, postiton: .right)
}

enum JYNavigationComponentss {
    case title(title: String)

}

extension JYNavigationComponentss {
    
    var type: JYNavigationComponentModel {
        switch self {
        case .title(let title):
            return JYNavigationComponentModel(title: title, img: nil, selectedImg: nil, postiton: .right)

            
        }
        
    }
}
