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
    let allFiveMinuteLamps: [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow]

    // MARK: - Seconds Lamp

    @Test("Seconds lamp lights up when seconds are even", arguments: [0, 2, 10, 30, 58])
    func testSecondsLampIsOnWhenEven(seconds: Int) {
        #expect(clockEngine.computeSecondsLamp(seconds: seconds) == .red)
    }

    @Test("Seconds lamp turns off when seconds are odd", arguments: [1, 3, 11, 31, 59])
    func testSecondsLampIsOffWhenOdd(seconds: Int) {
        #expect(clockEngine.computeSecondsLamp(seconds: seconds) == .off)
    }

    // MARK: - 5-hour Lamps

    @Test("All 5-hour lamps are off before 5 hours", arguments: 0...4)
    func testFiveHourLampsAreOff(hours: Int) {
        #expect(clockEngine.computeFiveHourRow(hours: hours) == [.off, .off, .off, .off])
    }

    @Test("One 5-hour lamp is on between 5 and 9 hours", arguments: 5...9)
    func testOneFiveHourLampIsOn(hours: Int) {
        #expect(clockEngine.computeFiveHourRow(hours: hours) == [.red, .off, .off, .off])
    }

    @Test("Two 5-hour lamps are on between 10 and 14 hours", arguments: 10...14)
    func testTwoFiveHourLampsAreOn(hours: Int) {
        #expect(clockEngine.computeFiveHourRow(hours: hours) == [.red, .red, .off, .off])
    }

    @Test("Three 5-hour lamps are on between 15 and 19 hours", arguments: 15...19)
    func testThreeFiveHourLampsAreOn(hours: Int) {
        #expect(clockEngine.computeFiveHourRow(hours: hours) == [.red, .red, .red, .off])
    }

    @Test("All 5-hour lamps are on from 20 hours", arguments: 20...23)
    func testAllFiveHourLampsAreOn(hours: Int) {
        #expect(clockEngine.computeFiveHourRow(hours: hours) == [.red, .red, .red, .red])
    }

    // MARK: - 1-hour Lamps

    @Test("In 1-hour row, lamps are lit based on the remaining hours after the 5-hour lamps")
    func testOneHourRow() {
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

    // MARK: - 5-minute Lamps

    @Test("In 5-minute row, lamps are lit in yellow based per 5-minute block, and every third lamp is red when lit.")
    func testFiveMinuteRow() {
        let allOff: [LampColor] = createFiveMinutesRow(lit: 0)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 0) == allOff)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 1) == allOff)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 4) == allOff)

        let firstLamp: [LampColor] = createFiveMinutesRow(lit: 1)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 5) == firstLamp)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 9) == firstLamp)

        let twoLamps: [LampColor] = createFiveMinutesRow(lit: 2)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 10) == twoLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 14) == twoLamps)

        let threeLamps: [LampColor] = createFiveMinutesRow(lit: 3)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 15) == threeLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 19) == threeLamps)

        let fourLamps: [LampColor] = createFiveMinutesRow(lit: 4)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 20) == fourLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 24) == fourLamps)

        let fiveLamps: [LampColor] = createFiveMinutesRow(lit: 5)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 25) == fiveLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 29) == fiveLamps)

        let sixLamps: [LampColor] = createFiveMinutesRow(lit: 6)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 30) == sixLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 34) == sixLamps)

        let sevenLamps: [LampColor] = createFiveMinutesRow(lit: 7)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 35) == sevenLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 39) == sevenLamps)

        let eigthLamps: [LampColor] = createFiveMinutesRow(lit: 8)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 40) == eigthLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 44) == eigthLamps)

        let nineLamps: [LampColor] = createFiveMinutesRow(lit: 9)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 45) == nineLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 49) == nineLamps)

        let tenLamps: [LampColor] = createFiveMinutesRow(lit: 10)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 50) == tenLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 54) == tenLamps)

        let allLamps: [LampColor] = createFiveMinutesRow(lit: 11)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 55) == allLamps)
        #expect(clockEngine.computeFiveMinuteRow(minutes: 59) == allLamps)
    }

    // MARK: - 1-minute Lamps

    @Test("In 1-minute row, lamps are lit based on the remaining minutes after the 5-minute lamps")
    func testOneMinuteRow() {
        let allOff: [LampColor] = [.off, .off, .off, .off]
        #expect(clockEngine.computeOneMinuteRow(minutes: 0) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 5) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 10) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 15) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 20) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 25) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 30) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 35) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 40) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 45) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 50) == allOff)
        #expect(clockEngine.computeOneMinuteRow(minutes: 55) == allOff)

        let oneLamp: [LampColor] = [.yellow, .off, .off, .off]
        #expect(clockEngine.computeOneMinuteRow(minutes: 1) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 6) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 11) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 16) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 21) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 26) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 31) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 36) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 41) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 46) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 51) == oneLamp)
        #expect(clockEngine.computeOneMinuteRow(minutes: 56) == oneLamp)

        let twoLamps: [LampColor] = [.yellow, .yellow, .off, .off]
        #expect(clockEngine.computeOneMinuteRow(minutes: 2) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 7) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 12) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 17) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 22) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 27) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 32) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 37) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 42) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 47) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 52) == twoLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 57) == twoLamps)

        let threeLamps: [LampColor] = [.yellow, .yellow, .yellow, .off]
        #expect(clockEngine.computeOneMinuteRow(minutes: 3) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 8) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 13) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 18) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 23) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 28) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 33) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 38) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 43) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 48) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 53) == threeLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 58) == threeLamps)

        let allLamps: [LampColor] = [.yellow, .yellow, .yellow, .yellow]
        #expect(clockEngine.computeOneMinuteRow(minutes: 4) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 9) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 14) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 19) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 24) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 29) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 34) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 39) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 44) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 49) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 54) == allLamps)
        #expect(clockEngine.computeOneMinuteRow(minutes: 59) == allLamps)
    }
}

private extension ClockEngineTests {

    func createFiveMinutesRow(lit lampsCount: Int) -> [LampColor] {
        return Array(allFiveMinuteLamps.prefix(lampsCount)) + Array(repeating: .off, count: allFiveMinuteLamps.count - lampsCount)
    }
}
