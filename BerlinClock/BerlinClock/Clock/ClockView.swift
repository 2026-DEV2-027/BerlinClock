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
