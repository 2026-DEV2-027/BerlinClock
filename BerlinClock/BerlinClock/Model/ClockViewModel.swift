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
    @Published var accessibilityHour = LocalizedStringResource(stringLiteral: "")
    @Published var accessibilityMinute = LocalizedStringResource(stringLiteral: "")
    @Published var accessibilitySecond = LocalizedStringResource(stringLiteral: "")

    private let engine: ClockEngine
    private let timeProvider: TimeProviderProtocol
    private var metronome: MetronomeProtocol
    private let calendar: Calendar
    private let dateFormatter: DateFormatter
    private var hour: Int?
    private var minute: Int?
    private var second: Int?

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
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0

        if second != self.second {
            secondsLamp = engine.computeSecondsLamp(for: second)
            accessibilitySecond = LocalizedStringResource.accessibilityTimeSecond(second: second)
        }

        if hour != self.hour {
            fiveHourRow = engine.computeFiveHourRow(for: hour)
            oneHourRow = engine.computeOneHourRow(for: hour)
            accessibilityHour = accessibilityLabel(for: hour)
        }

        if minute != self.minute {
            fiveMinuteRow = engine.computeFiveMinuteRow(for: minute)
            oneMinuteRow = engine.computeOneMinuteRow(for: minute)
            accessibilityMinute = LocalizedStringResource.accessibilityTimeMinute(minute: minute)
        }

        timeText = dateFormatter.string(from: time)

        self.hour = hour
        self.minute = minute
        self.second = second
    }

    func accessibilityLabel(for hour: Int) -> LocalizedStringResource {
        switch hour {
        case 0:
            LocalizedStringResource.accessibilityTimeHourMidnight
        case 12:
            LocalizedStringResource.accessibilityTimeHourNoon
        default:
            LocalizedStringResource.accessibilityTimeHour(hour: hour)
        }
    }
}
