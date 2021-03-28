//
//  MainModel.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import Foundation
import ObjectMapper

struct MainModel: Mappable {
    
    /// 编号
    var id = 0
    
    /// 链接
    var link = ""
    
    /// 文本内容
    var content = ""
    
    /// 图片数组
    var imgUrls: [String] = []
    
    /// 内容类型
    var type = ContentType.text
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        link    <- map["link"]
        imgUrls <- map["imgUrls"]
        content <- map["content"]
        type    <- (map["type"], EnumTransform<ContentType>())
    }
}

enum ContentType: String {
    case img        = "img"
    case text       = "text"
    case textImg    = "text-img"
    case textLink   = "text-link"
}
