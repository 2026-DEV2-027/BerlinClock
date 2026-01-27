//
//  SystemTimeProvider.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import Foundation

struct SystemTimeProvider: TimeProviderProtocol {
    var now: Date { Date() }
}
