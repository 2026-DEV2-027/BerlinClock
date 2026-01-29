//
//  TimeProviderProtocol.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import Foundation

/// Provides a `now` value.
protocol TimeProviderProtocol {
    var now: Date { get }
}
