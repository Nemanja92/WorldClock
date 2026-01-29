//
//  ObserveNowUseCase.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation

public protocol ObserveNowUseCase: Sendable {
    func stream(every intervalSeconds: Int) -> AsyncStream<Date>
}

public struct ObserveNowUseCaseImpl: ObserveNowUseCase {
    private let clock: Clock

    public init(clock: Clock) {
        self.clock = clock
    }

    public func stream(every intervalSeconds: Int) -> AsyncStream<Date> {
        clock.nowStream(every: intervalSeconds)
    }
}
