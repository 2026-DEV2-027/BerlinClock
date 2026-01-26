//
//  ClockEngine.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

/// A struct that computes each lamp color of a Berlin Clock.
struct ClockEngine {
    
    /// Computes the color of the seconds lamp. The lamp is lit in red when the seconds are even and off when the seconds are odd.
    ///
    /// - Parameter seconds: The seconds part of the time.
    /// - Returns: The lamp color.
    func computeSecondsLamp(seconds: Int) -> LampColor {
        return .off
    }
}
