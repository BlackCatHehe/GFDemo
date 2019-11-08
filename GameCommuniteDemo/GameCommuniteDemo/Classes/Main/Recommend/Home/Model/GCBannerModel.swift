//
//  GCBannerModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/7.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper


class GCBannerModel : Mappable{

    var cover : String?
    var createdAt : String?
    var descriptionField : String?
    var id : Int?
    var name : String?
    var updatedAt : String?
    var url : String?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        cover <- map["cover"]
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        id <- map["id"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        url <- map["url"]
        
    }
}
