//
//  MockScheduler.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 28/01/2026.
//

@testable import BerlinClock
import Foundation

class MockScheduler: TimerScheduler {
    var scheduledTimer: Timer?

    func add(_ timer: Timer, forMode mode: RunLoop.Mode) {
        self.scheduledTimer = timer
    }
}
