//
//  Lable.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/28.
//

import UIKit
import Foundation

extension String {
    
    // 行高 AttributedString
    var attributed: NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 24
        return NSAttributedString(string: self, attributes: [.paragraphStyle: style])
    }
    
    /// 是否是网址
    var isUrlFormat: Bool {
        let pattern = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regextestmobile.evaluate(with: self)
    }
}
