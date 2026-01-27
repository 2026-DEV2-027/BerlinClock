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

            Circle()
                .foregroundStyle(viewModel.secondsLamp.color)
                .frame(height: 80)

            HStack {
                ForEach(viewModel.fiveHourRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.fiveHourRow[index].color)
                }
            }
            .frame(height: 40)

            HStack {
                ForEach(viewModel.oneHourRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.oneHourRow[index].color)
                }
            }
            .frame(height: 40)

            HStack {
                ForEach(viewModel.fiveMinuteRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.fiveMinuteRow[index].color)
                }
            }
            .frame(height: 40)

            HStack {
                ForEach(viewModel.oneMinuteRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.oneMinuteRow[index].color)
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
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
}

#Preview("Dark mode") {
    ClockView(viewModel: ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current)))
        .preferredColorScheme(.dark)
}

#Preview("Fast Clock") {
    let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: IncrementingTimeProvider(), metronome: CustomMetronome(tickInterval: 0.0001), calendar: Calendar.current, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: Calendar.current))
    return ClockView(viewModel: viewModel)
}

#Preview("Toyko time zone") {
    var tokyoCalendar = Calendar(identifier: .gregorian)
    tokyoCalendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    let viewModel = ClockViewModel(engine: ClockEngine(), timeProvider: SystemTimeProvider(), metronome: SystemMetronome(), calendar: tokyoCalendar, dateFormatter: DateFormatter(dateFormat: "HH:mm:ss", calendar: tokyoCalendar))
    return ClockView(viewModel: viewModel)
}
