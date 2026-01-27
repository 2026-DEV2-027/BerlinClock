//
//  BerlinClockApp.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

import SwiftUI

@main
struct BerlinClockApp: App {
    var body: some Scene {
        WindowGroup {
            ClockView(
                viewModel:
                    ClockViewModel(
                        engine: ClockEngine(),
                        timeProvider: SystemTimeProvider(),
                        metronome: SystemMetronome(),
                        calendar: Calendar.current,
                        dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)
                    )
            )
        }
    }
}
