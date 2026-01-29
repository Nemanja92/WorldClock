//
//  AppDIContainer.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation

public final class AppDIContainer {

    // MARK: - Data layer services

    private lazy var continentsRepository: ContinentsRepository = StaticContinentsRepository()
    private lazy var clock: Clock = SystemClock()
    private lazy var timeFormatter: TimeFormattingService = DefaultTimeFormattingService()

    // MARK: - Domain use cases

    private lazy var observeContinentsUseCase: ObserveContinentsUseCase =
        ObserveContinentsUseCaseImpl(repository: continentsRepository)

    private lazy var observeNowUseCase: ObserveNowUseCase =
        ObserveNowUseCaseImpl(clock: clock)

    // MARK: - Presentation factories

    public init() {}

    public func makeWorldClockListViewModel() -> WorldClockListViewModel {
        WorldClockListViewModel(
            observeContinents: observeContinentsUseCase,
            observeNow: observeNowUseCase
        )
    }

    public func makeTimeFormattingService() -> TimeFormattingService {
        timeFormatter
    }
}
