//
//  SystemMetronome.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

import Foundation

class SystemMetronome: MetronomeProtocol {
    var onTick: (() -> Void)?
    private let scheduler: TimerScheduler
    private var timer: Timer?

    init(scheduler: TimerScheduler) {
        self.scheduler = scheduler
    }

    func start() {
        stop()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date.now)

        guard let nextRoundedSecond = calendar.date(from: components)?.addingTimeInterval(1.0) else { return }

        let timer = Timer(fire: nextRoundedSecond, interval: 1.0, repeats: true) { [weak self] _ in
            self?.onTick?()
        }
        scheduler.add(timer, forMode: .common)

        self.timer = timer
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
