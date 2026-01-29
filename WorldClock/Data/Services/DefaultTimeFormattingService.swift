//
//  DefaultTimeFormattingService.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation

public final class DefaultTimeFormattingService: TimeFormattingService {

    // Cache formattera po (timezoneId + format)
    private var cache: [CacheKey: DateFormatter] = [:]
    private let lock = NSLock()

    public init() {}

    public func formatTime(
        date: Date,
        timezoneId: String,
        format: String
    ) -> String {
        let formatter = formatter(for: timezoneId, format: format)
        return formatter.string(from: date)
    }

    // MARK: - Private

    private func formatter(for timezoneId: String, format: String) -> DateFormatter {
        let key = CacheKey(timezoneId: timezoneId, format: format)

        lock.lock()
        defer { lock.unlock() }

        if let cached = cache[key] {
            return cached
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")

        if let timeZone = TimeZone(identifier: timezoneId) {
            formatter.timeZone = timeZone
        } else {
            formatter.timeZone = .current
        }

        cache[key] = formatter
        return formatter
    }
}

// MARK: - CacheKey

private struct CacheKey: Hashable {
    let timezoneId: String
    let format: String
}
