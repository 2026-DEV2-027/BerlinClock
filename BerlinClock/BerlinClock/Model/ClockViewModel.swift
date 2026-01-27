//
//  ClockViewModel.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

import Combine
import Foundation

@MainActor
class ClockViewModel: ObservableObject {
    @Published var secondsLamp: LampColor = .off
    @Published var fiveHourRow: [LampColor] = Array(repeating: .off, count: 4)
    @Published var oneHourRow: [LampColor] = Array(repeating: .off, count: 4)
    @Published var fiveMinuteRow: [LampColor] = Array(repeating: .off, count: 11)
    @Published var oneMinuteRow: [LampColor] = Array(repeating: .off, count: 4)
    @Published var timeText: String = "00:00:00"

    private let engine: ClockEngine
    private let timeProvider: TimeProviderProtocol
    private var metronome: MetronomeProtocol
    private let calendar: Calendar
    private let dateFormatter: DateFormatter
    private var hours = 0
    private var minutes = 0

    init(engine: ClockEngine, timeProvider: TimeProviderProtocol, metronome: MetronomeProtocol, calendar: Calendar, dateFormatter: DateFormatter) {
        self.engine = engine
        self.timeProvider = timeProvider
        self.metronome = metronome
        self.calendar = calendar
        self.dateFormatter = dateFormatter
    }

    func start() {
        metronome.onTick = tick
        metronome.start()
    }

    func stop() {
        metronome.stop()
    }
}

private extension ClockViewModel {

    func tick() {
        let time = timeProvider.now
        let components = calendar.dateComponents([.second, .hour, .minute], from: time)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0

        secondsLamp = engine.computeSecondsLamp(seconds: seconds)

        if hours != self.hours {
            fiveHourRow = engine.computeFiveHourRow(hours: hours)
            oneHourRow = engine.computeOneHourRow(hours: hours)
        }

        if minutes != self.minutes {
            fiveMinuteRow = engine.computeFiveMinuteRow(minutes: minutes)
            oneMinuteRow = engine.computeOneMinuteRow(minutes: minutes)
        }

        timeText = dateFormatter.string(from: time)

        self.hours = hours
        self.minutes = minutes
    }
}
