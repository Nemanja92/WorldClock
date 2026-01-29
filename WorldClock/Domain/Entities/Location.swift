//
//  Location.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

public struct Location: Equatable, Sendable {
    public let name: String
    public let timezoneId: String

    public init(name: String, timezoneId: String) {
        self.name = name
        self.timezoneId = timezoneId
    }
}
