//
//  ClockView.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import SwiftUI

/// The main clock view of the Berlin Clock.
///
/// There are instructions at the top that varies on the target type, the clock UI in the middle, and the current time as text at the bottom.
/// When in landscape orientation, the clock is at the top, the instructions at the bottom, and the time is displayed on the bottom right of the clock.
///
/// When using VoiceOver, the prononciations are grouped per time unit and not per row.
struct ClockView: View {
    @StateObject var viewModel: ClockViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass

    init(viewModel: ClockViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            if verticalSizeClass == .regular {
                VStack {
                    instructions
                    Spacer()
                    clock
                    Spacer()
                    time
                }
            } else {
                VStack {
                    clock
                        .overlay(alignment: .topTrailing) {
                            time
                                .padding()
                        }
                    Spacer()
                    instructions
                }
            }
        }
        .animation(.default.speed(1.25), value: viewModel.secondsLamp)
        .padding()
        .task {
            viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
    }

    var clock: some View {
        VStack {
            LampView(lampColor: viewModel.secondsLamp, isCircle: true)
                .frame(height: 80)
                .accessibilityLabel(viewModel.accessibilitySecond)

            VStack {
                HStack {
                    ForEach(viewModel.fiveHourRow.indices, id: \.self) { index in
                        LampView(lampColor: viewModel.fiveHourRow[index], isCircle: false)
                    }
                }
                .frame(height: 40)

                HStack {
                    ForEach(viewModel.oneHourRow.indices, id: \.self) { index in
                        LampView(lampColor: viewModel.oneHourRow[index], isCircle: false)
                    }
                }
                .frame(height: 40)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(viewModel.accessibilityHour)

            VStack {
                HStack {
                    ForEach(viewModel.fiveMinuteRow.indices, id: \.self) { index in
                        LampView(lampColor: viewModel.fiveMinuteRow[index], isCircle: false)
                    }
                }
                .frame(height: 40)

                HStack {
                    ForEach(viewModel.oneMinuteRow.indices, id: \.self) { index in
                        LampView(lampColor: viewModel.oneMinuteRow[index], isCircle: false)
                    }
                }
                .frame(height: 40)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(viewModel.accessibilityMinute)
        }
    }

    var instructions: some View {
        Text(localizedInstructions)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
    }

    var time: some View {
        Text(viewModel.timeText)
            .font(.largeTitle)
    }
}

private extension ClockView {

    var localizedInstructions: LocalizedStringResource {
        switch SwiftUIViewRunner.current {
        case .preview: .clockInstructionsPreview
        case .simulator: .clockInstructionsSimulator
        case .device: .clockInstructionsDevice
        }
    }
}

#Preview("Berlin Clock 🇬🇧") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("Berlin Clock 🇫🇷") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
        .environment(\.locale, .init(identifier: "fr"))
}

#Preview("Berlin Clock 🇳🇱") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
        .environment(\.locale, .init(identifier: "nl"))
}

#Preview("Dark mode") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
        .preferredColorScheme(.dark)
}

#Preview("Big font") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
        .environment(\.locale, .init(identifier: "en"))
        .dynamicTypeSize(.accessibility5)
}

#Preview("Fast Clock") {
    let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: IncrementingTimeProvider(), metronome: CustomMetronome(tickInterval: 0.0001), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
    return ClockView(viewModel: viewModel)
}

#Preview("Tokyo time zone") {
    var tokyoCalendar = Calendar(identifier: .gregorian)
    if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
        tokyoCalendar.timeZone = timeZone
    }
    let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: tokyoCalendar, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: tokyoCalendar))
    return ClockView(viewModel: viewModel)
}

