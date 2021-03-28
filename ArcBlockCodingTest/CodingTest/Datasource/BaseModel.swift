//
//  BaseModel.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import Foundation
import ObjectMapper

/// 基础模型
struct BaseModel: Mappable {
    
    var msg = ""
    var code = 0
    var data: [Any] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        msg     <- map["msg"]
        code    <- map["code"]
        data    <- map["data"]
    }
}
