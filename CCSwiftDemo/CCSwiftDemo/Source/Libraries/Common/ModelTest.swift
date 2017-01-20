//
//  ModelTest.swift
//  BaseProjectSwift
//
//  Created by DatDV on 1/10/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation
import ObjectMapper

struct Account: Mappable {
    var id:         String?
    var username:   String?
    var password:   String?
    var avatar:     String?
    var name:       String?
    var phone:      String?
    var email:      String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        username    <- map["username"]
        password    <- map["password"]
        avatar      <- map["avatar"]
        name        <- map["name"]
        phone       <- map["phone"]
        email       <- map["email"]
    }
}
