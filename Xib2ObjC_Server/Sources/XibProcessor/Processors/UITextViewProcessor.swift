//
//  UITextViewProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation
import SWXMLHash

class UITextViewProcessor: UIScrollViewProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "editable" {
            output[attrName] = attrText
        } else if attrName == "adjustsFontForContentSizeCategory" {
            output[attrName] = attrText
        } else if attrName == "selectable" {
            output[attrName] = attrText
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
    }
    
    override func process(childElem: SWXMLHash.XMLElement) {
        let name = childElem.name
        if name == "color" {
            let attrName = childElem.attribute(by: "key")!.text
            output[attrName] = childElem.colorString
        } else if name == "fontDescription" {
            output["font"] = childElem.fontString
        } else if name == "string" {
            output["text"] = childElem.text.quoteAsCodeString
        } else {
            super.process(childElem: childElem)
        }
    }
}
