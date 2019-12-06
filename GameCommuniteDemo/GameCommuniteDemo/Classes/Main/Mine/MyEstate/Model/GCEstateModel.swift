//
//  GCEstateModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/6.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper

class GCEstateModel : Mappable{

    var createdAt : String?
    var descriptionField : String?
    var eth : String?
    var id : Int?
    var type : Int?
    var updatedAt : String?
    var userId : Int?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        eth <- map["eth"]
        id <- map["id"]
        type <- map["type"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
        
    }
}
