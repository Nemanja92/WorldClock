//
//  TimeFormattingService.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation

public protocol TimeFormattingService: Sendable {
    /// Returns a formatted time string for the given date in the provided timezone ID.
    /// If timezoneId is invalid, it should fall back to a safe default (usually current timezone).
    func formatTime(
        date: Date,
        timezoneId: String,
        format: String
    ) -> String
}
