# WorldClock (Demo)

WorldClock is a small demo iOS app that displays the current time for selected cities across the world. It is intentionally simple and focused on clarity, structure, and modern Swift patterns.

## What It Uses
- SwiftUI for the UI
- MVVM for presentation logic
- A lightweight Clean Architecture split (Data / Domain / Presentation)
- Dependency Injection via a small `AppDIContainer`
- `AsyncStream` + `Timer` for live “now” updates
- `DateFormatter` caching for efficient time formatting

## Key Components
- `WorldClockApp.swift`: app entry point wiring the DI container.
- `AppDIContainer.swift`: creates services, use cases, and view models.
- `WorldClockListViewModel.swift`: drives the screen state and the ticking clock.
- `WorldClockListScreen.swift` + `LocationRowView.swift`: SwiftUI views.
- `SystemClock.swift`: provides a ticking `AsyncStream<Date>`.
- `DefaultTimeFormattingService.swift`: formats time per timezone with caching.
- `StaticContinentsRepository.swift` + `StaticContinentsData.swift`: demo data source.

## Interesting Bits
- The clock stream emits immediately so the UI does not wait for the first tick.
- Time formatting falls back to the current timezone if an ID is invalid.
- Clean separation makes it easy to swap the static repository for a real API.

## Notes
This is a demo project and intentionally avoids networking, persistence, and complex UI flows to keep the architecture easy to explore.
