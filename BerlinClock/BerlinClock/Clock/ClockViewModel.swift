//
//  ClockViewModel.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

import Combine
import Foundation

class ClockViewModel: ObservableObject {
    @Published var secondsLamp: LampColor = .off
    @Published var fiveHourRow: [LampColor] = Array(repeating: .off, count: 4)
    @Published var oneHourRow: [LampColor] = Array(repeating: .off, count: 4)
    @Published var fiveMinuteRow: [LampColor] = Array(repeating: .off, count: 11)
    @Published var oneMinuteRow: [LampColor] = Array(repeating: .off, count: 4)

    private let timeProvider: TimeProviderProtocol
    private let calendar: Calendar
    private let engine = ClockEngine()

    init(timeProvider: TimeProviderProtocol = SystemTimeProvider(), calendar: Calendar = Calendar.current) {
        self.timeProvider = timeProvider
        self.calendar = calendar
    }

    func tick() {
        let time = timeProvider.now
        let components = calendar.dateComponents([.second, .hour, .minute], from: time)
        let hours = components.hour!
        let minutes = components.minute!
        let seconds = components.second!

        secondsLamp = engine.computeSecondsLamp(seconds: seconds)
        fiveHourRow = engine.computeFiveHourRow(hours: hours)
        oneHourRow = engine.computeOneHourRow(hours: hours)
        fiveMinuteRow = engine.computeFiveMinuteRow(minutes: minutes)
        oneMinuteRow = engine.computeOneMinuteRow(minutes: minutes)
    }
}
