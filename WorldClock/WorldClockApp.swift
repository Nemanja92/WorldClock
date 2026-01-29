//
//  WorldClockApp.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import SwiftUI

@main
struct WorldClockApp: App {

    private let di = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            WorldClockListScreen(
                viewModel: di.makeWorldClockListViewModel(),
                formatter: di.makeTimeFormattingService()
            )
        }
    }
}
