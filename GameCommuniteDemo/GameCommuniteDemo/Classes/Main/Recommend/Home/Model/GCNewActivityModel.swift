//
//  GCNewActivityModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/7.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper


class GCNewActivityModel : Mappable{

    var content : String?
    var cover : String?
    var createdAt : String?
    var descriptionField : String?
    var id : Int?
    var title : String?
    var updatedAt : String?
    var url : String?


    required init?(map: Map){}

    func mapping(map: Map)
    {
        content <- map["content"]
        cover <- map["cover"]
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        id <- map["id"]
        title <- map["title"]
        updatedAt <- map["updated_at"]
        url <- map["url"]
        
    }
}
