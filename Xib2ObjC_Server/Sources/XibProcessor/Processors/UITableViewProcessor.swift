//
//  UITableViewProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation
import SWXMLHash

class UITableViewProcessor: UIScrollViewProcessor {
    override func constructorString(indexer: XMLIndexer) -> String {
        let rectElem = indexer["rect"].element!
        return "[[UITableView alloc] initWithFrame:\(rectElem.rectString) style:\(indexer.element!.tableViewStyleString)]"
    }
    
    override func process(attrName: String, attrText: String) {
        if attrName == "sectionIndexMinimumDisplayRowCount" {
            output[attrName] = attrText
        } else if attrName == "allowsSelectionDuringEditing" {
            output[attrName] = attrText
        } else if attrName == "allowsMultipleSelection" {
            output[attrName] = attrText
        } else if attrName == "springLoaded" {
            output[attrName] = attrText
        } else if attrName == "rowHeight" {
            if attrText == "-1" {
                output[attrName] = "UITableViewAutomaticDimension"
            } else {
                output[attrName] = attrText
            }
        } else if attrName == "estimatedRowHeight" {
            if attrText == "-1" {
                output[attrName] = "UITableViewAutomaticDimension"
            } else {
                output[attrName] = attrText
            }
        } else if attrName == "sectionHeaderHeight" {
            if attrText == "-1" {
                output[attrName] = "UITableViewAutomaticDimension"
            } else {
                output[attrName] = attrText
            }
        } else if attrName == "estimatedSectionHeaderHeight" {
            if attrText == "-1" {
                output[attrName] = "UITableViewAutomaticDimension"
            } else {
                output[attrName] = attrText
            }
        } else if attrName == "sectionFooterHeight" {
            if attrText == "-1" {
                output[attrName] = "UITableViewAutomaticDimension"
            } else {
                output[attrName] = attrText
            }
        } else if attrName == "estimatedSectionFooterHeight" {
            if attrText == "-1" {
                output[attrName] = "UITableViewAutomaticDimension"
            } else {
                output[attrName] = attrText
            }
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
