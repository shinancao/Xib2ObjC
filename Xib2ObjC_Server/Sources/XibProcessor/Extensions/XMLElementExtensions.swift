//
//  XMLElementExtensions.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/4.
//

import Foundation
import SWXMLHash

extension SWXMLHash.XMLElement {
    var colorString: String {
        let RGBA = allAttributes.filter{key, _ in ["red", "green", "blue", "alpha"].contains(key)}.map { (_, value) -> String in
            let text = value.text
            if text.count > 5 {
                let endIndex = text.index(text.startIndex, offsetBy: 5)
                return String(text[text.startIndex..<endIndex])
            } else {
                return text
            }
        }
        
        return "[UIColor colorWithRed:\(RGBA[0]) green:\(RGBA[1]) blue:\(RGBA[2]) alpha:\(RGBA[3])]"
    }
    
    var rectString: String {
        let rect = allAttributes.filter{key, _ in ["x", "y", "width", "height"].contains(key)}.map{_, value in value.text}
        
        return "CGRectMake(\(rect[0]), \(rect[1]), \(rect[2]), \(rect[3]))"
    }
    
    var classNameString: String {
        return "UI"+name.capitalized
    }

}
