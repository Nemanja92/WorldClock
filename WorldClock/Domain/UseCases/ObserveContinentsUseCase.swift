//
//  ObserveContinentsUseCase.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

public protocol ObserveContinentsUseCase: Sendable {
    func execute() async throws -> [Continent]
}

public struct ObserveContinentsUseCaseImpl: ObserveContinentsUseCase {
    private let repository: ContinentsRepository

    public init(repository: ContinentsRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [Continent] {
        try await repository.fetchContinents()
    }
}
