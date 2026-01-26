//
//  ClockEngineTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import Testing
@testable import BerlinClock

struct ClockEngineTests {
    let clockEngine = ClockEngine()

    @Test("Seconds lamp lights up when seconds are even and turns off when seconds are odd")
    func testSecondsLamp() async throws {
        #expect(clockEngine.computeSecondsLamp(seconds: 0) == .red)
        #expect(clockEngine.computeSecondsLamp(seconds: 1) == .off)
        #expect(clockEngine.computeSecondsLamp(seconds: 2) == .red)
        #expect(clockEngine.computeSecondsLamp(seconds: 59) == .off)
    }

    @Test("In 5-hour row, lamps are lit per 5-hour block")
    func testFiveHourRow() async throws {
        let allOff: [LampColor] = [.off, .off, .off, .off]
        #expect(clockEngine.computeFiveHourRow(hours: 0) == allOff)
        #expect(clockEngine.computeFiveHourRow(hours: 1) == allOff)
        #expect(clockEngine.computeFiveHourRow(hours: 4) == allOff)

        let oneLamp: [LampColor] = [.red, .off, .off, .off]
        #expect(clockEngine.computeFiveHourRow(hours: 5) == oneLamp)
        #expect(clockEngine.computeFiveHourRow(hours: 9) == oneLamp)

        let twoLamps: [LampColor] = [.red, .red, .off, .off]
        #expect(clockEngine.computeFiveHourRow(hours: 10) == twoLamps)
        #expect(clockEngine.computeFiveHourRow(hours: 14) == twoLamps)

        let threeLamps: [LampColor] = [.red, .red, .red, .off]
        #expect(clockEngine.computeFiveHourRow(hours: 15) == threeLamps)
        #expect(clockEngine.computeFiveHourRow(hours: 19) == threeLamps)

        let allLamps: [LampColor] = [.red, .red, .red, .red]
        #expect(clockEngine.computeFiveHourRow(hours: 20) == allLamps)
        #expect(clockEngine.computeFiveHourRow(hours: 23) == allLamps)
    }

    @Test("In 1-hour row, lamps are lit based on the remaining hours after the 5-hour blocks")
    func testOneHourRow() async throws {
        let allOff: [LampColor] = [.off, .off, .off, .off]
        #expect(clockEngine.computeOneHourRow(hours: 0) == allOff)
        #expect(clockEngine.computeOneHourRow(hours: 5) == allOff)
        #expect(clockEngine.computeOneHourRow(hours: 10) == allOff)
        #expect(clockEngine.computeOneHourRow(hours: 15) == allOff)
        #expect(clockEngine.computeOneHourRow(hours: 20) == allOff)

        let oneLamp: [LampColor] = [.red, .off, .off, .off]
        #expect(clockEngine.computeOneHourRow(hours: 1) == oneLamp)
        #expect(clockEngine.computeOneHourRow(hours: 6) == oneLamp)
        #expect(clockEngine.computeOneHourRow(hours: 11) == oneLamp)
        #expect(clockEngine.computeOneHourRow(hours: 16) == oneLamp)
        #expect(clockEngine.computeOneHourRow(hours: 21) == oneLamp)

        let twoLamps: [LampColor] = [.red, .red, .off, .off]
        #expect(clockEngine.computeOneHourRow(hours: 2) == twoLamps)
        #expect(clockEngine.computeOneHourRow(hours: 7) == twoLamps)
        #expect(clockEngine.computeOneHourRow(hours: 12) == twoLamps)
        #expect(clockEngine.computeOneHourRow(hours: 17) == twoLamps)
        #expect(clockEngine.computeOneHourRow(hours: 22) == twoLamps)

        let threeLamps: [LampColor] = [.red, .red, .red, .off]
        #expect(clockEngine.computeOneHourRow(hours: 3) == threeLamps)
        #expect(clockEngine.computeOneHourRow(hours: 8) == threeLamps)
        #expect(clockEngine.computeOneHourRow(hours: 13) == threeLamps)
        #expect(clockEngine.computeOneHourRow(hours: 18) == threeLamps)
        #expect(clockEngine.computeOneHourRow(hours: 23) == threeLamps)

        let allLamps: [LampColor] = [.red, .red, .red, .red]
        #expect(clockEngine.computeOneHourRow(hours: 4) == allLamps)
        #expect(clockEngine.computeOneHourRow(hours: 9) == allLamps)
        #expect(clockEngine.computeOneHourRow(hours: 14) == allLamps)
        #expect(clockEngine.computeOneHourRow(hours: 19) == allLamps)
    }
}
