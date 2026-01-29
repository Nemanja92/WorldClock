//
//  LocationRowView.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import SwiftUI

public struct LocationRowView: View {

    private let location: Location
    private let now: Date
    private let formatter: TimeFormattingService

    public init(
        location: Location,
        now: Date,
        formatter: TimeFormattingService
    ) {
        self.location = location
        self.now = now
        self.formatter = formatter
    }

    public var body: some View {
        LabeledContent(location.name, value: timeText)
    }

    private var timeText: String {
        formatter.formatTime(
            date: now,
            timezoneId: location.timezoneId,
            format: "HH:mm:ss"
        )
    }
}
