//
//  StringExtensions.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/5/31.
//

import Foundation

extension String {
    func sizeString() -> String {
        let size = NSSizeFromString(self)
        return String(format: "CGSizeMake(%1.1f, %1.1f)", size.width, size.height)
    }
    
    var contentModeString: String {
        return "UIViewContentMode" + self.capitalizingFirstLetter()
    }
    
    var alphaString: String {
        let double = Double(self)!
        return String(double.roundTo(places: 2))
    }
    
    var quoteAsCodeString: String {
        return "@\"\(self)\""
    }
    
    var textAlignmentString: String {
        return "NSTextAlignment" + capitalized
    }
    
    var lineBreakModeString: String {
        if range(of: "Truncation") != nil {
            let mode = prefix(self.count - "Truncation".count)
            return "NSLineBreakBy" + "Truncating" + mode.capitalized
        } else {
            return "NSLineBreakBy" + self.capitalizingFirstLetter() + "ing"
        }
    }

    var imageString: String {
        return "[UIImage imageNamed:@\"\(self)\"]"
    }
    
    var contentVerticalAlignmentString: String {
        return "UIControlContentVerticalAlignment" + capitalized
    }
    
    var contentHorizontalAlignmentString: String {
        return "UIControlContentHorizontalAlignment" + capitalized
    }
    
    var buttonStateString: String {
        return "UIControlState" + capitalized
    }
    
    var indicatorStyleString: String {
        return "UIScrollViewIndicatorStyle" + capitalized
    }
    
    var keyboardDismissModeString: String {
        return "UIScrollViewKeyboardDismissMode" + self.capitalizingFirstLetter()
    }
    
    var borderStyleString: String {
        return "UITextBorderStyle" + self.capitalizingFirstLetter()
    }
    
    var clearButtonModeString: String {
        return "UITextFieldViewMode" + self.capitalizingFirstLetter()
    }
    
    var autocapitalizationTypeString:String {
        return "UITextAutocapitalizationType" + self.capitalizingFirstLetter()
    }
    
    var autocorrectionTypeString: String {
        return "UITextAutocorrectionType" + capitalized
    }
    
    var spellCheckingTypeString: String {
        return "UITextSpellCheckingType" + capitalized
    }
    
    var keyboardTypeString: String {
        return "UIKeyboardType" + self.capitalizingFirstLetter()
    }
    
    var keyboardAppearanceString: String {
        return "UIKeyboardAppearance" + capitalized
    }
    
    var returnKeyTypeString: String {
        return "UIReturnKey" + self.capitalizingFirstLetter()
    }
    
    var smartDashesTypeString: String {
        return "UITextSmartDashesType" + capitalized
    }
    
    var smartInsertDeleteTypeString: String {
        return "UITextSmartInsertDeleteType" + capitalized
    }
    
    var smartQuotesTypeString: String {
        return "UITextSmartQuotesType" + capitalized
    }
    
    var tableViewCellSelectionStyleString: String {
        return "UITableViewCellSelectionStyle" + capitalized
    }
}


