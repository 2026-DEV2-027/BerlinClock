//
//  CustomMetronome.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

import Combine
import Foundation

class CustomMetronome: MetronomeProtocol {
    var onTick: (() -> Void)?
    private var timer: Timer?
    private let tickInterval: TimeInterval

    init(tickInterval: TimeInterval) {
        self.tickInterval = tickInterval
    }

    func start() {
        stop()
        let timer = Timer(timeInterval: tickInterval, repeats: true) { [weak self] _ in
            self?.onTick?()
        }
        RunLoop.main.add(timer, forMode: .common)

        self.timer = timer
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
