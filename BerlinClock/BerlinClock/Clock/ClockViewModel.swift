//
//  ClockViewModel.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

import Combine

class ClockViewModel: ObservableObject {
    @Published var secondsLamp: LampColor = .off
    @Published var fiveHourRow: [LampColor] = Array(repeating: .off, count: 4)
    @Published var oneHourRow: [LampColor] = Array(repeating: .off, count: 4)
    @Published var fiveMinuteRow: [LampColor] = Array(repeating: .off, count: 11)
    @Published var oneMinuteRow: [LampColor] = Array(repeating: .off, count: 4)

    private let timeProvider: TimeProviderProtocol

    init(timeProvider: TimeProviderProtocol = SystemTimeProvider()) {
        self.timeProvider = timeProvider
    }

    func tick() {}
}
