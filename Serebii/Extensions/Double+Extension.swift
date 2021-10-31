//
//  Double+Extension.swift
//  Serebii
//
//  Created by Patrick Solis on 10/30/21.
//

import Foundation

extension Double {
    
    func dmToFeetAndInches() -> String {
        let conversion = (self/10.0) * 3.28084
        let feet = String(Int(conversion.rounded(.down)))
        let conversionInches = conversion.truncatingRemainder(dividingBy: 1)
        let inches = String(Int((12 * conversionInches).rounded(.up)))
        return "\(feet)\' \(inches)\""
    }

    func hgToLbs() -> String {
        let conversion = (self / 10 / 6.35 * 14)
        return String(format: "%.1f lbs", conversion)
    }
}
