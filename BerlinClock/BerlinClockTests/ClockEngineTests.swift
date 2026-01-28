//
//  ClockEngineTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

@testable import BerlinClock
import Testing

@MainActor
struct ClockEngineTests {
    let sut = ClockEngine()

    init() {
        assert(FiveMinutesRow.allOff.count == 11)
        assert(FiveMinutesRow.oneOn.count == 11)
        assert(FiveMinutesRow.twoOn.count == 11)
        assert(FiveMinutesRow.threeOn.count == 11)
        assert(FiveMinutesRow.fourOn.count == 11)
        assert(FiveMinutesRow.fiveOn.count == 11)
        assert(FiveMinutesRow.sixOn.count == 11)
        assert(FiveMinutesRow.sevenOn.count == 11)
        assert(FiveMinutesRow.eightOn.count == 11)
        assert(FiveMinutesRow.nineOn.count == 11)
        assert(FiveMinutesRow.tenOn.count == 11)
        assert(FiveMinutesRow.allOn.count == 11)
    }

    // MARK: - Seconds Lamp

    @Test("Seconds lamp lights up when seconds are even", arguments: [0, 2, 10, 30, 58])
    func testSecondsLampIsOnWhenEven(seconds: Int) {
        #expect(sut.computeSecondsLamp(second: seconds) == .red)
    }

    @Test("Seconds lamp turns off when seconds are odd", arguments: [1, 3, 11, 31, 59])
    func testSecondsLampIsOffWhenOdd(seconds: Int) {
        #expect(sut.computeSecondsLamp(second: seconds) == .off)
    }

    // MARK: - 5-Hour Row

    @Test("All 5-hour lamps are off before 5 hours", arguments: 0...4)
    func testFiveHourLampsAreOff(hours: Int) {
        #expect(sut.computeFiveHourRow(hour: hours) == [.off, .off, .off, .off])
    }

    @Test("One 5-hour lamp is on between 5 and 9 hours", arguments: 5...9)
    func testOneFiveHourLampIsOn(hours: Int) {
        #expect(sut.computeFiveHourRow(hour: hours) == [.red, .off, .off, .off])
    }

    @Test("Two 5-hour lamps are on between 10 and 14 hours", arguments: 10...14)
    func testTwoFiveHourLampsAreOn(hours: Int) {
        #expect(sut.computeFiveHourRow(hour: hours) == [.red, .red, .off, .off])
    }

    @Test("Three 5-hour lamps are on between 15 and 19 hours", arguments: 15...19)
    func testThreeFiveHourLampsAreOn(hours: Int) {
        #expect(sut.computeFiveHourRow(hour: hours) == [.red, .red, .red, .off])
    }

    @Test("All 5-hour lamps are on from 20 hours", arguments: 20...23)
    func testAllFiveHourLampsAreOn(hours: Int) {
        #expect(sut.computeFiveHourRow(hour: hours) == [.red, .red, .red, .red])
    }

    // MARK: - 1-Hour Row

    @Test("All 1-hour lamps are off on hours ending with 0 or 5", arguments: [0, 5, 10, 15, 20])
    func testOneHourLampsAreOff(hours: Int) {
        #expect(sut.computeOneHourRow(hour: hours) == [.off, .off, .off, .off])
    }

    @Test("One 1-hour lamp is on on hours ending with 1 or 6", arguments: [1, 6, 11, 16, 21])
    func testSingleOneHourLampIsOn(hours: Int) {
        #expect(sut.computeOneHourRow(hour: hours) == [.red, .off, .off, .off])
    }

    @Test("Two 1-hour lamps are on on hours ending with 2 or 7", arguments: [2, 7, 12, 17, 22])
    func testTwoOneHourLampsAreOn(hours: Int) {
        #expect(sut.computeOneHourRow(hour: hours) == [.red, .red, .off, .off])
    }

    @Test("Three 1-hour lamps are on on hours ending with 3 or 8", arguments: [3, 8, 13, 18, 23])
    func testThreeOneHourLampsAreOn(hours: Int) {
        #expect(sut.computeOneHourRow(hour: hours) == [.red, .red, .red, .off])
    }

    @Test("All 1-hour lamps are on on hours ending with 4 or 9", arguments: [4, 9, 14, 19])
    func testAllOneHourLampsAreOn(hours: Int) {
        #expect(sut.computeOneHourRow(hour: hours) == [.red, .red, .red, .red])
    }

    // MARK: - 5-Minute Row

