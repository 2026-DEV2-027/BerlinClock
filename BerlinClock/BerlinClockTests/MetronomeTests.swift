//
//  MetronomeTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 28/01/2026.
//

@testable import BerlinClock
import Foundation
import Testing

@MainActor
struct MetronomeTests {
    @Test("onTick closure is called when the scheduler fires")
    func testOnTickClosureCalledWhenSchedulerFires() {
        let mockScheduler = MockScheduler()
        let sut = SystemMetronome(scheduler: mockScheduler)
        var isSchedulerCalled = false

        sut.onTick = { isSchedulerCalled = true }
        sut.start()
        mockScheduler.scheduledTimer?.fire()

        #expect(isSchedulerCalled)
    }
}
