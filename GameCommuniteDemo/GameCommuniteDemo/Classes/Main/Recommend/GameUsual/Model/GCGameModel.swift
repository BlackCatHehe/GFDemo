//
//  GCGameModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/6.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation
import ObjectMapper


class GCGameModel : Mappable{

    var characteristics : [GCGameTagModel]?
    var cover : String?
    var createdAt : String?
    var currentOnlineCount : Int?
    var descriptionField : String?
    var englishName : String?
    var id : Int?
    var labels : [GCGameTagModel]?
    var logo : String?
    var name : String?
    var score : Int?
    var updatedAt : String?
    var yesterdayPeakOnlineCount : Int?
    var images : [GCGameImg]?
    
    required init?(map: Map){}

    func mapping(map: Map)
    {
        characteristics <- map["characteristics.data"]
        cover <- map["cover"]
        createdAt <- map["created_at"]
        currentOnlineCount <- map["current_online_count"]
        descriptionField <- map["description"]
        englishName <- map["english_name"]
        id <- map["id"]
        labels <- map["labels.data"]
        logo <- map["logo"]
        name <- map["name"]
        score <- map["score"]
        updatedAt <- map["updated_at"]
        yesterdayPeakOnlineCount <- map["yesterday_peak_online_count"]
        images <- map["images.data"]
        
    }
}

class GCGameImg : Mappable{

    var createdAt : String?
    var id : Int?
    var image : String?
    var largeImage : String?
    var updatedAt : String?
    var url : String?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        id <- map["id"]
        image <- map["image"]
        largeImage <- map["large_image"]
        updatedAt <- map["updated_at"]
        url <- map["url"]
        
    }
}

class GCGameTagModel : Mappable{
    
    var createdAt : String?
    var descriptionField : String?
    var id : Int?
    var name : String?
    var updatedAt : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        id <- map["id"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        
    }
}
