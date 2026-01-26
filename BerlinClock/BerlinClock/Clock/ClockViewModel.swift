//
//  ClockViewModel.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

import Combine

class ClockViewModel: ObservableObject {
    @Published var secondsLamp: LampColor = .off
    @Published var fiveHourRow: [LampColor] = []
    @Published var oneHourRow: [LampColor] = []
    @Published var fiveMinuteRow: [LampColor] = []
    @Published var oneMinuteRow: [LampColor] = []

    init() {}
}
