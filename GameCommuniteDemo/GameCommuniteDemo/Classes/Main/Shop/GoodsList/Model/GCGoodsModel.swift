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

    var attributes : [[String : Any]]?
    var comments : [GCCommentModel]?
    var content : String?
    var cover : String?
    var createdAt : String?
    var id : Int?
    var images : [String]?
    var name : String?
    var originalPrice : String?
    var price : String?
    var relations : [GCGoodsModel]?
    var soldCount : Int?
    var status : Int?
    var stock : Int?
    var updatedAt : String?
    var userId : Int?
    var user: UserModel?
    var isBestSeller: Bool?
    
    required init?(map: Map){}

    func mapping(map: Map)
    {
        attributes <- map["attributes.data"]
        comments <- map["comments.data"]
        content <- map["content"]
        cover <- map["cover"]
        createdAt <- map["created_at"]
        id <- map["id"]
        images <- map["images"]
        name <- map["name"]
        originalPrice <- map["original_price"]
        price <- map["price"]
        relations <- map["relations.data"]
        soldCount <- map["sold_count"]
        status <- map["status"]
        stock <- map["stock"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
        user <- map["user"]
        isBestSeller <- map["is_best_seller"]
    }
}
