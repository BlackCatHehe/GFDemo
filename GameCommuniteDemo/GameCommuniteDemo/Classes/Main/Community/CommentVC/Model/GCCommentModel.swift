//
//  GCCommentModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper

class GCCommentModel : Mappable{

    var content : String?
    var createdAt : String?
    var id : Int?
    var isLike : Bool?
    var likeCount : Int?
    var replies : [GCCommentReplyModel]?
    var topicId : Int?
    var updatedAt : String?
    var user : UserModel?
    var userId : Int?
    
    ///自己添加的属性，用来表示3条以上是否折叠回复
    var isFolded: Bool = true

    required init?(map: Map){}


    func mapping(map: Map)
    {
        content <- map["content"]
        createdAt <- map["created_at"]
        id <- map["id"]
        isLike <- map["isLike"]
        likeCount <- map["like_count"]
        replies <- map["replies.data"]
        topicId <- map["topic_id"]
        updatedAt <- map["updated_at"]
        user <- map["user"]
        userId <- map["user_id"]
        
    }

}

class GCCommentReplyModel : Mappable{
    
    var content : String?
    var createdAt : String?
    var id : Int?
    var updatedAt : String?
    var parent : UserModel?
    var user : UserModel?
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        content <- map["content"]
        createdAt <- map["created_at"]
        id <- map["id"]
        updatedAt <- map["updated_at"]
        parent <- map["parent.user"]
        user <- map["user"]
    }
}
