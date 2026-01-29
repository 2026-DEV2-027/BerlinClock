//
//  MetronomeProtocol.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

/// Provides an `onTick closure that signals a tick of a scheduler.
protocol MetronomeProtocol {
    var onTick: (() -> Void)? { get set }
    func start()
    func stop()
}
