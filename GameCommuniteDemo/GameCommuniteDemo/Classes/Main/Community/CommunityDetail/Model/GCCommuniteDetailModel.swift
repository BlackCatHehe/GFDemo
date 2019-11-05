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
    
    var cover : String?
    var createdAt : String?
    var id : Int?
    var introduce : String?
    var isJoin : Bool?
    var memberCount : Int?
    var members : [UserModel]?
    var name : String?
    var topicCount : Int?
    var topics : [GCTopicModel]?
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
        members <- map["members.data"]
        name <- map["name"]
        topicCount <- map["topic_count"]
        topics <- map["topics.data"]
        updatedAt <- map["updated_at"]
    }
}

class GCTopicModel : Mappable{
    
    var body : String?
    var commentCount : Int?
    var communityId : Int?
    var cover : String?
    var createdAt : String?
    var id : Int?
    var images : [String]?
    var likeCount : Int?
    var title : String?
    var transferCount : Int?
    var updatedAt : String?
    var user : UserModel?
    var userId : Int?
    var videos : [String]?
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
        likeCount <- map["like_count"]
        title <- map["title"]
        transferCount <- map["transfer_count"]
        updatedAt <- map["updated_at"]
        user <- map["user"]
        userId <- map["user_id"]
        videos <- map["videos"]
        viewCount <- map["view_count"]
        
    }
}


class UserModel : Mappable{
    
    var avatar : String?
    var boundPhone : Bool?
    var createdAt : String?
    var email : String?
    var eth : String?
    var followerCount : Int?
    var followingCount : Int?
    var frozenEth : String?
    var id : Int?
    var name : String?
    var updatedAt : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        avatar <- map["avatar"]
        boundPhone <- map["bound_phone"]
        createdAt <- map["created_at"]
        email <- map["email"]
        eth <- map["eth"]
        followerCount <- map["follower_count"]
        followingCount <- map["following_count"]
        frozenEth <- map["frozen_eth"]
        id <- map["id"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        
    }
    
}
