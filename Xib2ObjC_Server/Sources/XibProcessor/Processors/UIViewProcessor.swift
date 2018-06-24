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
        return "[[\(indexer.element!.classNameString) alloc] initWithFrame:\(rectElem.rectString)]"
    }
    
    override func process(attrName: String, attrText: String) {
        var object: String?
        var attrName = attrName
        if attrName == "contentMode" {
            if attrText != "scaleToFill" {
                object = attrText.contentModeString
            }
        } else if attrName == "translatesAutoresizingMaskIntoConstraints" {
            if attrText != "NO" {
                object = attrText
            }
        } else if attrName == "hidden" {
            object = attrText
        } else if attrName == "opaque" {
            object = attrText
        } else if attrName == "clipsSubviews" {
            object = attrText
            attrName = "clipsToBounds"
        } else if attrName == "userInteractionEnabled" {
            if attrText != "NO" {
                object = attrText
            }
        } else if attrName == "tag" {
            object = attrText
        } else if attrName == "multipleTouchEnabled" {
            object = attrText
        } else if attrName == "clearsContextBeforeDrawing" {
            object = attrText
        } else if attrName == "alpha" {
            object = attrText.alphaString
        } else if attrName == "autoresizesSubviews" {
            object = attrText
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
        } else if attrName == "autoresizingMask" {
            //暂时不考虑该属性
        }
        
        if let obj = object {
            output[attrName] = obj
        }
    }
}
