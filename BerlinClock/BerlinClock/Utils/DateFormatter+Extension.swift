//
//  DateFormatter+Extension.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar = .current) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.timeZone = calendar.timeZone
    }
}
