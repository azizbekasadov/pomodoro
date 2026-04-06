//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import SwiftUI
import CoreData

@main
struct PomodoroApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
