//
//  TimerScheduler.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 28/01/2026.
//

import Foundation

protocol TimerScheduler {
    func add(_ timer: Timer, forMode mode: RunLoop.Mode)
}

extension RunLoop: TimerScheduler {}
