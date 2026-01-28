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
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: MockMetronome(), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        #expect(viewModel.secondsLamp == .off)
        #expect(viewModel.fiveHourRow == [.off, .off, .off, .off])
        #expect(viewModel.oneHourRow == [.off, .off, .off, .off])
        #expect(viewModel.fiveMinuteRow == [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off])
        #expect(viewModel.oneMinuteRow == [.off, .off, .off, .off])
    }

    @Test("Time text is midnight at init")
    func testTimeTextIsMidnightAtInit() {
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: MockMetronome(), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        #expect(viewModel.timeText == "00:00:00")
    }

    @Test("Lamps are adapted after first tick")
    func testLampsAfterTick() {
        let metronome = MockMetronome()
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: MockTimeProvider(hour: 8, minute: 16, second: 0), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        viewModel.start()
        metronome.tick()

        #expect(viewModel.secondsLamp == .red)
        #expect(viewModel.fiveHourRow == [.red, .off, .off, .off])
        #expect(viewModel.oneHourRow == [.red, .red, .red, .off])
        #expect(viewModel.fiveMinuteRow == [.yellow, .yellow, .red, .off, .off, .off, .off, .off, .off, .off, .off])
        #expect(viewModel.oneMinuteRow == [.yellow, .off, .off, .off])
    }

    @Test("Time text is adapted after first tick")
    func testTimeTextAfterTick() {
        let metronome = MockMetronome()
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: MockTimeProvider(hour: 16, minute: 44, second: 11), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        viewModel.start()
        metronome.tick()

        #expect(viewModel.timeText == "16:44:11")
    }

    @Test("Five-Hour row doesn't update when hour is the same")
    func testFiveHourRowNotUpdatedOnEveryTick() {
        let timeProvider: MockTimeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome = MockMetronome()
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        viewModel.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = viewModel.fiveHourRow
        let cancellable = viewModel.$fiveHourRow.sink { rowUpdates.append($0) }

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
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        viewModel.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = viewModel.oneHourRow
        let cancellable = viewModel.$oneHourRow.sink { rowUpdates.append($0) }

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
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        viewModel.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = viewModel.fiveMinuteRow
        let cancellable = viewModel.$fiveMinuteRow.sink { rowUpdates.append($0) }

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
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        viewModel.start() // 00:00:00
        metronome.tick() // 09:41:00

        var rowUpdates: [[LampColor]] = []
        let originalRow = viewModel.oneMinuteRow
        let cancellable = viewModel.$oneMinuteRow.sink { rowUpdates.append($0) }

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
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
        viewModel.start() // 00:00:00
        metronome.tick() // 09:41:00

        var colorUpdates: [LampColor] = []
        let originalColor = viewModel.secondsLamp
        let cancellable = viewModel.$secondsLamp.sink { colorUpdates.append($0) }

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
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        viewModel.start()

        #expect(metronome.isRunning)
    }

    @Test("Stopping ViewModel stops the metronome")
    func testStopCallsMetronomeStop() {
        let metronome = MockMetronome()
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: metronome, calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))

        viewModel.stop()

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
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: tokyoCalendar, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: tokyoCalendar))
        viewModel.start()
        metronome.tick()

        #expect(viewModel.timeText == "17:41:00")
    }

    @Test("L.A. timezone clock")
    func testLosAngelesTimeZone() {
        let timeProvider = MockTimeProvider(hour: 9, minute: 41, second: 0)
        let metronome: MockMetronome = MockMetronome()

        var losAngelesCalendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(identifier: "America/Los_Angeles") {
            losAngelesCalendar.timeZone = timeZone
        }
        let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: timeProvider, metronome: metronome, calendar: losAngelesCalendar, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: losAngelesCalendar))
        viewModel.start()
        metronome.tick()

        #expect(viewModel.timeText == "00:41:00")
    }
}
