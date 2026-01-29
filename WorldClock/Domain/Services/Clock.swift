//
//  Clock.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import Foundation

public protocol Clock: Sendable {
    func nowStream(every intervalSeconds: Int) -> AsyncStream<Date>
}
