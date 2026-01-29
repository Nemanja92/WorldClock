//
//  ContinentsRepository.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

public protocol ContinentsRepository: Sendable {
    func fetchContinents() async throws -> [Continent]
}
