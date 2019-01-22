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
        let spaceValue = { (space:[String]) -> [String: String] in
            return self.allAttributes.filter{key, _ in space.contains(key)}.map{ (_, value) -> [String: String] in
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
        }
        
        let customColorSpace = attribute(by: "customColorSpace")?.text
        if let customColorSpace = customColorSpace {
            if customColorSpace == "genericGamma22GrayColorSpace" {
                let WA = spaceValue(["white", "alpha"])
                return "[UIColor colorWithWhite:\(WA["white"]!) alpha:\(WA["alpha"]!)]"
            } else if customColorSpace == "sRGB" {
                let RGBA = spaceValue(["red", "green", "blue", "alpha"])
                return "[UIColor colorWithRed:\(RGBA["red"]!) green:\(RGBA["green"]!) blue:\(RGBA["blue"]!) alpha:\(RGBA["alpha"]!)]"
            }
        } else {
            let colorSpace = attribute(by: "colorSpace")?.text
            if let colorSpace = colorSpace {
                if colorSpace == "calibratedRGB" {
                    let RGBA = spaceValue(["red", "green", "blue", "alpha"])
                    return "[UIColor colorWithRed:\(RGBA["red"]!) green:\(RGBA["green"]!) blue:\(RGBA["blue"]!) alpha:\(RGBA["alpha"]!)]"
                } else if colorSpace == "calibratedWhite" {
                    let WA = spaceValue(["white", "alpha"])
                    return "[UIColor colorWithWhite:\(WA["white"]!) alpha:\(WA["alpha"]!)]"
                }
            }
        }
        return "unknow colorSpace"
    }
    
    var rectString: String {
        let rect = allAttributes.filter{key, _ in ["x", "y", "width", "height"].contains(key)}.map{_, value in [value.name: value.text]}.reduce([String: String]()) { (dict1, dict2) -> [String: String] in
            var dict = dict1
            dict2.forEach{(k,v) in dict[k] = v }
            return dict
        }
        
        return "CGRectMake(\(rect["x"]!), \(rect["y"]!), \(rect["width"]!), \(rect["height"]!))"
    }
    
    var classNameString: String {
        return "UI"+name.capitalizingFirstLetter()
    }

    var idString: String {
        return attribute(by: "id")!.text.replacingOccurrences(of: "-", with: "").lowercased()
    }
    
    var fontString: String {
        let pointSize = attribute(by: "pointSize")!.text
        if attribute(by: "type")?.text == "system" {
            return "[UIFont systemFontOfSize:\(pointSize)]"
        } else {
            let name = attribute(by: "name")?.text
            let family = attribute(by: "family")?.text
            if name != nil && family != nil {
                return "[UIFont fontWithName:@\"\(name!)\" size:\(pointSize)]"
            } else {
                return "unknow font"
            }
        }
    }
    
    var sizeString: String {
        let width = attribute(by: "width")!.text
        let height = attribute(by: "height")!.text
        return "CGSizeMake(\(width), \(height))"
    }
    
    var buttonTypeString: String {
        let buttonType = attribute(by: "buttonType")?.text
        if let buttonType = buttonType {
            if buttonType == "roundedRect" {
                return "UIButtonTypeSystem"
            } else {
                return "UIButtonType" + buttonType.capitalizingFirstLetter()
            }
        } else {
            return "UIButtonTypeCustom"
        }
    }
    
    var tableViewStyleString: String {
        let style = attribute(by: "style")!.text
        return "UITableViewStyle" + style.capitalized
    }
    
    //约束相关
    var firstItemIdString: String {
        if let firstItem = attribute(by: "firstItem") {
            return firstItem.text.replacingOccurrences(of: "-", with: "").lowercased()
        } else {
            return ""
        }
    }
    
    var firstAttributeString: String {
        return attribute(by: "firstAttribute")!.text
    }
    
    var secondItemIdString: String {
        if let firstItem = attribute(by: "secondItem") {
            return firstItem.text.replacingOccurrences(of: "-", with: "").lowercased()
        } else {
            return ""
        }
    }
    
    var secondAttributeString: String {
        return attribute(by: "secondAttribute")!.text
    }
    
    var constantString: String {
        if let constant = attribute(by: "constant") {
            return constant.text
        } else {
            return ""
        }
    }
    
    var relationString: String {
        if let relation = attribute(by: "relation") {
            return relation.text + "To"
        } else {
            return "equalTo"
        }
    }
}
