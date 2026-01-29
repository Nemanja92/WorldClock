
//
//  WorldClockListScreen.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

import SwiftUI

public struct WorldClockListScreen: View {

    @StateObject private var viewModel: WorldClockListViewModel
    private let formatter: TimeFormattingService

    public init(
        viewModel: WorldClockListViewModel,
        formatter: TimeFormattingService
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.formatter = formatter
    }

    public var body: some View {
        NavigationStack {
            content
                .navigationTitle("World Clock")
        }
        .task {
            viewModel.onStart()
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.continents.isEmpty {
            ProgressView()
        } else if let message = viewModel.errorMessage, viewModel.continents.isEmpty {
            ContentUnavailableView(
                "Something went wrong",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        } else {
            list
        }
    }

    private var list: some View {
        List {
            ForEach(viewModel.continents, id: \.name) { continent in
                Section(continent.name) {
                    ForEach(continent.locations, id: \.name) { location in
                        LocationRowView(
                            location: location,
                            now: viewModel.now,
                            formatter: formatter
                        )
                    }
                }
            }
        }
    }
}
