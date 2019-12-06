//
//  GCCheapActivityModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper

class GCCheapActivityModel : Mappable{

    var content : String?
    var createdAt : String?
    var id : Int?
    var isRead : Bool?
    var readAt : String?
    var senderId : String?
    var target : GCAcvitityContentModel?
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
        target <- map["target"]
        updatedAt <- map["updated_at"]
        
    }
}

class GCAcvitityContentModel : Mappable{
    
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
