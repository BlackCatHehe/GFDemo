//
//  GCOrderModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/9.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper


class GCOrderListModel : Mappable{

    var createdAt : String?
    var id : Int?
    var items : [GCOrderModel]?
    var no : String?
    var status : Int?
    var totalAmount : String?
    var updatedAt : String?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        id <- map["id"]
        items <- map["items.data"]
        no <- map["no"]
        status <- map["status"]
        totalAmount <- map["total_amount"]
        updatedAt <- map["updated_at"]
        
    }
}

class GCOrderModel : Mappable{
    
    var amount : Int?
    var createdAt : String?
    var id : Int?
    var ornament : GCGoodsModel?
    var price : String?
    var updatedAt : String?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        amount <- map["amount"]
        createdAt <- map["created_at"]
        id <- map["id"]
        ornament <- map["ornament"]
        price <- map["price"]
        updatedAt <- map["updated_at"]
        
    }
}
