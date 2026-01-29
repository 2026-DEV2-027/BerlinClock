//
//  LampColor+UI.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

import SwiftUI

/// Helper extension to link to the right color asset.
extension LampColor {
    var color: Color {
        switch self {
        case .off:
            return Color("LampOff")
        case .yellow:
            return Color("LampYellow")
        case .red:
            return Color("LampRed")
        }
    }
}
