//
//  SwiftUIViewState.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

import Foundation

enum SwiftUIViewRunner {
    case simulator
    case preview
    case device

    static var current: SwiftUIViewRunner {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return .preview
        }

        #if targetEnvironment(simulator)
        return .simulator
        #else
        return .device
        #endif
    }
}
