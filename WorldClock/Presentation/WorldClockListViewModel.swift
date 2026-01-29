//
//  WorldClockListViewModel.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation
import Combine

@MainActor
public final class WorldClockListViewModel: ObservableObject {

    // MARK: - Published

    @Published public private(set) var continents: [Continent] = []
    @Published public private(set) var now: Date = Date()
    @Published public private(set) var isLoading: Bool = false
    @Published public private(set) var errorMessage: String?

    // MARK: - Dependencies

    private let observeContinents: ObserveContinentsUseCase
    private let observeNow: ObserveNowUseCase

    // MARK: - Tasks

    private var nowTask: Task<Void, Never>?

    // MARK: - Init

    public init(
        observeContinents: ObserveContinentsUseCase,
        observeNow: ObserveNowUseCase
    ) {
        self.observeContinents = observeContinents
        self.observeNow = observeNow
    }

    deinit {
        nowTask?.cancel()
    }

    // MARK: - Public

    public func onStart() {
        loadContinentsIfNeeded()
        startNowStreamIfNeeded()
    }

    // MARK: - Private

    private func loadContinentsIfNeeded() {
        guard continents.isEmpty, !isLoading else { return }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let result = try await observeContinents.execute()
                self.continents = result
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to load data."
                self.isLoading = false
            }
        }
    }

    private func startNowStreamIfNeeded() {
        guard nowTask == nil else { return }

        nowTask = Task { [observeNow] in
            for await tick in observeNow.stream(every: 1) {
                if Task.isCancelled { break }
                self.now = tick
            }
        }
    }
}
