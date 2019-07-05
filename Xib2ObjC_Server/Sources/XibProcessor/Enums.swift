//
//  Enums.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/7/8.
//

import Foundation

public enum Xib2ObjCError: Error {
    case createOutputDirFailed(String)
    case xibFileNotExist(String)
    case unknownXibObject(String)
    case parseXibToXmlFailed(String)
    case notSupportSafeArea(String)
}
