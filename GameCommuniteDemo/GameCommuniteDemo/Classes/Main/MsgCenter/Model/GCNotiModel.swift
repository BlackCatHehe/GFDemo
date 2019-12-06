//
//  GCNotiModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper

class GCNotiModel: Mappable{

    var content : String?
    var createdAt : String?
    var id : Int?
    var isRead : Bool?
    var readAt : String?
    var senderId : String?
    var title : String?
    var updatedAt : String?


    required init?(map: Map){}


    func mapping(map: Map)
    {
        content <- map["content"]
        createdAt <- map["created_at"]
        id <- map["id"]
        isRead <- map["is_read"]
        readAt <- map["read_at"]
        senderId <- map["sender_id"]
        title <- map["title"]
        updatedAt <- map["updated_at"]
        
    }
}
