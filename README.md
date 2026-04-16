# **WorldClock**

WorldClock is a small iOS demo app that shows the current time across selected cities around the world.

The goal of the project is not feature breadth, but to demonstrate a clean and readable SwiftUI codebase with a lightweight architecture, dependency injection, and continuously updating time data.

## **Highlights**

- SwiftUI-based UI
  
- MVVM for presentation logic
  
- Lightweight Clean Architecture split across Data, Domain, and Presentation
  
- Dependency injection through a small AppDIContainer
  
- AsyncStream + Timer for live clock updates
  
- Cached DateFormatter instances for more efficient time formatting
  

## **Architecture**

The project is intentionally structured to keep responsibilities clear and easy to follow:

- **Presentation** contains SwiftUI screens and view models
  
- **Domain** contains the business models and use cases
  
- **Data** contains concrete services and repositories
  

This keeps the app simple to explore while still showing how the same structure could scale to a larger feature.

## **Key Parts**

- WorldClockApp.swift
  
  App entry point that wires the dependency container
  
- AppDIContainer.swift
  
  Creates and assembles services, repositories, use cases, and view models
  
- WorldClockListViewModel.swift
  
  Manages screen state and reacts to the ticking clock stream
  
- SystemClock.swift
  
  Exposes a live AsyncStream<Date> so the UI can stay in sync with the current time
  
- DefaultTimeFormattingService.swift
  
  Formats time values by timezone and reuses cached DateFormatter instances
  
- StaticContinentsRepository.swift and StaticContinentsData.swift
  
  Provide the demo data source used by the app
  

## **Implementation Notes**

A few details in the app are intentionally designed to keep the experience responsive and the code practical:

- The clock stream emits immediately so the UI does not wait for the first timer tick
  
- Time formatting falls back to the current timezone if an invalid timezone identifier is provided
  
- The repository layer can be swapped later for a real API without changing the presentation layer
  

## **Why This Project**

This project was built as a small, focused demo to show:

- clean separation of responsibilities
  
- simple dependency injection
  
- live time-based updates using modern Swift concurrency tools
  
- an approachable architecture that can grow without becoming over-engineered
  

## **Notes**

This is intentionally a small demo project. It avoids networking, persistence, and more complex flows so the core structure is easy to understand at a glance.
