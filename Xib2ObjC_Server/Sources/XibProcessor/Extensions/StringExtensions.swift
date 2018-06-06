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

    func colorString() -> String {
        if hasPrefix("NSCustomColorSpace : NSColorSpaceModelRGB:") {
            //<string>NSCustomColorSpace : NSColorSpaceModelRGB: R:0.937 G:0.561 B:0.153 A:1</string>
            let start = self.index(after: "NSCustomColorSpace : NSColorSpaceModelRGB: ".endIndex)
            let end = self.endIndex
            let range = start ..< end
            let subString = self[range]
            let array = subString.components(separatedBy: " ")

            var color: [Float] = []
            array.forEach({ (string) in
                let scanner = Scanner(string: string)
                var val: Float = 0.0
                scanner.scanFloat(&val)
                color.append(val)
            })

            return String(format: "[UIColor colorWithRed:%1.3f green:%1.3f blue:%1.3f alpha:%1.3f]", color[0], color[1], color[2], color[3])

        } else {
            return self
        }
    }

    func quotedAsCodeString() -> String {
        return "\"\(self)\""
    }
    
    var contentModeString: String {
        return "UIViewContentMode" + self.capitalizingFirstLetter()
    }
    
    var alphaString: String {
        let double = Double(self)!
        return String(double.roundTo(places: 2))
    }

}


