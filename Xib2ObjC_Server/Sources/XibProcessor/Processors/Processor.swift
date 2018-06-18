//
//  Processor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation
import SWXMLHash

class Processor: NSObject {
    var output = [String: String]() 
    
    func process(attrName: String, attrText: String) {}
    
    func process(childElem: SWXMLHash.XMLElement) {}
    
    func constructorString(indexer: XMLIndexer) -> String {
        return "[[\(indexer.element!.classNameString) alloc] init]"
    }
}

extension Processor {
    final class func processor(elementName: String) -> Processor? {
        switch elementName {
        case "view":
            return UIViewProcessor()
        case "label":
            return UILabelProcessor()
        case "imageView":
            return UIImageViewProcessor()
        case "button":
            return UIButtonProcessor()
        case "pageControl":
            return UIPageControlProcessor()
        case "scrollView":
            return UIScrollViewProcessor()
        case "switch":
            return UISwitchProcessor()
        case "tableView":
            return UITableViewProcessor()
        default:
            return nil
        }
    }
    
    final func process(indexer: XMLIndexer) -> [String: String] {
        output.removeAll()
        
        output["class"] = indexer.element!.classNameString
        
        output["constructor"] = constructorString(indexer: indexer)
        
        if let userLbl = indexer.element!.attribute(by: "userLabel")?.text {
            output["instanceName"] = userLbl
        } else {
            output["instanceName"] = indexer.element!.name + indexer.element!.idString
        }
        
        indexer.element!.allAttributes.forEach { (_, value) in
            process(attrName: value.name, attrText: value.text)
        }
        
        indexer.children.forEach { (child) in
            process(childElem: child.element!)
        }
        
        return output
    }
}


