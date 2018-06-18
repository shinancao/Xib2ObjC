//
//  UITextFieldProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation
import SWXMLHash

class UITextFieldProcessor: UIControlProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "text" {
            output[attrName] = attrText.quoteAsCodeString
        } else if attrName == "borderStyle" {
            output[attrName] = attrText.borderStyleString
        } else if attrName == "placeholder" {
            output[attrName] = attrText.quoteAsCodeString
        } else if attrName == "textAlignment" {
            output[attrName] = attrText.textAlignmentString
        } else if attrName == "clearsOnBeginEditing" {
            output[attrName] = attrText
        } else if attrName == "adjustsFontForContentSizeCategory" {
            output[attrName] = attrText
        } else if attrName == "adjustsFontSizeToFit" {
            output["adjustsFontSizeToFitWidth"] = attrText
        } else if attrName == "minimumFontSize" {
            output[attrName] = attrText
        } else if attrName == "background" {
            output[attrName] = "[UIImage imageNamed:\(attrText.quoteAsCodeString)]"
        } else if attrName == "disabledBackground" {
            output[attrName] = "[UIImage imageNamed:\(attrText.quoteAsCodeString)]"
        } else if attrName == "clearButtonMode" {
            output[attrName] = attrText.clearButtonModeString
        }
    }
    
    override func process(childElem: SWXMLHash.XMLElement) {
        let name = childElem.name
        if name == "color" {
            let attrName = childElem.attribute(by: "key")!.text
            output[attrName] = childElem.colorString
        } else if name == "fontDescription" {
            output["font"] = childElem.fontString
        } else if name == "textInputTraits" {
            if let attrText = childElem.attribute(by: "autocapitalizationType")?.text {
                output["autocapitalizationType"] = attrText.autocapitalizationTypeString
            }
            
            if let attrText = childElem.attribute(by: "autocorrectionType")?.text {
                output["autocorrectionType"] = attrText.autocorrectionTypeString
            }
            
            if let attrText = childElem.attribute(by: "spellCheckingType")?.text {
                output["spellCheckingType"] = attrText.spellCheckingTypeString
            }
            
            if let attrText = childElem.attribute(by: "keyboardType")?.text {
                output["keyboardType"] = attrText.keyboardTypeString
            }
            
            if let attrText = childElem.attribute(by: "keyboardAppearance")?.text {
                output["keyboardAppearance"] = attrText.keyboardAppearanceString
            }
            
            if let attrText = childElem.attribute(by: "returnKeyType")?.text {
                output["returnKeyType"] = attrText.returnKeyTypeString
            }
            
            if let attrText = childElem.attribute(by: "enablesReturnKeyAutomatically")?.text {
                output["enablesReturnKeyAutomatically"] = attrText
            }
            
            if let attrText = childElem.attribute(by: "secureTextEntry")?.text {
                output["secureTextEntry"] = attrText
            }
            
            if let attrText = childElem.attribute(by: "smartDashesType")?.text {
                output["smartDashesType"] = attrText.smartDashesTypeString
            }
            
            if let attrText = childElem.attribute(by: "smartInsertDeleteType")?.text {
                output["smartInsertDeleteType"] = attrText.smartInsertDeleteTypeString
            }
            
            if let attrText = childElem.attribute(by: "smartQuotesType")?.text {
                output["smartQuotesType"] = attrText.smartQuotesTypeString
            }
        } else {
            super.process(childElem: childElem)
        }
    }
}
