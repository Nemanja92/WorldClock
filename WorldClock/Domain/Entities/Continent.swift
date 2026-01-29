//
//  Continent.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

public struct Continent: Equatable, Sendable {
    public let name: String
    public let locations: [Location]

    public init(name: String, locations: [Location]) {
        self.name = name
        self.locations = locations
    }
}
