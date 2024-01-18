//
//  Wxtensions.swift
//  AsystentPPK
//
//  Created by Bartlomiej Predki on 04/12/2023.
//

import Foundation

extension Double {
    func format(decimalPlaces: Int) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = decimalPlaces
        return formatter.string(from: self as NSNumber)!
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
