//
//  UserModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/29.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import ObjectMapper

class UserModel : Mappable{
    
    var avatar : String?
    var birthday : String?
    var boundPhone : Bool?
    var createdAt : String?
    var education : String?
    var email : String?
    var eth : String?
    var followerCount : Int?
    var followingCount : Int?
    var frozenEth : String?
    var id : Int?
    var name : String?
    var profession : String?
    var sex : String?
    var updatedAt : String?
    var neteasyAccid : String?//用户云信账号
    var neteasyToken : String?//用户云信token
    var isFollower : Bool? = false
    var meta : UserMetaModel?
    
    required init?(map: Map){}

    func mapping(map: Map)
    {
        avatar <- map["avatar"]
        birthday <- map["birthday"]
        boundPhone <- map["bound_phone"]
        createdAt <- map["created_at"]
        education <- map["education"]
        email <- map["email"]
        eth <- map["eth"]
        followerCount <- map["follower_count"]
        followingCount <- map["following_count"]
        frozenEth <- map["frozen_eth"]
        id <- map["id"]
        name <- map["name"]
        profession <- map["profession"]
        sex <- map["sex"]
        updatedAt <- map["updated_at"]
        neteasyAccid <- map["neteasy_accid"]
        neteasyToken <- map["neteasy_token"]
        isFollower <- map["is_follower"]
        meta <- map["meta"]
        
    }
    
}

class UserMetaModel : Mappable{
    
    var expiresIn : Int?
    
    var accessToken : String?//用户token
    var tokenType : String? //用户token_type

    required init?(map: Map){}

    func mapping(map: Map)
    {
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
        tokenType <- map["token_type"]
        
    }
}
