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
    /// - Parameter seconds: The second part of the time.
    /// - Returns: The lamp color.
    func computeSecondsLamp(for second: Int) -> LampColor {
        return second.isMultiple(of: 2) ? .red : .off
    }

    /// Computes the row of colors of the 5-hour lamps. Each lit lamp represents 5 hours.
    ///
    /// - Parameter hour: The hour part of the time.
    /// - Returns: The lamp colors.
    func computeFiveHourRow(for hour: Int) -> [LampColor] {
        let activeLamps = hour / 5
        return createRow(totalLamps: 4, activeLamps: activeLamps, color: .red)
    }

    /// Computes the row of colors of the 1-hour lamps. Those lamps represents the remaining hours after the 5-hour lamps.
    ///
    /// - Parameter hour: The hour part of the time.
    /// - Returns: The lamp colors.
    func computeOneHourRow(for hour: Int) -> [LampColor] {
        let activeLamps = hour % 5
        return createRow(totalLamps: 4, activeLamps: activeLamps, color: .red)
    }

    /// Computes the row of colors of the 5-minute lamps. Each lit lamp represents 5 minutes and is yellow, and every three lamp is in red instead of yellow.
    ///
    /// - Parameter minute: The minute part of the time.
    /// - Returns: The lamp colors.
    func computeFiveMinuteRow(for minute: Int) -> [LampColor] {
        let activeLamps = minute / 5
        var row: [LampColor] = []

        for index in 1...11 {
            if index <= activeLamps {
                if index.isMultiple(of: 3) {
                    row.append(.red)
                } else {
                    row.append(.yellow)
                }
            } else {
                row.append(.off)
            }
        }
        return row
    }

    /// Computes the row of colors of the 1-minute lamps. Those lamps the last 4 minutes of the hour.
    ///
    /// - Parameter minute: The minute part of the time.
    /// - Returns: The lamp colors.
    func computeOneMinuteRow(for minute: Int) -> [LampColor] {
        let activeLamps = minute % 5
        return createRow(totalLamps: 4, activeLamps: activeLamps, color: .yellow)
    }
}

private extension ClockEngine {
    
    /// Helper function to create a row of lamp colors with size, amount of lit lamps, and color
    ///
    /// - Parameters:
    ///   - totalLamps: Number of possible lamps in the row.
    ///   - activeLamps: Number of lit lamps.
    ///   - color: Color of lit lamps.
    /// - Returns: The lamp colors.
    func createRow(totalLamps: Int, activeLamps: Int, color: LampColor) -> [LampColor] {
        return (0 ..< totalLamps).map { index in
            if index < activeLamps {
                return color
            } else {
                return .off
            }
        }
    }
}
