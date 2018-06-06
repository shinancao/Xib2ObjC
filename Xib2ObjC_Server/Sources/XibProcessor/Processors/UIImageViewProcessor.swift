//
//  UIImageViewProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation

class UIImageViewProcessor: UIViewProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "image" {
            output[attrName] = attrText.imageString
        } else if attrName == "highlightedImage" {
            output[attrName] = attrText.imageString
        } else if attrName == "highlighted" {
            output[attrName] = attrText
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
    }
}