    @Test("All 5-minute lamps are off under 5 minutes", arguments: 0...4)
    func testFiveMinuteLampsAreOff(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.allOff)
    }

    @Test("One 5-minute lamp is on between 5 and 9 minutes", arguments: 5...9)
    func testOneFiveMinuteLampIsOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.oneOn)
    }

    @Test("Two 5-minute lamps are on between 10 and 14 minutes", arguments: 10...14)
    func testTwoFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.twoOn)
    }

    @Test("Three 5-minute lamps are on between 15 and 19 minutes", arguments: 15...19)
    func testThreeFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.threeOn)
    }

    @Test("Four 5-minute lamps are on between 20 and 24 minutes", arguments: 20...24)
    func testFourFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.fourOn)
    }

    @Test("Five 5-minute lamps are on between 25 and 29 minutes", arguments: 25...29)
    func testFiveFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.fiveOn)
    }

    @Test("Six 5-minute lamps are on between 30 and 34 minutes", arguments: 30...34)
    func testSixFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.sixOn)
    }

    @Test("Seven 5-minute lamps are on between 35 and 39 minutes", arguments: 35...39)
    func testSevenFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.sevenOn)
    }

    @Test("Eight 5-minute lamps are on between 40 and 44 minutes", arguments: 40...44)
    func testEightFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.eightOn)
    }

    @Test("Nine 5-minute lamps are on between 45 and 49 minutes", arguments: 45...49)
    func testNineFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.nineOn)
    }

    @Test("Ten 5-minute lamps are on between 50 and 54 minutes", arguments: 50...54)
    func testTenFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.tenOn)
    }

    @Test("All 5-minute lamps are on between 55 and 59 minutes", arguments: 55...59)
    func testAllFiveMinuteLampAreOn(minutes: Int) {
        #expect(sut.computeFiveMinuteRow(minute: minutes) == FiveMinutesRow.allOn)
    }

    // MARK: - 1-Minute Row

    @Test("All 1-minute lamps are off on minutes ending with 0 or 5", arguments: [0, 5, 30, 55])
    func testAllOneMinuteLampsAreOff(minutes: Int) {
        #expect(sut.computeOneMinuteRow(minute: minutes) == [.off, .off, .off, .off])
    }

    @Test("One 1-minute lamp is on on minutes ending with 1 or 6", arguments: [1, 16, 31, 56])
    func testSingleOneMinuteLampIsOn(minutes: Int) {
        #expect(sut.computeOneMinuteRow(minute: minutes) == [.yellow, .off, .off, .off])
    }

    @Test("Two 1-minute lamps are on on minutes ending with 2 or 7", arguments: [2, 27, 32, 57])
    func testTwoOneMinuteLampsAreOn(minutes: Int) {
        #expect(sut.computeOneMinuteRow(minute: minutes) == [.yellow, .yellow, .off, .off])
    }

    @Test("Three 1-minute lamps are on on minutes ending with 3 or 8", arguments: [3, 18, 33, 58])
    func testThreeOneMinuteLampsAreOn(minutes: Int) {
        #expect(sut.computeOneMinuteRow(minute: minutes) == [.yellow, .yellow, .yellow, .off])
    }

    @Test("All 1-minute lamps are on on minutes ending with 4 or 9", arguments: [4, 29, 34, 59])
    func testAllOneMinuteLampsAreOn(minutes: Int) {
        #expect(sut.computeOneMinuteRow(minute: minutes) == [.yellow, .yellow, .yellow, .yellow])
    }
}

private extension ClockEngineTests {

    enum FiveMinutesRow {
        static let allOff:  [LampColor] = Array(repeating: .off, count: 11)
        static let oneOn:   [LampColor] = [.yellow] + Array(repeating: .off, count: 10)
        static let twoOn:   [LampColor] = [.yellow, .yellow] + Array(repeating: .off, count: 9)
        static let threeOn: [LampColor] = [.yellow, .yellow, .red] + Array(repeating: .off, count: 8)
        static let fourOn:  [LampColor] = [.yellow, .yellow, .red, .yellow] + Array(repeating: .off, count: 7)
        static let fiveOn:  [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow] + Array(repeating: .off, count: 6)
        static let sixOn:   [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow, .red] + Array(repeating: .off, count: 5)
        static let sevenOn: [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow] + Array(repeating: .off, count: 4)
        static let eightOn: [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow] + Array(repeating: .off, count: 3)
        static let nineOn:  [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red] + Array(repeating: .off, count: 2)
        static let tenOn:   [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off]
        static let allOn:   [LampColor] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow]
    }
}
