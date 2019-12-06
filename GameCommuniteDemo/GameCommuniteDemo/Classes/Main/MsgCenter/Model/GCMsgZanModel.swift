//
//  GCMsgZanModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/28.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper

class GCMsgZanModel : Mappable{

    var content : String?
    var createdAt : String?
    var id : Int?
    var isRead : Bool?
    var readAt : String?
    var sender : UserModel?
    var senderId : String?
    var target : Target?
    var updatedAt : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        content <- map["content"]
        createdAt <- map["created_at"]
        id <- map["id"]
        isRead <- map["is_read"]
        readAt <- map["read_at"]
        sender <- map["sender"]
        senderId <- map["sender_id"]
        target <- map["target"]
        updatedAt <- map["updated_at"]
        
    }
}

class Target : Mappable{
    
    var body : String?
    var commentCount : Int?
    var communityId : Int?
    var cover : String?
    var createdAt : String?
    var id : Int?
    var images : [AnyObject]?
    var isLike : Bool?
    var likeCount : Int?
    var title : String?
    var transferCount : Int?
    var updatedAt : String?
    var userId : Int?
    var videos : [AnyObject]?
    var viewCount : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        body <- map["body"]
        commentCount <- map["comment_count"]
        communityId <- map["community_id"]
        cover <- map["cover"]
        createdAt <- map["created_at"]
        id <- map["id"]
        images <- map["images"]
        isLike <- map["isLike"]
        likeCount <- map["like_count"]
        title <- map["title"]
        transferCount <- map["transfer_count"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
        videos <- map["videos"]
        viewCount <- map["view_count"]
        
    }
}
