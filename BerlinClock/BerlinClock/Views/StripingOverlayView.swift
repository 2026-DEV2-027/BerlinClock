//
//  StripingOverlayView.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 28/01/2026.
//

import SwiftUI

/// A view that displays a pattern of 45°-angle stripes or crossed stripes, used for the option "Differentiate Without Color".
struct StripingOverlayView: View {
    enum Pattern {
        case striped
        case crossed
    }

    let pattern: Pattern

    var body: some View {
        GeometryReader { geo in
            Path { path in
                let spacing: CGFloat = 6
                let width = geo.size.width
                let height = geo.size.height
                let maxDim = width + height

                // Draw 45 degree lines (/)
                for i in stride(from: -height, to: maxDim, by: spacing) {
                    path.move(to: CGPoint(x: i, y: height))
                    path.addLine(to: CGPoint(x: i + height, y: 0))
                }

                if pattern == .crossed {
                    // Also draw -45 degree lines (\)
                    for i in stride(from: -height, to: maxDim, by: spacing) {
                        path.move(to: CGPoint(x: i, y: 0))
                        path.addLine(to: CGPoint(x: i + height, y: height))
                    }
                }
            }
            .stroke(Color.black.opacity(0.6), lineWidth: 1.5)
        }
    }
}
