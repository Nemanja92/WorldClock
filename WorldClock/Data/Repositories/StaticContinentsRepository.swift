//
//  StaticContinentsRepository.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

public struct StaticContinentsRepository: ContinentsRepository {

    public init() {}

    public func fetchContinents() async throws -> [Continent] {
        StaticContinentsData.continents
    }
}
