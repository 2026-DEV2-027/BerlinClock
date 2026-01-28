//
//  ClockView.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import SwiftUI

struct ClockView: View {
    @StateObject var viewModel: ClockViewModel

    init(viewModel: ClockViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Text(instructions)
                .multilineTextAlignment(.center)

            Spacer()

            LampView(lampColor: viewModel.secondsLamp, isCircle: true)
                .frame(height: 80)

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

            Spacer()

            Text(viewModel.timeText)
                .font(.largeTitle)
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
}

private extension ClockView {

    var instructions: String {
        switch SwiftUIViewRunner.current {
        case .preview: "⬆️ Do check the other Previews above ⬆️"
        case .simulator, .device: "🌙 Try out dark mode"
        }
    }
}

#Preview("Berlin Clock") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
}

#Preview("Dark mode") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(scheduler: RunLoop.main), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
        .preferredColorScheme(.dark)
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
