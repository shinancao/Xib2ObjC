//
//  UISwitchProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation
import SWXMLHash

class UISwitchProcessor: UIViewProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "on" {
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
        } else {
            super.process(childElem: childElem)
        }
    }
}
