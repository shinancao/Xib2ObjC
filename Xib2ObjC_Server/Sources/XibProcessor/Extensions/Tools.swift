//
//  Tools.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizingFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
