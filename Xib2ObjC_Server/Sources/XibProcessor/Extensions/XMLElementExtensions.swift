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
        let RGBA = allAttributes.filter{key, _ in ["red", "green", "blue", "alpha"].contains(key)}.map { (_, value) -> [String: String] in
            let text = value.text
            if text.count > 5 {
                let endIndex = text.index(text.startIndex, offsetBy: 5)
                return [value.name: String(text[text.startIndex..<endIndex])]
            } else {
                return [value.name: text]
            }
            }.reduce([String: String]()) { (dict1, dict2) -> [String: String] in
                var dict = dict1
                dict2.forEach{(k,v) in dict[k] = v }
                return dict
            }

        return "[UIColor colorWithRed:\(RGBA["red"]!) green:\(RGBA["green"]!) blue:\(RGBA["blue"]!) alpha:\(RGBA["alpha"]!)]"
        
        
    }
    
    var rectString: String {
        let rect = allAttributes.filter{key, _ in ["x", "y", "width", "height"].contains(key)}.map{_, value in value.text}
        
        return "CGRectMake(\(rect[0]), \(rect[1]), \(rect[2]), \(rect[3]))"
    }
    
    var classNameString: String {
        return "UI"+name.capitalized
    }

    var idString: String {
        return attribute(by: "id")!.text.replacingOccurrences(of: "-", with: "").lowercased()
    }
}
