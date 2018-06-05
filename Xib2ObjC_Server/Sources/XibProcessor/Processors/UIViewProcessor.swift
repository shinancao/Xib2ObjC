//
//  UIViewProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation
import SWXMLHash

class UIViewProcessor: Processor {
    override func constructorString(indexer: XMLIndexer) -> String {
        let rectElem = indexer["rect"].element!
        return "[[\(indexer.element!.classNameString) alloc] initWithRect:\(rectElem.rectString)]"
    }
    
    override func process(attrName: String, attrText: String) {
        var object: String?
        if attrName == "contentMode" {
            object = attrText.contentModeString
        }
        
        if let obj = object {
            output[attrName] = obj
        }
    }
    
    override func process(childElem: SWXMLHash.XMLElement) {
        let name = childElem.name
        let attrName = childElem.attribute(by: "key")?.text ?? "unknowAttr"
        var object: String?
        
        if name == "color" {
            object = childElem.colorString
        }
        
        if let obj = object {
            output[attrName] = obj
        }
    }
}
