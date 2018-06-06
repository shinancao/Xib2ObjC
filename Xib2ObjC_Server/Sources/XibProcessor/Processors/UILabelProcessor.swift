//
//  UILabelProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation
import SWXMLHash

class UILabelProcessor: UIViewProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "text" {
            output[attrName] = attrText.quoteAsCodeString
        } else if attrName == "textAlignment" {
            output[attrName] = attrText.textAlignmentString
        } else if attrName == "lineBreakMode" {
            output[attrName] = attrText.lineBreakModeString
        } else if attrName == "highlighted" {
            output[attrName] = attrText
        } else if attrName == "adjustsFontSizeToFit" {
            output["adjustsFontSizeToFitWidth"] = attrText
        } else if attrName == "enabled" {
            output[attrName] = attrText
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
    }
    
    override func process(childElem: SWXMLHash.XMLElement) {
        let name = childElem.name
        
        if name == "fontDescription" {
            output["font"] = childElem.fontString
        } else if name == "size" {
            let attrName = childElem.attribute(by: "key")!.text
            output[attrName] = childElem.sizeString
        } else {
            super.process(childElem: childElem)
        }
        
        if output["highlightedColor"] != nil {
            output["highlightedTextColor"] = output["highlightedColor"]!
            output.removeValue(forKey: "highlightedColor")
        }
    }
}
