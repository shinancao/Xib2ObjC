//
//  UIControlProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation

class UIControlProcessor: UIViewProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "contentHorizontalAlignment" {
            output[attrName] = attrText.contentHorizontalAlignmentString
        } else if attrName == "contentVerticalAlignment" {
            output[attrName] = attrText.contentVerticalAlignmentString
        } else if attrName == "enabled" {
            output[attrName] = attrText
        } else if attrName == "highlighted" {
            output[attrName] = attrText
        } else if attrName == "selected" {
            output[attrName] = attrText
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
    }
}
