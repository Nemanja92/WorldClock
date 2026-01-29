//
//  SystemClock.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation

public final class SystemClock: Clock {

    public init() {}

    public func nowStream(every intervalSeconds: Int) -> AsyncStream<Date> {
        AsyncStream { continuation in
            let interval = TimeInterval(intervalSeconds)

            let timer = Timer.scheduledTimer(
                withTimeInterval: interval,
                repeats: true
            ) { _ in
                continuation.yield(Date())
            }

            RunLoop.main.add(timer, forMode: .common)
            // Emit immediately so UI doesn't wait 1s for first value
            continuation.yield(Date())

            continuation.onTermination = { _ in
                timer.invalidate()
            }
        }
    }
}
