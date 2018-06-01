//
//  NumberExtensions.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/1.
//

import Foundation

extension Int {
    func booleanString() -> String {
        return (self == 1) ? "YES":"NO"
    }
    
    func intString() -> String {
        return String(format: "%d", self)
    }
    
    func floatString() -> String {
        return String(format: "%1.3f", self)
    }
    
    func contentModedString() -> String {
        let values = ["UIViewContentModeScaleToFill",
                      "UIViewContentModeScaleAspectFit",
                      "UIViewContentModeScaleAspectFill",
                      "UIViewContentModeRedraw",
                      "UIViewContentModeCenter",
                      "UIViewContentModeTop",
                      "UIViewContentModeBottom",
                      "UIViewContentModeLeft",
                      "UIViewContentModeRight",
                      "UIViewContentModeTopLeft",
                      "UIViewContentModeTopRight",
                      "UIViewContentModeBottomLeft",
                      "UIViewContentModeBottomRight"]
        return values[self]
    }
    
    func textAlignmentString() -> String {
        let values = ["UITextAlignmentLeft",
                      "UITextAlignmentCenter",
                      "UITextAlignmentRight"]
        return values[self]
    }
    
    func borderStyleString() -> String {
        let values = ["UITextBorderStyleNone",
                      "UITextBorderStyleLine",
                      "UITextBorderStyleBezel",
                      "UITextBorderStyleRoundedRect"]
        return values[self]
    }
    
    func contentHorizontalAlignmentString() -> String {
        let values = ["UIControlContentHorizontalAlignmentCenter",
                      "UIControlContentHorizontalAlignmentLeft",
                      "UIControlContentHorizontalAlignmentRight",
                      "UIControlContentHorizontalAlignmentFill"]
        return values[self]
    }
    
    func contentVerticalAlignmentString() -> String {
        let values = ["UIControlContentVerticalAlignmentCenter",
                      "UIControlContentVerticalAlignmentTop",
                      "UIControlContentVerticalAlignmentBottom",
                      "UIControlContentVerticalAlignmentFill"]
        return values[self]
    }
    
    func lineBreakModeString() -> String {
        let values = ["UILineBreakModeWordWrap",
                      "UILineBreakModeCharacterWrap",
                      "UILineBreakModeClip",
                      "UILineBreakModeHeadTruncation",
                      "UILineBreakModeTailTruncation",
                      "UILineBreakModeMiddleTruncation"]
        return values[self]
    }
    
    func buttonTypeString() -> String {
        let values = ["UIButtonTypeCustom",
                      "UIButtonTypeRoundedRect",
                      "UIButtonTypeDetailDisclosure",
                      "UIButtonTypeInfoLight",
                      "UIButtonTypeInfoDark",
                      "UIButtonTypeContactAdd"]
        return values[self]
    }
    
    func tableViewStyleString() -> String {
        let values = ["UITableViewStylePlain",
                      "UITableViewStyleGrouped"]
        return values[self]
    }
    
    func tableViewCellSeparatorStyleString() -> String {
        let values = ["UITableViewCellSeparatorStyleNone",
                      "UITableViewCellSeparatorStyleSingleLine",
                      "UITableViewCellSeparatorStyleSingleLineEtched"]
        return values[self]
    }
    
    func tableViewCellAccessoryString() -> String {
        let values = ["UITableViewCellAccessoryNone",
                      "UITableViewCellAccessoryDisclosureIndicator",
                      "UITableViewCellAccessoryDetailDisclosureButton",
                      "UITableViewCellAccessoryCheckmark"]
        return values[self]
    }
    
    func tableViewCellEditingStyleString() -> String {
        let values = ["UITableViewCellEditingStyleNone",
                      "UITableViewCellEditingStyleDelete",
                      "UITableViewCellEditingStyleInsert"]
        return values[self]
    }
    
    func tableViewCellSelectionStyleString() -> String {
        let values = ["UITableViewCellSelectionStyleNone",
                      "UITableViewCellSelectionStyleBlue",
                      "UITableViewCellSelectionStyleGray"]
        return values[self]
    }
}
