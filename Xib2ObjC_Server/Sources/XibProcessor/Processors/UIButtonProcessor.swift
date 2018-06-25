//
//  UIButtonProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation
import SWXMLHash

class UIButtonProcessor: UIControlProcessor {
    override func constructorString(indexer: XMLIndexer) -> String {
        return "[UIButton buttonWithType:\(indexer.element!.buttonTypeString)]"
    }
    
    override func process(attrName: String, attrText: String) {
        if attrName == "adjustsImageWhenHighlighted" {
            output[attrName] = attrText
        } else if attrName == "adjustsImageWhenDisabled" {
            output[attrName] = attrText
        } else if attrName == "lineBreakMode" {
            if attrText != "middleTruncation" {
                output["titleLabel.lineBreakMode"] = attrText.lineBreakModeString
            }
        } else if attrName == "reversesTitleShadowWhenHighlighted" {
            output[attrName] = attrText
        } else if attrName == "showsTouchWhenHighlighted" {
            output[attrName] = attrText
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
        
        if attrName == "opaque" {
            if attrText == "NO" {
                output.removeValue(forKey: attrName)
            }
        } else if attrName == "contentHorizontalAlignment" {
            if attrText == "center" {
                output.removeValue(forKey: attrName)
            }
        } else if attrName == "contentVerticalAlignment" {
            if attrName == "center" {
                output.removeValue(forKey: attrName)
            }
        }
    }
    
    override func process(childElem: SWXMLHash.XMLElement) {
        let name = childElem.name
        
        if name == "fontDescription" {
            output["titleLabel.font"] = childElem.fontString
        } else if name == "size" {
            let attrName = childElem.attribute(by: "key")!.text
            if attrName == "titleShadowOffset" {
                output["titleLabel.shadowOffset"] = childElem.sizeString
            }
        } else if name == "state" {
            let state = childElem.attribute(by: "key")!.text
            if let title = childElem.attribute(by: "title")?.text {
                output["__method__\(state)Title"] = "setTitle:\(title.quoteAsCodeString) forState:\(state.buttonStateString)"
            }
            
            if let image = childElem.attribute(by: "image")?.text {
                output["__method__\(state)Image"] = "setImage:[UIImage imageNamed:\(image.quoteAsCodeString)] forState:\(state.buttonStateString)"
            }
            
            childElem.children.forEach({ (xmlContent) in
                if let e = xmlContent as? SWXMLHash.XMLElement {
                    if e.name == "color" {
                        let attrName = e.attribute(by: "key")!.text
                        if attrName == "titleColor" {
                            output["__method__\(state)TitleColor"] = "setTitleColor:\(e.colorString) forState:\(state.buttonStateString)"
                        }
                    }
                }
            })
        } else {
            super.process(childElem: childElem)
        }
    }
}
