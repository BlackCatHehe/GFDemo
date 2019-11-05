//
//  GCGoodsModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/5.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper


class GCGoodsModel : Mappable{

    var content : String?
    var cover : String?
    var createdAt : String?
    var id : Int?
    var name : String?
    var originalPrice : String?
    var price : String?
    var soldCount : Int?
    var status : Int?
    var stock : Int?
    var updatedAt : String?
    var userId : Int?

    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        content <- map["content"]
        cover <- map["cover"]
        createdAt <- map["created_at"]
        id <- map["id"]
        name <- map["name"]
        originalPrice <- map["original_price"]
        price <- map["price"]
        soldCount <- map["sold_count"]
        status <- map["status"]
        stock <- map["stock"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
        
    }
}
