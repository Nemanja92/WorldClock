//
//  WorldClockTests.swift
//  WorldClockTests
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation
import Testing
@testable import WorldClock

@MainActor
struct WorldClockTests {

    // MARK: - DefaultTimeFormattingService

    @Test
    func formatTime_returnsExpectedString_whenTimezoneIsValid() {
        // Given
        let sut = DefaultTimeFormattingService()
        let date = Date(timeIntervalSince1970: 0) // 1970-01-01 00:00:00 UTC

        // When
        let result = sut.formatTime(
            date: date,
            timezoneId: "UTC",
            format: "HH:mm"
        )

        // Then
        #expect(result == "00:00")
    }

    @Test
    func formatTime_fallsBackToCurrentTimezone_whenTimezoneIsInvalid() {
        // Given
        let sut = DefaultTimeFormattingService()
        let date = Date(timeIntervalSince1970: 0)

        let expectedFormatter = DateFormatter()
        expectedFormatter.dateFormat = "HH:mm"
        expectedFormatter.locale = Locale(identifier: "en_US_POSIX")
        expectedFormatter.timeZone = .current
        let expected = expectedFormatter.string(from: date)

        // When
        let result = sut.formatTime(
            date: date,
            timezoneId: "invalid/timezone",
            format: "HH:mm"
        )

        // Then
        #expect(result == expected)
    }

    // MARK: - WorldClockListViewModel

    @Test
    func onStart_loadsContinentsSuccessfully() async {
        // Given
        let expectedContinents = [
            Continent(
                name: "Europe",
                locations: [
                    Location(name: "Belgrade", timezoneId: "Europe/Belgrade"),
                    Location(name: "London", timezoneId: "Europe/London")
                ]
            ),
            Continent(
                name: "North America",
                locations: [
                    Location(name: "New York", timezoneId: "America/New_York")
                ]
            )
        ]

        let sut = makeSUT(
            observeContinents: MockObserveContinentsUseCase(result: .success(expectedContinents)),
            observeNow: MockObserveNowUseCase(dates: [])
        )

        // When
        sut.onStart()

        // Then
        await waitUntil {
            sut.isLoading == false && sut.continents == expectedContinents
        }

        #expect(sut.continents == expectedContinents)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func onStart_setsErrorMessage_whenLoadingFails() async {
        // Given
        let sut = makeSUT(
            observeContinents: MockObserveContinentsUseCase(result: .failure(TestError.sample)),
            observeNow: MockObserveNowUseCase(dates: [])
        )

        // When
        sut.onStart()

        // Then
        await waitUntil {
            sut.isLoading == false && sut.errorMessage != nil
        }

        #expect(sut.continents.isEmpty)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == "Failed to load data.")
    }

    @Test
    func onStart_updatesNow_whenClockStreamEmitsValues() async {
        // Given
        let tick = Date(timeIntervalSince1970: 1_234_567)

        let sut = makeSUT(
            observeContinents: MockObserveContinentsUseCase(result: .success([])),
            observeNow: MockObserveNowUseCase(dates: [tick])
        )

        // When
        sut.onStart()

        // Then
        await waitUntil {
            sut.now == tick
        }

        #expect(sut.now == tick)
    }
}

// MARK: - Helpers

@MainActor
private func makeSUT(
    observeContinents: ObserveContinentsUseCase,
    observeNow: ObserveNowUseCase
) -> WorldClockListViewModel {
    WorldClockListViewModel(
        observeContinents: observeContinents,
        observeNow: observeNow
    )
}

@MainActor
private func waitUntil(
    timeoutNanoseconds: UInt64 = 1_000_000_000,
    pollIntervalNanoseconds: UInt64 = 10_000_000,
    condition: @escaping @MainActor () -> Bool
) async {
    let start = DispatchTime.now().uptimeNanoseconds

    while !condition() {
        let elapsed = DispatchTime.now().uptimeNanoseconds - start
        if elapsed > timeoutNanoseconds {
            Issue.record("Condition was not met within timeout.")
            return
        }

        try? await Task.sleep(nanoseconds: pollIntervalNanoseconds)
    }
}

// MARK: - Test Doubles

private enum TestError: Error, Sendable {
    case sample
}

private struct MockObserveContinentsUseCase: ObserveContinentsUseCase, Sendable {
    let result: Result<[Continent], Error>

    func execute() async throws -> [Continent] {
        try result.get()
    }
}

private struct MockObserveNowUseCase: ObserveNowUseCase, Sendable {
    let dates: [Date]

    func stream(every intervalSeconds: Int) -> AsyncStream<Date> {
        AsyncStream { continuation in
            for date in dates {
                continuation.yield(date)
            }
            continuation.finish()
        }
    }
}
