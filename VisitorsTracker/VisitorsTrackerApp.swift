//
//  VisitorsTrackerApp.swift
//  VisitorsTracker
//
//  Created by Ashish Chauhan on 11/06/24.
//

import SwiftUI
import SwiftData

@main
struct VisitorsTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Tower.self,
            Visitor.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .preferredColorScheme(.dark)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
