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
            if attrText != "natural" {
                output[attrName] = attrText.textAlignmentString
            }
        } else if attrName == "lineBreakMode" {
            if attrText != "tailTruncation" {
                output[attrName] = attrText.lineBreakModeString
            }
        } else if attrName == "highlighted" {
            output[attrName] = attrText
        } else if attrName == "adjustsFontSizeToFit" {
            if attrText != "NO" {
                output["adjustsFontSizeToFitWidth"] = attrText
            }
        } else if attrName == "enabled" {
            output[attrName] = attrText
        } else if attrName == "numberOfLines" {
            output[attrName] = attrText
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
        
        if attrName == "opaque" {
            if attrText == "NO" {
                output.removeValue(forKey: attrName)
            }
        } else if attrName == "contentMode" {
            if attrText == "left" {
                output.removeValue(forKey: attrName)
            }
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
