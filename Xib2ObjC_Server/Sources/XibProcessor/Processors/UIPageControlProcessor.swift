//
//  UIPageControlProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation
import SWXMLHash

class UIPageControlProcessor: UIControlProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "hidesForSinglePage" {
            output[attrName] = attrText
        } else if attrName == "defersCurrentPageDisplay" {
            output[attrName] = attrText
        } else if attrName == "numberOfPages" {
            output[attrName] = attrText
        } else if attrName == "currentPage" {
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
