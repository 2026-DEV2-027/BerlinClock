//
//  ClockViewModelTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

@testable import BerlinClock
import Combine
import Foundation
import Testing

@MainActor
struct ClockViewModelTests {
    @Test("All lamps are off at init")
    func testLampsAreOffAtInit() {
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: MockMetronome(), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        #expect(sut.secondsLamp == .off)
        #expect(sut.fiveHourRow == [.off, .off, .off, .off])
        #expect(sut.oneHourRow == [.off, .off, .off, .off])
        #expect(sut.fiveMinuteRow == [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off])
        #expect(sut.oneMinuteRow == [.off, .off, .off, .off])
    }

    @Test("Time text is midnight at init")
    func testTimeTextIsMidnightAtInit() {
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: MockMetronome(), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        #expect(sut.timeText == "00:00:00")
    }

    @Test("Lamps are adapted after first tick")
    func testLampsAfterTick() {
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: MockTimeProvider(hour: 8, minute: 16, second: 0), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        sut.start()
        metronome.tick()

        #expect(sut.secondsLamp == .red)
        #expect(sut.fiveHourRow == [.red, .off, .off, .off])
        #expect(sut.oneHourRow == [.red, .red, .red, .off])
        #expect(sut.fiveMinuteRow == [.yellow, .yellow, .red, .off, .off, .off, .off, .off, .off, .off, .off])
        #expect(sut.oneMinuteRow == [.yellow, .off, .off, .off])
    }

    @Test("Time text is adapted after first tick")
    func testTimeTextAfterTick() {
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: MockTimeProvider(hour: 16, minute: 44, second: 11), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start()
        metronome.tick()

        #expect(sut.timeText == "16:44:11")
    }

    @Test("Five-Hour row doesn't update when hour is the same")
    func testFiveHourRowNotUpdatedOnEveryTick() {
        let timeProvider: MockTimeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = sut.fiveHourRow
        let cancellable = sut.$fiveHourRow.sink { rowUpdates.append($0) }

        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:01
        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:02

        cancellable.cancel()

        #expect(rowUpdates.count == 1)

        if let row = rowUpdates.first {
            #expect(row == originalRow)
        }
    }

    @Test("One-Hour row doesn't update when hour is the same")
    func testOneHourRowNotUpdatedOnEveryTick() {
        let timeProvider: MockTimeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = sut.oneHourRow
        let cancellable = sut.$oneHourRow.sink { rowUpdates.append($0) }

        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:01
        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:02

        cancellable.cancel()

        #expect(rowUpdates.count == 1)

        if let row = rowUpdates.first {
            #expect(row == originalRow)
        }
    }

    @Test("Five-Minute row doesn't update when minute is the same")
    func testFiveMinuteRowNotUpdatedOnEveryTick() {
        let timeProvider: MockTimeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = sut.fiveMinuteRow
        let cancellable = sut.$fiveMinuteRow.sink { rowUpdates.append($0) }

        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:01
        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:02

        cancellable.cancel()

        #expect(rowUpdates.count == 1)

        if let row = rowUpdates.first {
            #expect(row == originalRow)
        }
    }

    @Test("One-Minute row doesn't update when minute is the same")
    func testOneMinuteRowNotUpdatedOnEveryTick() {
        let timeProvider: MockTimeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = sut.oneMinuteRow
        let cancellable = sut.$oneMinuteRow.sink { rowUpdates.append($0) }

        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:01
        timeProvider.advance(by: 1)
        metronome.tick() // 09:41:02

        cancellable.cancel()

        #expect(rowUpdates.count == 1)

        if let row = rowUpdates.first {
            #expect(row == originalRow)
        }
    }

    @Test("Second Lamp doesn't update when second is the same")
    func testSecondLampNotUpdatedOnEveryTick() {
        let timeProvider: MockTimeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start() // 00:00:00
        metronome.tick() // 09:41:00

        var colorUpdates: [LampColor] = []
        let originalColor = sut.secondsLamp
        let cancellable = sut.$secondsLamp.sink { colorUpdates.append($0) }

        metronome.tick() // 09:41:00
        metronome.tick() // 09:41:00

        cancellable.cancel()

        #expect(colorUpdates.count == 1)

        if let color = colorUpdates.first {
            #expect(color == originalColor)
        }
    }

    @Test("Starting ViewModel starts the metronome")
    func testStartCallsMetronomeStart() {
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        sut.start()

        #expect(metronome.isRunning)
    }

    @Test("Stopping ViewModel stops the metronome")
    func testStopCallsMetronomeStop() {
        let metronome = MockMetronome()
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        sut.stop()

        #expect(!metronome.isRunning)
    }

    @Test("Tokyo timezone clock")
    func testTokyoTimeZone() {
        let timeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome: MockMetronome = MockMetronome()

        var tokyoCalendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
            tokyoCalendar.timeZone = timeZone
        }
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: tokyoCalendar, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: tokyoCalendar))
        sut.start()
        metronome.tick()

        #expect(sut.timeText == "17:41:00")
    }

    @Test("L.A. timezone clock")
    func testLosAngelesTimeZone() {
        let timeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome: MockMetronome = MockMetronome()

        var losAngelesCalendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(identifier: "America/Los_Angeles") {
            losAngelesCalendar.timeZone = timeZone
        }
        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: losAngelesCalendar, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: losAngelesCalendar))
        sut.start()
        metronome.tick()

        #expect(sut.timeText == "00:41:00")
    }

    @Test("Hour accessibility translates to current hour")
    func testVoiceOverHour() {
        let timeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome: MockMetronome = MockMetronome()

        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start()
        metronome.tick()

        #expect(sut.accessibilityHour.key == "accessibility.time.hour")
    }

    @Test("Hour accessibility translates to midnight when hour is 0")
    func testVoiceOverMidnight() {
        let timeProvider = MockTimeProvider(hour: 0, minute: 0, second: 0)
        let metronome: MockMetronome = MockMetronome()

        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start()
        metronome.tick()

        #expect(sut.accessibilityHour.key == "accessibility.time.hour.midnight")
    }

    @Test("Hour accessibility translates to noon when hour is 12")
    func testVoiceOverNoon() {
        let timeProvider = MockTimeProvider(hour: 12, minute: 0, second: 0)
        let metronome: MockMetronome = MockMetronome()

        let sut = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        sut.start()
        metronome.tick()

        #expect(sut.accessibilityHour.key == "accessibility.time.hour.noon")
    }
}
