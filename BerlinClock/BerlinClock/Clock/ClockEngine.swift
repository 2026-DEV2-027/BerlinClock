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
        return seconds.isMultiple(of: 2) ? .red : .off
    }

    /// Computes the row of colors of the 5-hour lamps. Each lit lamp represents 5 hours.
    ///
    /// - Parameter seconds: The hour part of the time.
    /// - Returns: The lamp colors.
    func computeFiveHourRow(hours: Int) -> [LampColor] {
        var row: [LampColor] = []
        let activeLamps = hours / 5
        for index in 0 ..< 4 {
            if index < activeLamps {
                row.append(.red)
            } else {
                row.append(.off)
            }
        }
        return row
    }

    /// Computes the row of colors of the 1-hour lamps. Those lamps represents the last 4 hours of the day.
    ///
    /// - Parameter minutes: The hour part of the time.
    /// - Returns: The lamp colors.
    func computeOneHourRow(hours: Int) -> [LampColor] {
        var row: [LampColor] = []
        let activeLamps = hours % 5
        for index in 0 ..< 4 {
            if index < activeLamps {
                row.append(.red)
            } else {
                row.append(.off)
            }
        }
        return row
    }
}
