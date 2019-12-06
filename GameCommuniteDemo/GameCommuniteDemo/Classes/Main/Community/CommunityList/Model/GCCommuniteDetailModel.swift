//
//  GCCommuniteDetailModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/30.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper

class GCCommuniteDetailModel : Mappable{
    
    var topTopics : [GCTopicModel]?
    var cover : String?
    var createdAt : String?
    var id : Int?
    var introduce : String?
    var isJoin : Bool?
    var memberCount : Int?
    var members : [UserModel]?
    var name : String?
    var topicCount : Int?
    var updatedAt : String?

    required init?(map: Map){}


    func mapping(map: Map)
    {
        topTopics <- map["TopTopics.data"]
        cover <- map["cover"]
        createdAt <- map["created_at"]
        id <- map["id"]
        introduce <- map["introduce"]
        isJoin <- map["isJoin"]
        memberCount <- map["member_count"]
        members <- map["members.data"]
        name <- map["name"]
        topicCount <- map["topic_count"]
        updatedAt <- map["updated_at"]
        
    }
}

class GCTopicModel : Mappable{
    
    var body : String?
    var commentCount : Int?
    var comments : [String]?
    var communityId : Int?
    var cover : String?
    var createdAt : String?
    var id : Int?
    var images : [String]?
    var isLike : Bool?
    var likeCount : Int?
    var title : String?
    var transferCount : Int?
    var updatedAt : String?
    var user : UserModel?
    var userId : Int?
    var videos : [AnyObject]?
    var viewCount : Int?
    ///为0代表没有关联商品
    var ornamentId : Int?
    var ornament: GCGoodsModel?
    
    required init?(map: Map){}

    func mapping(map: Map)
    {
        body <- map["body"]
        commentCount <- map["comment_count"]
        comments <- map["comments"]
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
        user <- map["user"]
        userId <- map["user_id"]
        videos <- map["videos"]
        viewCount <- map["view_count"]
        ornamentId <- map["ornament_id"]
        ornament <- map["ornament"]
    }
}

