//
//  MockMetronome.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

@testable import BerlinClock

class MockMetronome: MetronomeProtocol {
    var onTick: (() -> Void)?
    var isRunning = false

    func start() {
        isRunning = true
    }

    func stop() {
        isRunning = false
    }

    func tick() {
        onTick?()
    }
}
