//
//  LampView.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 28/01/2026.
//

import SwiftUI

struct LampView: View {
    let lampColor: LampColor
    let isCircle: Bool

    var body: some View {
        shape
            .fill(lampColor.color)
            .overlay {
                shape.stroke(.gray, lineWidth: 2)
            }
    }

    var shape: some Shape {
        isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview("Red") {
    LampView(lampColor: .red, isCircle: false)
}

#Preview("Red (Dark mode)") {
    LampView(lampColor: .red, isCircle: false)
        .preferredColorScheme(.dark)
}

#Preview("Yellow") {
    LampView(lampColor: .yellow, isCircle: false)
}

#Preview("Yellow (Dark mode)") {
    LampView(lampColor: .yellow, isCircle: false)
        .preferredColorScheme(.dark)
}

#Preview("Off") {
    LampView(lampColor: .off, isCircle: false)
}

#Preview("Red circle") {
    LampView(lampColor: .red, isCircle: true)
}

#Preview("Red circle (Dark mode)") {
    LampView(lampColor: .red, isCircle: true)
        .preferredColorScheme(.dark)
}

#Preview("Yellow circle") {
    LampView(lampColor: .yellow, isCircle: true)
}

#Preview("Yellow circle (Dark mode)") {
    LampView(lampColor: .yellow, isCircle: true)
        .preferredColorScheme(.dark)
}
