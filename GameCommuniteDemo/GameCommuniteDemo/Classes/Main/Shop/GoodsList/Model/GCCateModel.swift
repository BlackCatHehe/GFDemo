//
//  GCCateModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/1.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper

class GCCateModel : Mappable{

    var createdAt : String?
    var descriptionField : String?
    var id : Int?
    var name : String?
    var updatedAt : String?

    required init?(map: Map){}


    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        id <- map["id"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        
    }
}
