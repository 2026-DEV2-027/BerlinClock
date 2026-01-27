//
//  ClockView.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import SwiftUI
import Combine

struct ClockView: View {
    @StateObject var viewModel = ClockViewModel()

    init(viewModel: ClockViewModel = ClockViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
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

extension LampColor {
    var color: Color {
        switch self {
        case .off:
            return .gray
        case .yellow:
            return .yellow
        case .red:
            return .red
        }
    }
}

#Preview("Berlin Clock") {
    ClockView()
}

#Preview("Fast Clock") {
    let viewModel = ClockViewModel(timeProvider: IncrementingTimeProvider(), metronome: CustomMetronome(tickInterval: 0.0001))
    return ClockView(viewModel: viewModel)
}

#Preview("Berlin Clock in Toyko time") {
    var tokyoCalendar = Calendar(identifier: .gregorian)
    tokyoCalendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    let viewModel = ClockViewModel(calendar: tokyoCalendar)
    return ClockView(viewModel: viewModel)
}
