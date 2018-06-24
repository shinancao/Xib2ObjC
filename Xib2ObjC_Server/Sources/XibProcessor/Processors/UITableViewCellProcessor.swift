//
//  UITableViewCellProcessor.swift
//  XibProcessor
//
//  Created by Shinancao on 2018/6/24.
//

import Foundation

class UITableViewCellProcessor: UIViewProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "selectionStyle" {
            output[attrName] = attrText.tableViewCellSelectionStyleString
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
    }
}
