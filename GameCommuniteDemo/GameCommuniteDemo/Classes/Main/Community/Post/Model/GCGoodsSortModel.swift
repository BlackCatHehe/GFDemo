//
//  GCGoodsSortModel.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/12/5.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import ObjectMapper

class GCGoodsSortModel : Mappable{
    
    var categories : [GCSortPrama]?
    var hotWords : [GCHotWord]?
    var qualities : [GCSortPrama]?
    var rarities : [GCSortPrama]?

    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        categories <- map["categories"]
        hotWords <- map["hot_words"]
        qualities <- map["qualities"]
        rarities <- map["rarities"]
        
    }
}

class GCSortPrama : Mappable{
    
    var id : Int?
    var name : String?
    var isSel : Bool = false

    required init?(map: Map){}

    func mapping(map: Map)
    {
        id <- map["id"]
        name <- map["name"]
        
    }
}


class GCHotWord : Mappable{
    
    var times : Int?
    var word : String?
    
    required init?(map: Map){}

    func mapping(map: Map)
    {
        times <- map["times"]
        word <- map["word"]
        
    }
}
