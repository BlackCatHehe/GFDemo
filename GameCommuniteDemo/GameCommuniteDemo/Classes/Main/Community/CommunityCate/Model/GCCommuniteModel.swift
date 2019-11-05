//
//  GCCommuniteModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/30.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper


class GCCommuniteModel : Mappable{

    var cover : String?
    var createdAt : String?
    var id : Int?
    var introduce : String?
    var isJoin : Bool?
    var memberCount : Int?
    var name : String?
    var topicCount : Int?
    var updatedAt : String?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        cover <- map["cover"]
        createdAt <- map["created_at"]
        id <- map["id"]
        introduce <- map["introduce"]
        isJoin <- map["isJoin"]
        memberCount <- map["member_count"]
        name <- map["name"]
        topicCount <- map["topic_count"]
        updatedAt <- map["updated_at"]
        
    }
}
