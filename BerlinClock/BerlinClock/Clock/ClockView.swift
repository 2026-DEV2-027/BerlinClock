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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Circle()
                .foregroundStyle(viewModel.secondsLamp.color)

            HStack {
                ForEach(viewModel.fiveHourRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.fiveHourRow[index].color)
                }
            }

            HStack {
                ForEach(viewModel.oneHourRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.oneHourRow[index].color)
                }
            }

            HStack {
                ForEach(viewModel.fiveMinuteRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.fiveMinuteRow[index].color)
                }
            }

            HStack {
                ForEach(viewModel.oneMinuteRow.indices, id: \.self) { index in
                    Rectangle()
                        .foregroundStyle(viewModel.oneMinuteRow[index].color)
                }
            }
        }
        .onReceive(timer) { time in
            viewModel.tick()
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

#Preview {
    ClockView()
}
